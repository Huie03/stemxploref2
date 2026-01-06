import 'package:flutter/material.dart';
import 'package:stemxploref2/learning_materials/material_details_page.dart';
import '../widgets/solid_background.dart';
import 'package:provider/provider.dart';
import '/navigation_provider.dart';
import 'package:stemxploref2/widgets/curved_navigation_bar.dart';

class LearningMaterialPage extends StatefulWidget {
  static const routeName = '/learning-materials';
  const LearningMaterialPage({super.key});

  @override
  State<LearningMaterialPage> createState() => _LearningMaterialPageState();
}

class _LearningMaterialPageState extends State<LearningMaterialPage> {
  // Track the selected category
  String selectedCategory = "All";

  // Materials data
  final List<Map<String, String>> materials = [
    {
      "title": "Science Form 2",
      "subtitle": "Chapter 3",
      "category": "Science",
      "image": 'assets/images/science_book_cover.png',
    },
    {
      "title": "Mathematics Form 2",
      "subtitle": "Chapter 1",
      "category": "Mathematics",
      "image": 'assets/images/math_book_cover.png',
    },
    {
      "title": "Asas Sains Komputer Form 2",
      "subtitle": "Chapter 1",
      "category": "Asas Sains Komputer",
      "image": 'assets/images/ask_book_cover.png',
    },
    {
      "title": "Reka Bentuk Dan Teknologi Form 2",
      "subtitle": "Chapter 1",
      "category": "Reka Bentuk Dan Teknologi",
      "image": 'assets/images/rbt_book_cover.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter the list based on selection
    final filteredMaterials = selectedCategory == "All"
        ? materials
        : materials.where((m) => m['category'] == selectedCategory).toList();

    return Scaffold(
      body: SolidBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: const Text(
                  'Learning Material',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Favorite",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Example favorite card
                      _buildMaterialCard(
                        context,
                        title: "Science Form 2",
                        subtitle: "Chapter 3",
                        imagePath: 'assets/images/science_book_cover.png',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MaterialDetailPage(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),
                      _buildCategoryTabs(),
                      const SizedBox(height: 15),

                      // Dynamic list of filtered cards
                      ...filteredMaterials.map((item) {
                        return _buildMaterialCard(
                          context,
                          title: item['title']!,
                          subtitle: item['subtitle']!,
                          imagePath: item['image']!,
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppCurvedNavBar(
        currentIndex: 0,
        onTap: (index) {
          Provider.of<NavigationProvider>(
            context,
            listen: false,
          ).setIndex(index);

          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  Widget _buildCategoryTabs() {
    List<String> categories = [
      "All",
      "Science",
      "Mathematics",
      "Asas Sains Komputer",
      "Reka Bentuk Dan Teknologi",
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories
            .map((cat) => _tabItem(cat, selectedCategory == cat))
            .toList(),
      ),
    );
  }

  Widget _tabItem(String label, bool active) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: active ? Colors.black : Colors.black12,
            width: active ? 1.5 : 0.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: active ? Colors.black : Colors.black54,
          ),
        ),
      ),
    );
  }

  // _buildMaterialCard method
  Widget _buildMaterialCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String imagePath,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            Container(
              width: 85,
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
