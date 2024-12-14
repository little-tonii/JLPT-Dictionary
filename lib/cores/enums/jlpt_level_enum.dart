enum JlptLevelEnum {
  n5(jlptLevel: "N5"),
  n4(jlptLevel: "N4"),
  n3(jlptLevel: "N3"),
  n2(jlptLevel: "N2"),
  n1(jlptLevel: "N1");

  final String jlptLevel;

  const JlptLevelEnum({
    required this.jlptLevel,
  });
}
