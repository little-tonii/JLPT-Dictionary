enum YomiType {
  kunyomi(type: 'kunyomi'),

  onyomi(type: 'onyomi');

  final String type;

  const YomiType({required this.type});
}
