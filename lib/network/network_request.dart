import 'dart:convert';

import 'package:delivery/model/orders.dart';
import 'package:http/http.dart' as http;

class RemoveService {
  var client = http.Client();
  static const String Baseurl = 'http://192.168.1.27:3000/orders';

  Future<List<Orders>?> getOrders(String api) async {
    var uri = Uri.parse(Baseurl + api);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return ordersFromJson(json);
    }
  }

  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(Baseurl + api);
    var payload = jsonEncode(object);
    var response = await client.post(url, body: payload);
    if (response.statusCode == 201) {
      return response.body;
    } else {
//throw exception
    }
  }
}
