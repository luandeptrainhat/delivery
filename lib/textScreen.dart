import 'dart:io';
import 'dart:typed_data';

import 'package:delivery/model/img.dart';
import 'package:delivery/network/network_request.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<Img> imgDataCheckIn = []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    getPicture('GIN005');
  }

  void getPicture(String ginNum) async {
    try {
      final myRemoveService = RemoveService();
      final imgList = await myRemoveService.getImgListByGinNum('image/find/', ginNum);
      print('Is it null? $imgList');
      if (imgList != null) {
        setState(() {
          imgDataCheckIn.addAll(imgList);
          print('độ dài$imgDataCheckIn.length');
        });
      } else {
        // Xử lý khi không có hình ảnh
      }
    } catch (e) {
      // Xử lý khi xảy ra lỗi trong quá trình lấy hình ảnh
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Chi tiết'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
            margin: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: imgDataCheckIn.length,
              itemBuilder: (context, index) {
                final img = imgDataCheckIn[index];
                // Thay thế bằng widget của bạn
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                      File(imgDataCheckIn[index].imageData.path)),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(
                        8.0),
                  ),
                  child: Text( imgDataCheckIn[index].ginNum?? 'tôi đây')
                );
              },
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}