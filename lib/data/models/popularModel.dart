// To parse this JSON data, do
//
//     final popularModel = popularModelFromJson(jsonString);

import 'dart:convert';

PopularModel popularModelFromJson(String str) =>
    PopularModel.fromJson(json.decode(str));

String popularModelToJson(PopularModel data) => json.encode(data.toJson());

class PopularModel {
  PopularModel({
    required this.isbn,
    required this.bookRating,
    required this.bookTitle,
    required this.bookAuthor,
    required this.yearOfPublication,
    required this.publisher,
    required this.imageUrlM,
  });

  Map<String, String> isbn;
  Map<String, int> bookRating;
  Map<String, String> bookTitle;
  Map<String, String> bookAuthor;
  Map<String, int> yearOfPublication;
  Map<String, String> publisher;
  Map<String, String> imageUrlM;

  factory PopularModel.fromJson(Map<String, dynamic> json) => PopularModel(
        isbn: Map.from(json["ISBN"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        bookRating: Map.from(json["Book-Rating"])
            .map((k, v) => MapEntry<String, int>(k, v)),
        bookTitle: Map.from(json["Book-Title"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        bookAuthor: Map.from(json["Book-Author"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        yearOfPublication: Map.from(json["Year-Of-Publication"])
            .map((k, v) => MapEntry<String, int>(k, v)),
        publisher: Map.from(json["Publisher"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        imageUrlM: Map.from(json["Image-URL-M"])
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "ISBN": Map.from(isbn).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "Book-Rating":
            Map.from(bookRating).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "Book-Title":
            Map.from(bookTitle).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "Book-Author":
            Map.from(bookAuthor).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "Year-Of-Publication": Map.from(yearOfPublication)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "Publisher":
            Map.from(publisher).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "Image-URL-M":
            Map.from(imageUrlM).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
