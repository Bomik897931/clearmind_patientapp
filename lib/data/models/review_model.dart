class ReviewModel {
  final int reviewId;
  final String reviewText;
  final String imageUrl;
  final double rating;

  ReviewModel({
    required this.reviewId,
    required this.reviewText,
    required this.imageUrl,
    required this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json['reviewId'],
      reviewText: json['reviewText'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] as num).toDouble(),
    );
  }
}