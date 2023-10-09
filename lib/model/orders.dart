// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

List<Orders> ordersFromJson(String str) => List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
  String rowPointer;
  String ginNum;
  String address;
  String shipper;
  String phone;
  String siteId;
  String createBy;
  DateTime createDate;
  String updateBy;
  DateTime updateDate;

  Orders({
    required this.rowPointer,
    required this.ginNum,
    required this.address,
    required this.shipper,
    required this.phone,
    required this.siteId,
    required this.createBy,
    required this.createDate,
    required this.updateBy,
    required this.updateDate,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    rowPointer: json["rowPointer"],
    ginNum: json["ginNum"],
    address: json["address"],
    shipper: json["shipper"],
    phone: json["phone"],
    siteId: json["siteId"],
    createBy: json["createBy"],
    createDate: DateTime.parse(json["createDate"]),
    updateBy: json?["updateBy"],
    updateDate: DateTime.parse(json["updateDate"]),
  );

  Map<String, dynamic> toJson() => {
    "rowPointer": rowPointer,
    "ginNum": ginNum,
    "address": address,
    "shipper": shipper,
    "phone": phone,
    "siteId": siteId,
    "createBy": createBy,
    "createDate": createDate.toIso8601String(),
    "updateBy": updateBy,
    "updateDate": updateDate.toIso8601String(),
  };
}

// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

// import 'dart:convert';
//
// List<Orders> ordersFromJson(String str) => List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));
//
// String ordersToJson(List<Orders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Orders {
//   int userId;
//   int id;
//   String title;
//   String body;
//
//   Orders({
//     required this.userId,
//     required this.id,
//     required this.title,
//     required this.body,
//   });
//
//   factory Orders.fromJson(Map<String, dynamic> json) => Orders(
//     userId: json["userId"],
//     id: json["id"],
//     title: json["title"],
//     body: json["body"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "userId": userId,
//     "id": id,
//     "title": title,
//     "body": body,
//   };
// }

