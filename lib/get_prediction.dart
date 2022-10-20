import 'dart:convert';

GetPrediction getPredictionFromJson(String str) =>
    GetPrediction.fromJson(json.decode(str));

String getPredictionToJson(GetPrediction data) => json.encode(data.toJson());

class GetPrediction {
  GetPrediction({
    required this.potability,
    required this.result,
  });

  int potability;
  String result;

  factory GetPrediction.fromJson(Map<String, dynamic> json) => GetPrediction(
        potability: json["potability"],
        result: json["Result"],
      );

  Map<String, dynamic> toJson() => {
        "potability": potability,
        "Result": result,
      };
}
