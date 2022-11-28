class TipsHistoryDetailsModel {
  final int? id;
  final int tipsHistoryId;
  final String name;
  final int count;
  final double value;

  TipsHistoryDetailsModel(
      {this.id,
      required this.tipsHistoryId,
      required this.name,
      required this.count,
      required this.value});

  factory TipsHistoryDetailsModel.fromMap(Map<String, dynamic> json) =>
      TipsHistoryDetailsModel(
          id: json['details_id'],
          tipsHistoryId: json['tips_history_id'],
          name: json['name'],
          count: json['count'],
          value: json['value']);

  Map<String, dynamic> toMap() {
    return {
      'details_id': id,
      'tips_history_id': tipsHistoryId,
      'name': name,
      'count': count,
      'value': value
    };
  }
}
