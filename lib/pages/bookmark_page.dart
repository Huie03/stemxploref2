import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxploref2/widgets/solid_background.dart';

class BookmarkPage extends StatefulWidget {
  static const String routeName = '/bookmark';
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final List<Map<String, String>> _bookmarks = [
    {"title": "Science", "chapter": "Chapter 3"},
    {"title": "Science", "chapter": "Chapter 2"},
  ];

  @override
  void initState() {
    super.initState();
    // This tells the page: "Whenever the global language changes, rebuild yourself"
    FlutterLocalization.instance.onTranslatedLanguage = (_) {
      if (mounted) setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    // Handle null safety for currentLocale
    final Locale? currentLocale = localization.currentLocale;
    final bool isEnglish =
        currentLocale?.languageCode == 'en' || currentLocale == null;
    final String title = isEnglish ? "Bookmark" : "Penanda Buku";

    return Scaffold(
      body: SolidBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildCustomAppBar(title, isEnglish, localization),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        isEnglish
                            ? "Last access learning materials:"
                            : "Bahan pembelajaran terakhir dicapai:",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _bookmarks.length,
                        itemBuilder: (context, index) {
                          final String rawTitle = _bookmarks[index]["title"]!;
                          final String rawChapter =
                              _bookmarks[index]["chapter"]!;

                          String displayTitle =
                              (rawTitle == "Science" && !isEnglish)
                              ? "Sains"
                              : rawTitle;
                          String displayChapter = isEnglish
                              ? rawChapter
                              : rawChapter.replaceAll("Chapter", "Bab");

                          return _buildSlidableCard(
                            index,
                            displayTitle,
                            displayChapter,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                height: 20,
                indent: 12,
                endIndent: 12,
              ),
              _buildCareerResult(isEnglish),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(
    String title,
    bool isEnglish,
    FlutterLocalization localization,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 50),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          PopupMenuButton<String>(
            elevation: 2,
            position: PopupMenuPosition.under,
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2), // Updated
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  key: ValueKey<bool>(isEnglish),
                  isEnglish
                      ? 'assets/flag/language us_flag.png'
                      : 'assets/flag/language ms_flag.png',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onSelected: (value) {
              setState(() {
                localization.translate(value);
              });
            },
            itemBuilder: (context) => [
              _buildPopupMenuItem('en', 'English (Default)', isEnglish),
              _buildPopupMenuItem('ms', 'Malay', !isEnglish),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
    String value,
    String text,
    bool isSelected,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Text(text, style: const TextStyle(fontSize: 14)),
          if (isSelected) ...[
            const Spacer(),
            const Icon(Icons.check_circle, color: Colors.green, size: 20),
          ],
        ],
      ),
    );
  }

  Widget _buildSlidableCard(int index, String title, String chapter) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Slidable(
        key: ValueKey(_bookmarks[index]),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) =>
                  setState(() => _bookmarks.removeAt(index)),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35), // Updated
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(chapter),
            trailing: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/science_book_cover.png',
                width: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.book, size: 50, color: Colors.orange),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCareerResult(bool isEnglish) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEnglish
                ? "Interest–career matching result:"
                : "Keputusan padanan minat-kerjaya:",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2), // Updated
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  isEnglish
                      ? "Your top STEM field is Science."
                      : "Bidang STEM utama anda ialah Sains.",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isEnglish
                      ? "Suggested careers: Biologist,\nChemist, Physicist."
                      : "Cadangan kerjaya: Ahli Biologi,\nAhli Kimia, Ahli Fizik.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
