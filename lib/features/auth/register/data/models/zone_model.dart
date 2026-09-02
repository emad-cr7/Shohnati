class ZoneModel {
  final String id;
  final String name;

  ZoneModel({
    required this.id,
    required this.name,
  });

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
    );
  }
}