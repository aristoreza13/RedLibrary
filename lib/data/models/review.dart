// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  Review({
    this.rating,
    this.review,
  });

  String? rating;
  String? review;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: json["rating"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "review": review,
      };
}
