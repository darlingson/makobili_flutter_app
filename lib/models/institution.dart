class Institution {
  final String id;
  final String name;
  final String type;

  Institution({
    required this.id,
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }
}
