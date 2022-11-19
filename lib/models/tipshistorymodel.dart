class TipsHistory {
  final int? id;
  final double totalValue;
  final int peopleCount;
  final DateTime date;

  TipsHistory(
      {this.id,
      required this.totalValue,
      required this.peopleCount,
      required this.date});

  factory TipsHistory.fromMap(Map<String, dynamic> json) => TipsHistory(
      id: json['id'],
      totalValue: json['name'],
      peopleCount: json['weight'],
      date: json['iconId']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'totalValue': totalValue,
      'peopleCount': peopleCount,
      'date': date
    };
  }
}
