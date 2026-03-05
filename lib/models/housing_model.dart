class Area {
  final int id;
  final String name;

  Area({required this.id, required this.name});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      name: json['name'],
    );
  }
}

class StatisticalArea {
  final int id;
  final String name;

  StatisticalArea({required this.id, required this.name});

  factory StatisticalArea.fromJson(Map<String, dynamic> json) {
    return StatisticalArea(
      id: json['id'],
      name: json['name'],
    );
  }
}


class RepairingIssueType {
  final int id;
  final String name;

  RepairingIssueType({required this.id, required this.name});
  factory RepairingIssueType.fromJson(Map<String, dynamic> json) {
    return RepairingIssueType(
      id: json['id'],
      name: json['reparing_issues'],
    );
  }
}


class TrustedRepairingIssueType {
  final int id;
  final String name;

  TrustedRepairingIssueType({required this.id, required this.name});
  factory TrustedRepairingIssueType.fromJson(Map<String, dynamic> json) {
    return TrustedRepairingIssueType(
      id: json['id'],
      name: json['name'],
    );
  }
}


