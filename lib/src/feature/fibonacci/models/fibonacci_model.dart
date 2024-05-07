// To parse this JSON data, do
//
//     final fobonacciModel = fobonacciModelFromJson(jsonString);

import 'dart:convert';

FibonacciModel fobonacciModelFromJson(String str) => FibonacciModel.fromJson(json.decode(str));

String fobonacciModelToJson(FibonacciModel data) => json.encode(data.toJson());

class FibonacciModel {
    int id;
    String type;
    int fibonacci;

    FibonacciModel({
        required this.id,
        required this.type,
        required this.fibonacci,
    });

    FibonacciModel copyWith({
        int? fibonacci,
        String? type,
        int? id,
    }) => 
        FibonacciModel(
            id: id ?? this.id,
            type: type ?? this.type,
            fibonacci: fibonacci ?? this.fibonacci,
        );

    factory FibonacciModel.fromJson(Map<String, dynamic> json) => FibonacciModel(
        id: json["id"],
        type: json["type"],
        fibonacci: json["fibonacci"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "fibonacci": fibonacci,
    };
}
