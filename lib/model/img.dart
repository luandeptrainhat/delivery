// To parse this JSON data, do
//
//     final img = imgFromJson(jsonString);

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui';

import 'img.dart';


List<Img> imgFromJson(String str) => List<Img>.from(json.decode(str).map((x) => Img.fromJson(x)));

String imgToJson(List<Img> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Img {
  final String? rowPointer;
  final String? ginNum;
  final String? fileName;
  File imageData;
  String? type;
  String? createBy;
  DateTime? createDate;
  dynamic? updateBy;
  DateTime? updateDate;

  Img({
    required this.rowPointer,
    required this.ginNum,
    required this.fileName,
    required this.imageData,
    required this.type,// Add imageData parameter
    this.createBy,
    this.createDate,
    this.updateBy,
    this.updateDate,
  });

  factory Img.fromJson(Map<String, dynamic> json) => Img(
    rowPointer: json["rowPointer"]as String,
    ginNum: json["ginNum"]as String,
    fileName: json["fileName"]as String,
    imageData: json["imageData"] , // Add imageData parameter
    type: json['type'],
    createBy: json["createBy"],
    createDate: DateTime.parse(json["createDate"]),
    updateBy: json["updateBy"],
    updateDate: DateTime.parse(json["updateDate"]),
  );

  Map<String, dynamic> toJson() => {
    "rowPointer": rowPointer,
    "ginNum": ginNum,
    "fileName": fileName,
    "imageData": imageData, // Add imageData parameter
    "type": type,
    "createBy": createBy,
    "createDate": createDate,
    "updateBy": updateBy,
    "updateDate": updateDate,
  };




}
