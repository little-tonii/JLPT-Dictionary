enum JlptLevel {
  n5(level: "N5"),
  n4(level: "N4"),
  n3(level: "N3"),
  n2(level: "N2"),
  n1(level: "N1");

  final String level;

  const JlptLevel({required this.level});
}
