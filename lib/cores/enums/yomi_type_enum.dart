enum YomiTypeEnum {
  kunyomi(yomiType: 'kunyomi'),

  onyomi(yomiType: 'onyomi');

  final String yomiType;

  const YomiTypeEnum({required this.yomiType});
}
