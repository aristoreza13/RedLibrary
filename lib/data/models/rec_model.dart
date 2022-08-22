// To parse this JSON data, do
//
//     final recModel = recModelFromJson(jsonString);

import 'dart:convert';

RecModel recModelFromJson(String str) => RecModel.fromJson(json.decode(str));

String recModelToJson(RecModel data) => json.encode(data.toJson());

class RecModel {
  RecModel({
    required this.similarity,
    required this.topTenMovies,
  });

  Map<String, double> similarity;
  Map<String, String> topTenMovies;

  factory RecModel.fromJson(Map<String, dynamic> json) => RecModel(
        similarity: Map.from(json["Similarity"])
            .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        topTenMovies: Map.from(json["Top Ten Movies"])
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "Similarity":
            Map.from(similarity).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "Top Ten Movies": Map.from(topTenMovies)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
