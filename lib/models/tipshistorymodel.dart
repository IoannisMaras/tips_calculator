class TipsHistory {
  final int? id;
  final double value;
  final DateTime date;

  TipsHistory({this.id, required this.value, required this.date});

  factory TipsHistory.fromMap(Map<String, dynamic> json) => TipsHistory(
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
