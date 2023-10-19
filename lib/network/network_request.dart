import 'dart:convert';
import 'dart:io';
import 'package:delivery/model/orders.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../model/img.dart';

class RemoveService {
  var client = http.Client();
  static const String Baseurl = 'http://192.168.1.8:3000/';

//get
  Future<List<Orders>?> getOrders(String api) async {
    var uri = Uri.parse(Baseurl + api);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return ordersFromJson(json);
    }
  }

// add
  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(Baseurl + api);
    var payload = jsonEncode(object);
    print(payload);
    var response = await client.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: payload);
    if (response.statusCode == 201) {
      return response.body;
    } else {
//throw exception
    }
  }

  //edit
  Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(Baseurl + api);
    var payload = jsonEncode(object);
    var response = await client.post(url, body: payload);
    if (response.statusCode == 200) {
      return response.body;
    } else {
//throw exception
    }
  }

  Future<dynamic> delete(String api) async {
    var url = Uri.parse(Baseurl + api);
    var response = await client.delete(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
//throw exception
    }
  }

  Future<void> postImage(
      String api, String rowPointer, String ginNum, String filePath) async {
    var url = Uri.parse(Baseurl + api);

    var request = http.MultipartRequest('POST', url);

    request.files.add(await http.MultipartFile.fromPath(
      'myFile',
      filePath,
      contentType: MediaType.parse(
          lookupMimeType(filePath) ?? 'application/octet-stream'),
    ));

    request.fields['rowPointer'] = rowPointer;
    request.fields['ginNum'] = ginNum;

    var response = await request.send();

    if (response.statusCode == 200) {
      print('File uploaded successfully');
    } else {
      print('File upload failed with status code ${response.statusCode}');
    }
  }

//  get image

  // Future<List<Img>?> getImgListByGinNum(String api, String ginNum) async {
  //   final url = Baseurl + api + ginNum;
  //   try {
  //     final response = await client.get(Uri.parse(url));
  //       print(2);
  //     if (response.statusCode == 200) {
  //       Uint8List imageData = response.bodyBytes;
  //
  //       final base64ImageData = base64Encode(imageData);
  //       Uint8List data = base64.decode(base64ImageData);
  //       print('data ===== $data');
  //       dynamic json = jsonEncode(data.toList());
  //       print('json ===== $json');
  //
  //       Var json = jsonEncode(array.map((e) => e.toJson()).toList());
  //
  //       List<dynamic> jsonData = json;
  //       List<Img> imgList = [];
  //       for (var data in jsonData) {
  //         var bytes = await getImageBytes(data['fileName']);
  //         var base64Image = base64Encode(bytes);
  //         // ignore: avoid_print
  //         print('base64 $base64Image');
  //         var img = Img(
  //           imageData: base64Image,
  //           rowPointer: data['rowPointer'],
  //           ginNum: data['ginNum'],
  //           fileName: data['fileName'],
  //         );
  //         imgList.add(img);
  //       }
  //
  //       return imgList;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print('Error: $e');
  //     return null;
  //   }
  // }
  Future<List<Img>> getImgListByGinNum(String api, String ginNum) async {
    final url = Baseurl + api + ginNum;

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final imageDataList = response.bodyBytes;
      final imgDataCheckIn = <Img>[];

      final tempFile = await _createLocalImageFile(imageDataList);

      final img2 = Img(
        imageData: tempFile,
        rowPointer: 'AC8BB3A2-DF62-48C0-8B3F-B3448466FB87',
        ginNum: 'GIN005',
        fileName: 'cd1ecafa762f5796597f073171f109e0',
        type: ''
      );
      imgDataCheckIn.add(img2);

      return imgDataCheckIn;
    } else {
      throw Exception('Failed to load image');
    }
  }

  Future<File> _createLocalImageFile(List<int> imageData) async {
    final tempDir = await Directory.systemTemp.createTemp();
    final tempPath = tempDir.path;
    final tempFile = File('$tempPath/temp_image.png');
    await tempFile.writeAsBytes(imageData);
    return tempFile;
  }
}

