class Highlight {
  final String id;
  final String title;
  final String titleMs;
  final String subtitle;
  final String subtitleMs;
  final String image;
  final Map<String, List<String>> details;
  final Map<String, List<String>> detailsMs;

  Highlight({
    required this.id,
    required this.title,
    required this.titleMs,
    required this.subtitle,
    required this.subtitleMs,
    required this.image,
    required this.details,
    required this.detailsMs,
  });
}

final List<Highlight> sampleHighlights = [
  Highlight(
    id: 'h1',
    title: 'Scientist Becomes Coloring Book Superhero!',
    titleMs: 'Saintis Menjadi Superhero Buku Mewarna!',
    subtitle: 'Meet a real scientist turned comic hero!',
    subtitleMs: 'Kenali saintis sebenar yang menjadi wira komik!',
    image: 'assets/images/highlight1.webp',
    details: {
      'Who?': [
        'Alison Banwell, a real scientist at University of Colorado Boulder',
      ],
      'What Happened?': [
        'Featured as a superhero in a STEM coloring book for kids',
      ],
      'Why?': [
        'Inspire kids (especially girls) to see themselves in STEM',
        'Break gender stereotypes in science',
      ],
      'How it Helps?': [
        'Makes science fun and creative',
        'Encourages imagination and curiosity',
        'Shows that anyone can be a scientist',
      ],
      'Motivation:': [
        'STEM is for everyone!',
        'You can be a hero in science too!',
      ],
    },
    detailsMs: {
      'Siapa?': [
        'Alison Banwell, seorang saintis di University of Colorado Boulder',
      ],
      'Apa Yang Berlaku?': [
        'Dipaparkan sebagai adiwira dalam buku mewarna STEM kanak-kanak',
      ],
      'Mengapa?': [
        'Inspirasi kanak-kanak (terutamanya perempuan) untuk menceburi STEM',
        'Memecahkan stereotaip jantina dalam sains',
      ],
      'Bagaimana ia Membantu?': [
        'Menjadikan sains menyeronokkan dan kreatif',
        'Menggalakkan imaginasi dan rasa ingin tahu',
        'Menunjukkan bahawa sesiapa sahaja boleh menjadi saintis',
      ],
      'Motivasi:': [
        'STEM adalah untuk semua orang!',
        'Anda juga boleh menjadi wira dalam sains!',
      ],
    },
  ),

  Highlight(
    id: 'h2',
    title: 'Can YOU Break a STEM World Record?',
    titleMs: 'Bolehkah ANDA Memecahkan Rekod Dunia STEM?',
    subtitle: 'Fun challenges you can try!',
    subtitleMs: 'Cabaran menyeronokkan yang boleh anda cuba!',
    image: 'assets/images/highlight2.png',
    details: {
      'Did you know?': [
        'National STEM Day is an annual observance on 8th November which celebrates and promotes the fields of science, technology, engineering and mathematics.',
      ],
      'STEM Heroes and Achievements': [
        'Brooke Cressey',
        'assets/images/brooke.jpg',
        'Only 8 years old, set the record for the highest Times Tables Rock Stars score which is 210 in one minute.',
        'Brooke beat a maths game record showing speed and accuracy',
        'Rafał',
        'assets/images/rafal.jpg',
        'Youngest person to discover a comet at 12 years old with more discoveries since.',
        'Rafał discovered a real comet, showing curiosity and exploration',
        'Gitanjali',
        'assets/images/Gitanjali.jpg',
        'Created a device to detect lead in water at age 10.',
        'Gitanjali’s device helps solve a real health problem',
      ],
      'Try This Record': [
        'Age is no barrier to achievement in science or technology',
        'Trying to stack up the 20 LEGO bricks to a right-angle tower (under 16 category) as fast as possible.',
        'A fun challenge you can practice and time yourself on!',
      ],
    },
    detailsMs: {
      'Tahukah anda?': [
        'Hari STEM Kebangsaan disambut setiap 8 November untuk mempromosikan bidang sains, teknologi, kejuruteraan dan matematik.',
      ],
      'Wira STEM dan Pencapaian': [
        'Brooke Cressey',
        'assets/images/brooke.jpg',
        'Baru berusia 8 tahun, menetapkan rekod skor Times Tables Rock Stars tertinggi iaitu 210 dalam satu minit.',
        'Rafał',
        'assets/images/rafal.jpg',
        'Orang termuda menemui komet pada usia 12 tahun.',
        'Gitanjali',
        'assets/images/Gitanjali.jpg',
        'Mencipta peranti untuk mengesan plumbum dalam air pada usia 10 tahun.',
      ],
      'Cuba Rekod Ini': [
        'Usia bukan penghalang untuk berjaya dalam sains atau teknologi',
        'Cuba menyusun 20 bata LEGO menjadi menara bersudut tepat sepantas mungkin.',
      ],
    },
  ),

  Highlight(
    id: 'h3',
    title: 'AI Solves Science Puzzles',
    titleMs: 'AI Menyelesaikan Teka-teki Sains',
    subtitle: 'Could you team up with it?',
    subtitleMs: 'Bolehkah anda bekerjasama dengannya?',
    image: 'assets/images/highlight3.webp',
    details: {},
    detailsMs: {},
  ),
  Highlight(
    id: 'h4',
    title: 'Students Send Experiments to Space',
    titleMs: 'Pelajar Menghantar Eksperimen ke Angkasa',
    subtitle: 'Actual Space Station research',
    subtitleMs: 'Penyelidikan Stesen Angkasa yang sebenar',
    image: 'assets/images/highlight4.jpg',
    details: {},
    detailsMs: {},
  ),
];
