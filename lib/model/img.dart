// To parse this JSON data, do
//
//     final img = imgFromJson(jsonString);

import 'dart:convert';

List<Img> imgFromJson(String str) => List<Img>.from(json.decode(str).map((x) => Img.fromJson(x)));

String imgToJson(List<Img> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Img {
  String rowPointer;
  String ginNum;
  String url;
  String createBy;
  DateTime createDate;
  dynamic updateBy;
  dynamic updateDate;

  Img({
    required this.rowPointer,
    required this.ginNum,
    required this.url,
    required this.createBy,
    required this.createDate,
    required this.updateBy,
    required this.updateDate,
  });

  factory Img.fromJson(Map<String, dynamic> json) => Img(
    rowPointer: json["rowPointer"],
    ginNum: json["ginNum"],
    url: json["url"],
    createBy: json["createBy"],
    createDate: DateTime.parse(json["createDate"]),
    updateBy: json["updateBy"],
    updateDate: json["updateDate"],
  );

  Map<String, dynamic> toJson() => {
    "rowPointer": rowPointer,
    "ginNum": ginNum,
    "url": url,
    "createBy": createBy,
    "createDate": createDate.toIso8601String(),
    "updateBy": updateBy,
    "updateDate": updateDate,
  };
}
