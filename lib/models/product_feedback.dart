class ProductFeedback {
  final int id;
  final String feedback;
  final double score;
  final String? createdAt;
  final String userName;

  ProductFeedback({
    required this.id,
    required this.feedback,
    required this.score,
    this.createdAt,
    required this.userName,
  });

  factory ProductFeedback.fromJson(Map json) {
    int timeStamp = int.parse(json['created_at'] ?? '0');
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return ProductFeedback(
      id: int.parse(json['id']),
      feedback: json['feedback'],
      score: double.parse(json['score']),
      createdAt: "${dateTime.day}/${dateTime.month}/${dateTime.year}",
      userName: json['user'] ?? 'Anonymous',
    );
  }
}
