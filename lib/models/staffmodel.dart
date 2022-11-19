class StaffModel {
  final int? id;
  final String name;
  final double weight;
  final int iconId;

  StaffModel(
      {this.id,
      required this.name,
      required this.weight,
      required this.iconId});

  factory StaffModel.fromMap(Map<String, dynamic> json) => StaffModel(
      id: json['staff_id'],
      name: json['name'],
      weight: json['weight'],
      iconId: json['icon_id']);

  Map<String, dynamic> toMap() {
    return {'staff_id': id, 'name': name, 'weight': weight, 'icon_id': iconId};
  }
}
