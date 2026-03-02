import 'package:flutter_localization/flutter_localization.dart';

// The Map of Locales for main.dart
const List<MapLocale> LOCALES = [
  MapLocale('en', EN_DATA),
  MapLocale('ms', MS_DATA),
];

// ENGLISH DATA
const Map<String, dynamic> EN_DATA = {
  'home_title': 'STEMXplore F2',
  'info_title': 'Info',
  'bookmark_title': 'Bookmark',
  'last_access': 'Last access learning materials:',
  'science': 'Science',
  'chapter': 'Chapter',
  'career_match': 'Interest–career matching result:',
  'stemInfo': 'STEM Info',
  'learning': 'Learning Material',
  'quiz': 'Quiz Game',
  'careers': 'STEM Careers',
  'challenge': 'Daily Challenge',
  'faq': 'Frequent Asked Questions',
  'highlights': 'STEM Highlights:',
  'read_more': 'Read more',
  'info_desc': 'STEMXplore F2 is a mobile learning application...',
  // FAQ LIST
  'faqs': [
    {
      'q': 'Why is STEM important for students?',
      'a': 'STEM helps students develop thinking and problem-solving skills.',
    },
    {
      'q': 'How is STEM used in real life?',
      'a':
          'STEM is used in healthcare, transportation, communication, and technology.',
    },
    {
      'q': 'What is the role of science in STEM?',
      'a':
          'Science helps us understand natural phenomena through observation and experiments.',
    },
    {
      'q': 'How does technology support learning?',
      'a':
          'Technology provides tools like apps, simulations, and online resources.',
    },
    {
      'q': 'What does engineering involve?',
      'a':
          'Engineering focuses on designing and improving systems, tools, and structures.',
    },
    {
      'q': 'Why is mathematics important in STEM?',
      'a':
          'Mathematics helps in calculations, measurements, and data analysis.',
    },
    {
      'q': 'What skills can students gain from STEM?',
      'a': 'Critical thinking, communication, and collaboration skills.',
    },
    {
      'q': 'How can students improve their STEM performance?',
      'a': 'By practicing, asking questions, and participating actively.',
    },
    {
      'q': 'Why should students focus on STEM?',
      'a':
          'Because it builds strong foundations for higher learning and future careers.',
    },
    {
      'q': 'Do I need to be good at all STEM subjects?',
      'a':
          'No. Students can be stronger in some areas and improve others with practice.',
    },
  ],

  // DAILY INFO LIST
  'daily_info': [
    {
      'title': 'Nutrition',
      'fact':
          'Carbohydrates are the main source of energy for our body and help us stay active.',
      'image': 'assets/images/nutrition.png',
    },
    {
      'title': 'Biodiversity',
      'fact':
          'Biodiversity refers to the variety of living organisms in a habitat and helps keep ecosystems stable.',
      'image': 'assets/images/biodiversity.png',
    },
    {
      'title': 'Ecosystem',
      'fact':
          'An ecosystem is a community of living organisms interacting with each other and their environment.',
      'image': 'assets/images/ecosystem.png',
    },
  ],
  // QUIZ UI & RESULTS
  'quiz_start_title': 'Discover Your STEM Skills',
  'quiz_start_desc': 'Answer questions to see which STEM field fits you best.',
  'quiz_next': 'Next',
  'quiz_back': 'Back',
  'quiz_done': 'Done',
  'quiz_finish_title': 'You’ve Finished Your\nCareer Discovery!',
  'suggested_field': 'Suggested field:',
  'explore_all': 'Explore All',
  'replay': 'Replay',
  'skill_reminder': 'Please select at least 3 skills.',

  // CAREER FIELDS
  'field_science': 'Science',
  'field_math': 'Mathematics',
  'field_eng': 'Engineering',
  'field_tech': 'Technology',

  // MIND MAP TEXTS
  'mind_map_label': 'Mind map image for',

  //STEM info page
  'stem_data_list': [
    {
      'type': 'video',
      'title': 'Video: STEM Meaning',
      'preview':
          'Learn what STEM means and how Science, Technology, Engineering, and Math work together. '
          'See simple examples of how STEM is used in real life.\n\n'
          'This video also shows how students can apply STEM concepts in everyday activities and projects, '
          'making learning fun and interactive.',
      'videoUrl': 'https://youtu.be/wRV28EOCGGo?si=i7nfreNgNU1jF1J8',
      'previewImage': 'assets/stem_info/STEM_video1.png',
      'source': 'What is STEM? – STEM Best Practice, 20 June 2017',
    },
    {
      'type': 'image',
      'title': 'Importance of STEM',
      'preview':
          'STEM is important because it helps students understand the world, encourages innovation, and equips them with skills for modern jobs.',
      'detailImage': 'assets/stem_info/Info2_en.png',
    },
    {
      'type': 'image',
      'title': 'STEM Careers',
      'previewImage': 'assets/stem_info/info3.png',
      'detailImage': 'assets/stem_info/Info3_en.png',
    },
    {
      'type': 'image',
      'title': 'STEM in Every Day',
      'previewImage': 'assets/stem_info/info4.png',
      'detailImage': 'assets/stem_info/Info4_en.png',
    },
    {
      'type': 'video',
      'title': 'Video: The Most Fun STEM Projects',
      'preview':
          'This video shows how Science, Technology, Engineering, and Math work together to solve real-world problems.\n\n'
          'See examples of STEM in everyday life and how students can explore STEM through fun projects and challenges.',
      'videoUrl': 'https://www.youtube.com/watch?v=Ml52O3miJKw',
      'previewImage': 'assets/stem_info/STEMvideo2.png',
      'source': 'The Most Fun STEM Projects - GUITAR KIT WORLD, \n6 Jul 2023',
    },
  ],
};

// MALAY DATA
const Map<String, dynamic> MS_DATA = {
  'home_title': 'STEMXplore F2',
  'info_title': 'Maklumat',
  'bookmark_title': 'Penanda Buku',
  'last_access': 'Bahan pembelajaran terakhir dicapai:',
  'science': 'Sains',
  'chapter': 'Bab',
  'career_match': 'Keputusan padanan minat-kerjaya:',
  'stemInfo': 'Info STEM',
  'learning': 'Bahan Pembelajaran',
  'quiz': 'Permainan Kuiz',
  'careers': 'Kerjaya STEM',
  'challenge': 'Cabaran Harian',
  'faq': 'Soalan Lazim',
  'highlights': 'Sorotan STEM:',
  'read_more': 'Baca lagi',
  'info_desc': 'STEMXplore F2 adalah aplikasi pembelajaran mudah alih...',
  // FAQ LIST
  'faqs': [
    {
      'q': 'Mengapa STEM penting untuk murid?',
      'a':
          'STEM membantu murid membina kemahiran berfikir dan penyelesaian masalah.',
    },
    {
      'q': 'Bagaimanakah STEM digunakan dalam kehidupan?',
      'a':
          'STEM digunakan dalam kesihatan, pengangkutan, komunikasi, dan teknologi.',
    },
    {
      'q': 'Apakah peranan sains dalam STEM?',
      'a':
          'Sains membantu kita memahami fenomena alam melalui pemerhatian dan eksperimen.',
    },
    {
      'q': 'Bagaimanakah teknologi menyokong pembelajaran?',
      'a':
          'Teknologi menyediakan alatan seperti aplikasi, simulasi, dan sumber dalam talian.',
    },
    {
      'q': 'Apakah yang melibatkan kejuruteraan?',
      'a':
          'Kejuruteraan fokus kepada reka bentuk dan menambah baik sistem, alatan, dan struktur.',
    },
    {
      'q': 'Mengapa matematik penting dalam STEM?',
      'a': 'Matematik membantu dalam pengiraan, ukuran, dan analisis data.',
    },
    {
      'q': 'Apakah kemahiran yang diperoleh murid daripada STEM?',
      'a': 'Kemahiran berfikir kritis, komunikasi, dan kolaborasi.',
    },
    {
      'q': 'Bagaimana murid boleh meningkatkan prestasi STEM?',
      'a':
          'Dengan berlatih, bertanya soalan, dan mengambil bahagian secara aktif.',
    },
    {
      'q': 'Mengapa murid perlu fokus kepada STEM?',
      'a':
          'Kerana ia membina asas yang kukuh untuk pembelajaran tinggi dan kerjaya masa depan.',
    },
    {
      'q': 'Adakah saya perlu mahir dalam semua subjek STEM?',
      'a':
          'Tidak. Murid boleh menjadi lebih kuat dalam sesetengah bidang dan memperbaiki yang lain dengan latihan.',
    },
  ],

  // DAILY INFO LIST
  'daily_info': [
    {
      'title': 'Nutrisi',
      'fact':
          'Karbohidrat adalah sumber tenaga utama bagi tubuh kita dan membantu kita kekal aktif.',
      'image': 'assets/images/nutrition.png',
    },
    {
      'title': 'Kepelbagaian Biologi',
      'fact':
          'Kepelbagaian biologi merujuk kepada kepelbagaian organisma hidup dalam sesuatu habitat.',
      'image': 'assets/images/biodiversity.png',
    },
    {
      'title': 'Ekosistem',
      'fact':
          'Ekosistem ialah komuniti organisma hidup yang berinteraksi antara satu sama lain dan persekitaran.',
      'image': 'assets/images/ecosystem.png',
    },
  ],

  // QUIZ UI & KEPUTUSAN
  'quiz_start_title': 'Temui Kemahiran STEM Anda',
  'quiz_start_desc':
      'Jawab soalan untuk melihat bidang STEM yang paling sesuai untuk anda.',
  'quiz_next': 'Seterusnya',
  'quiz_back': 'Kembali',
  'quiz_done': 'Siap',
  'quiz_finish_title': 'Anda Telah Menamatkan\nPenemuan Kerjaya Anda!',
  'suggested_field': 'Bidang dicadangkan:',
  'explore_all': 'Teroka Semua',
  'replay': 'Main Semula',
  'skill_reminder': 'Sila pilih sekurang-kurangnya 3 kemahiran.',

  // BIDANG KERJAYA
  'field_science': 'Sains',
  'field_math': 'Matematik',
  'field_eng': 'Kejuruteraan',
  'field_tech': 'Teknologi',

  // TEKS PETA MINDA
  'mind_map_label': 'Imej peta minda untuk',

  //STEM info page
  'stem_data_list': [
    {
      'type': 'video',
      'title': 'Video: Maksud STEM',
      'preview':
          'Ketahui maksud STEM dan bagaimana Sains, Teknologi, Kejuruteraan, dan Matematik berfungsi bersama. '
          'Lihat contoh mudah bagaimana STEM digunakan dalam kehidupan sebenar.\n\n'
          'Video ini juga menunjukkan bagaimana pelajar boleh menggunakan konsep STEM dalam aktiviti dan projek harian, '
          'membuat pembelajaran menjadi menyeronokkan dan interaktif.',
      'videoUrl': 'https://youtu.be/wRV28EOCGGo?si=i7nfreNgNU1jF1J8',
      'previewImage': 'assets/stem_info/STEM_video1.png',
      'source': 'Apakah itu STEM? – STEM Best Practice, 20 Jun 2017',
    },
    {
      'type': 'image',
      'title': 'Kepentingan STEM',
      'preview':
          'STEM adalah penting kerana ia membantu murid memahami dunia, menggalakkan inovasi, dan melengkapi mereka dengan kemahiran untuk kerjaya moden.',
      'detailImage': 'assets/stem_info/Info2_ms.png',
    },
    {
      'type': 'image',
      'title': 'Kerjaya STEM',
      'previewImage': 'assets/stem_info/info3.png',
      'detailImage': 'assets/stem_info/Info3_ms.png',
    },
    {
      'type': 'image',
      'title': 'STEM dalam Kehidupan Seharian',
      'previewImage': 'assets/stem_info/info4.png',
      'detailImage': 'assets/stem_info/Info4_ms.png',
    },
    {
      'type': 'video',
      'title': 'Video: Projek STEM Paling Seronok',
      'preview':
          'Video ini menunjukkan bagaimana Sains, Teknologi, Kejuruteraan, dan Matematik bekerja bersama untuk menyelesaikan masalah dunia sebenar.\n\n'
          'Lihat contoh STEM dalam kehidupan seharian dan bagaimana pelajar boleh meneroka STEM melalui projek dan cabaran yang menyeronokkan.',
      'videoUrl': 'https://www.youtube.com/watch?v=Ml52O3miJKw',
      'previewImage': 'assets/stem_info/STEMvideo2.png',
      'source': 'Projek STEM Paling Menarik - GUITAR KIT WORLD, \n6 Jul 2023',
    },
  ],
};
