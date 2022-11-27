class TipsHistoryModel {
  final int? id;
  final double value;
  final DateTime date;

  TipsHistoryModel({this.id, required this.value, required this.date});

  factory TipsHistoryModel.fromMap(Map<String, dynamic> json) => TipsHistoryModel(
      id: json['tips_history_id'],
      value: json['total_value'],
      date: DateTime.parse(json['date']));

  Map<String, dynamic> toMap() {
    return {
      'tips_history_id': id,
      'total_value': value,
      'date': date.toString()
    };
  }
}
