import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:stemxploref2/widgets/gradient_background.dart';
import 'package:stemxploref2/widgets/language_toggle.dart';
import 'package:stemxploref2/widgets/rawscrollbar.dart';
import '../navigation_provider.dart';
import '../ipaddress.dart';
import '../stem_career/career_quiz.dart';

class StemCareersPage extends StatefulWidget {
  static const routeName = '/stem-careers';
  const StemCareersPage({super.key});

  @override
  State<StemCareersPage> createState() => _StemCareersPageState();
}

class _StemCareersPageState extends State<StemCareersPage> {
  bool _showQuiz = false;
  bool _showResults = false;
  bool _isExploreAllMode = false;
  bool _isLoading = true;
  String? _errorMessage;
  bool _isAlreadyReset = false;

  final ScrollController _scrollController = ScrollController();
  final ScrollController _exploreScrollController = ScrollController();

  int _expandedIndex = -1;
  List<dynamic> _dbQuestions = [];
  List<dynamic> _allCareers = [];
  final Map<int, int> _singleChoices = {};
  final Set<int> _multiChoicesQ5 = {};

  @override
  void dispose() {
    _scrollController.dispose();
    _exploreScrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final navProvider = Provider.of<NavigationProvider>(context);
    if (navProvider.currentIndex == 7) {
      if (!_isAlreadyReset) {
        _resetState();
        _isAlreadyReset = true;
      }
    } else {
      _isAlreadyReset = false;
    }
  }

  void _resetState() {
    setState(() {
      _showQuiz = false;
      _showResults = false;
      _isExploreAllMode = false;
      _expandedIndex = -1;
      _singleChoices.clear();
      _multiChoicesQ5.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final url = Uri.parse('${ipadress.baseUrl}fetch_quiz.php');
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _dbQuestions = data['questions'] ?? [];
          _allCareers = data['careers'] ?? [];
          _isLoading = false;
        });
      } else {
        _handleLoadError("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      _handleLoadError("Connection Failed!\nMake sure XAMPP is running.");
    }
  }

  void _handleLoadError(String msg) {
    setState(() {
      _errorMessage = msg;
      _isLoading = false;
    });
  }

  Future<void> _saveResult(String field) async {
    final List<int> allChoices = [..._singleChoices.values, ..._multiChoicesQ5];
    try {
      await http.post(
        Uri.parse('${ipadress.baseUrl}save_result.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "final_field": field,
          "selected_options": allChoices.join(','),
        }),
      );
    } catch (e) {
      debugPrint("Save error: $e");
    }
  }

  String _calculateSuggestedField() {
    int science = 0, math = 0, engineering = 0, tech = 0;
    void applyScore(String? tag, int weight) {
      if (tag == null) return;
      String t = tag.toLowerCase();
      if (t.contains('sci'))
        science += weight;
      else if (t.contains('tech'))
        tech += weight;
      else if (t.contains('eng'))
        engineering += weight;
      else if (t.contains('math'))
        math += weight;
      else if (t == 'all') {
        science += weight;
        math += weight;
        engineering += weight;
        tech += weight;
      }
    }

    for (var entry in _singleChoices.entries) {
      final q = _dbQuestions.firstWhere(
        (e) => e['id'].toString() == entry.key.toString(),
        orElse: () => null,
      );
      if (q != null) {
        final opt = (q['options'] as List).firstWhere(
          (o) => o['id'].toString() == entry.value.toString(),
          orElse: () => null,
        );
        if (opt != null) applyScore(opt['score_tag'], 2);
      }
    }

    if (_dbQuestions.isNotEmpty) {
      final qSkills = _dbQuestions.last;
      for (var optId in _multiChoicesQ5) {
        final opt = (qSkills['options'] as List).firstWhere(
          (o) => o['id'].toString() == optId.toString(),
          orElse: () => null,
        );
        if (opt != null) applyScore(opt['score_tag'], 1);
      }
    }
    var scores = {
      'Science': science,
      'Mathematics': math,
      'Engineering': engineering,
      'Technology': tech,
    };
    return scores.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  Color _getStemColor(String? categoryEn, BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    switch (categoryEn) {
      case 'Science':
        return isDark ? Colors.greenAccent.shade400 : Colors.green.shade700;
      case 'Technology':
        return isDark ? Colors.blueAccent.shade200 : Colors.blue.shade700;
      case 'Engineering':
        return isDark ? Colors.orangeAccent.shade200 : Colors.orange.shade700;
      case 'Mathematics':
        return isDark ? Colors.purpleAccent.shade100 : Colors.purple.shade700;
      default:
        return isDark ? Colors.grey.shade400 : Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final bool isEn = navProvider.locale.languageCode == 'en';
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildCustomAppBar(isEn, isDark),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildCurrentView(isEn, context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentView(bool isEn, BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null && (_showQuiz || _isExploreAllMode)) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_errorMessage!, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            StemQuizDesign.actionButton(
              context,
              isEn ? "Try Again" : "Cuba Lagi",
              _loadData,
            ),
            if (!_showQuiz) ...[
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => setState(() => _errorMessage = null),
                child: Text(isEn ? "Back" : "Kembali"),
              ),
            ],
          ],
        ),
      );
    }

    if (_isExploreAllMode) return _buildExploreAllView(isEn, context);
    if (_showResults) return _buildResultsView(isEn, context);

    if (_showQuiz && _dbQuestions.isNotEmpty) {
      return _buildFullQuiz(isEn, context);
    }

    return _buildStartCard(isEn, context);
  }

  Widget _buildCustomAppBar(bool isEn, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isEn ? 'STEM Career' : 'Kerjaya STEM',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const LanguageToggle(),
        ],
      ),
    );
  }

  Widget _buildStartCard(bool isEn, BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: StemQuizDesign.buildContainer(
        context: context,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEn
                  ? "Discover Your STEM Skills & Explore Careers"
                  : "Temui Kemahiran STEM & Teroka Kerjaya",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              isEn
                  ? "Answer questions to see which STEM\nfield fits you best."
                  : "Jawab soalan untuk melihat bidang STEM\nyang paling sesuai untuk anda.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark
                    ? Colors.white70
                    : Colors.black.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 25),
            StemQuizDesign.actionButton(context, isEn ? "Start" : "Mula", () {
              if (_dbQuestions.isEmpty) _loadData();
              setState(() => _showQuiz = true);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildFullQuiz(bool isEn, BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final singleChoiceQs = _dbQuestions.sublist(0, 4);
    final q5 = _dbQuestions[4];
    double progress =
        (_singleChoices.length + (_multiChoicesQ5.isNotEmpty ? 1 : 0)) / 5;
    bool allAnswered =
        (_singleChoices.length == 4 && _multiChoicesQ5.isNotEmpty);

    return StemQuizDesign.buildContainer(
      context: context,
      child: Column(
        children: [
          _buildProgressBar(isEn, progress, context),
          Expanded(
            child: AppRawScrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...singleChoiceQs.map(
                        (q) => _buildDynamicSingleChoice(q, isEn, context),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        isEn ? q5['q_text_en'] : q5['q_text_ms'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildMultiSelectGrid(q5, isEn, context),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: StemQuizDesign.actionButton(
              context,
              isEn ? "Done" : "Selesai",
              allAnswered ? () => _handleQuizCompletion(isEn) : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsView(bool isEn, BuildContext context) {
    final String fieldEn = _calculateSuggestedField();
    final List filtered = _allCareers
        .where((c) => c['category_en'] == fieldEn)
        .toList();
    final Color suggestedColor = _getStemColor(fieldEn, context);

    return SingleChildScrollView(
      child: StemQuizDesign.buildContainer(
        context: context,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Column(
          children: [
            Text(
              isEn
                  ? "You’ve Finished Your\nCareer Discovery!"
                  : "Anda Telah Menamatkan\nPenemuan Kerjaya Anda!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const SizedBox(height: 25),
            _buildSuggestedFieldText(isEn, fieldEn, suggestedColor),
            const SizedBox(height: 15),
            ...List.generate(filtered.length, (index) {
              final career = filtered[index];
              final bool isExpanded = _expandedIndex == index;
              return Column(
                children: [
                  StemQuizDesign.careerExpandableTile(
                    context,
                    (isEn ? career['career_en'] : career['career_ms']) ??
                        'Untitled',
                    isExpanded,
                    () => setState(
                      () => _expandedIndex = isExpanded ? -1 : index,
                    ),
                  ),
                  if (isExpanded)
                    _buildMindMapPlaceholder(
                      career.cast<String, dynamic>(),
                      isEn,
                    ),
                  const SizedBox(height: 12),
                ],
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StemQuizDesign.actionButton(
                  context,
                  isEn ? "Explore All" : "Teroka Semua",
                  () => setState(() {
                    _isExploreAllMode = true;
                    _expandedIndex = -1;
                  }),
                ),
                StemQuizDesign.actionButton(
                  context,
                  isEn ? "Replay" : "Main Semula",
                  _resetState,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreAllView(bool isEn, BuildContext context) {
    final List<String> stemOrder = [
      'Science',
      'Technology',
      'Engineering',
      'Mathematics',
    ];
    List<dynamic> sortedCareers = List.from(_allCareers);
    sortedCareers.sort((a, b) {
      int indexA = stemOrder.indexOf(a['category_en'] ?? '');
      int indexB = stemOrder.indexOf(b['category_en'] ?? '');
      return indexA.compareTo(indexB == -1 ? 99 : indexB);
    });

    return StemQuizDesign.buildContainer(
      context: context,
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Column(
        children: [
          Expanded(
            child: AppRawScrollbar(
              controller: _exploreScrollController,
              child: ListView.builder(
                controller: _exploreScrollController,
                padding: const EdgeInsets.only(right: 20),
                itemCount: sortedCareers.length,
                itemBuilder: (context, index) {
                  final career = sortedCareers[index];
                  final String rawCat = career['category_en'] ?? '';
                  bool showHeader =
                      index == 0 ||
                      rawCat != sortedCareers[index - 1]['category_en'];
                  final bool isExpanded = _expandedIndex == index;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showHeader)
                        _buildCategoryHeader(
                          isEn ? rawCat : (career['category_ms'] ?? rawCat),
                          rawCat,
                        ),
                      StemQuizDesign.careerExpandableTile(
                        context,
                        isEn ? career['career_en'] : career['career_ms'],
                        isExpanded,
                        () => setState(
                          () => _expandedIndex = isExpanded ? -1 : index,
                        ),
                      ),
                      if (isExpanded)
                        _buildMindMapPlaceholder(
                          career.cast<String, dynamic>(),
                          isEn,
                        ),
                      const SizedBox(height: 12),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.bottomRight,
            child: StemQuizDesign.actionButton(
              context,
              isEn ? "Exit" : "Keluar",
              () => setState(() {
                _isExploreAllMode = false;
                _expandedIndex = -1;
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(bool isEn, double progress, BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEn ? "Progress" : "Kemajuan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: isDark ? Colors.white10 : Colors.grey.shade300,
              color: isDark ? const Color(0xFFEFA638) : Colors.green,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isEn ? "Scroll down to see more" : "Skrol ke bawah untuk lagi",
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? const Color.fromARGB(255, 220, 219, 219)
                  : const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicSingleChoice(
    Map<String, dynamic> q,
    bool isEn,
    BuildContext context,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    int qId = int.parse(q['id'].toString());
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEn ? (q['q_text_en'] ?? '') : (q['q_text_ms'] ?? ''),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          ...(q['options'] as List).map((opt) {
            int optId = int.parse(opt['id'].toString());
            return _buildOptionRow(
              context: context,
              label: isEn
                  ? (opt['opt_text_en'] ?? '')
                  : (opt['opt_text_ms'] ?? ''),
              isSelected: _singleChoices[qId] == optId,
              onTap: () => setState(() => _singleChoices[qId] = optId),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMultiSelectGrid(Map q5, bool isEn, BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.8,
        mainAxisSpacing: 8,
        crossAxisSpacing: 10,
      ),
      itemCount: (q5['options'] as List).length,
      itemBuilder: (context, index) {
        final opt = q5['options'][index];
        int optId = int.parse(opt['id'].toString());
        bool selected = _multiChoicesQ5.contains(optId);
        return _buildOptionRow(
          context: context,
          label: isEn ? (opt['opt_text_en'] ?? '') : (opt['opt_text_ms'] ?? ''),
          isSelected: selected,
          onTap: () => setState(
            () => selected
                ? _multiChoicesQ5.remove(optId)
                : _multiChoicesQ5.add(optId),
          ),
        );
      },
    );
  }

  Widget _buildOptionRow({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color darkAccent = Color(0xFFEFA638);
    const Color darkUnselected = Colors.white38;
    const Color darkText = Colors.white;

    const Color lightAccent = Color.fromARGB(255, 7, 111, 238);
    const Color lightUnselected = Colors.black54;
    const Color lightText = Colors.black;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 20,
              color: isSelected
                  ? (isDark ? darkAccent : lightAccent)
                  : (isDark ? darkUnselected : lightUnselected),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected
                      ? (isDark ? darkAccent : lightAccent)
                      : (isDark ? darkText : lightText),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(String displayName, String rawCategoryEn) {
    Color headerColor = _getStemColor(rawCategoryEn, context);
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10, left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayName.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: headerColor,
              letterSpacing: 1.2,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 3,
            width: 35,
            color: headerColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedFieldText(bool isEn, String fieldEn, Color color) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
          ),
          children: [
            TextSpan(text: isEn ? "Suggest field: " : "Bidang dicadangkan: "),
            TextSpan(
              text: fieldEn,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMindMapPlaceholder(Map<String, dynamic> career, bool isEn) {
    final String? imageUrl = isEn
        ? career['image_en_url']
        : career['image_ms_url'];
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: imageUrl != null && imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) => const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Image Error"),
                ),
              )
            : const Padding(
                padding: EdgeInsets.all(20),
                child: Text("No image"),
              ),
      ),
    );
  }

  void _handleQuizCompletion(bool isEn) {
    if (_multiChoicesQ5.length < 3) {
      _showSkillReminder(context, isEn);
    } else {
      String res = _calculateSuggestedField();
      _saveResult(res);
      setState(() => _showResults = true);
    }
  }

  void _showSkillReminder(BuildContext context, bool isEn) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.info_outline, color: Colors.red, size: 35),
              const SizedBox(height: 12),
              Text(
                isEn
                    ? "Please select at least 3 skills in question 5."
                    : "Sila pilih sekurang-kurangnya 3 kemahiran dalam soalan 5.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 20),
              StemQuizDesign.actionButton(
                context,
                isEn ? "OK" : "OK",
                () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
