import 'dart:io';
import 'package:delivery/model/img.dart';
import 'package:delivery/model/orders.dart';
import 'package:delivery/network/network_request.dart';
import 'package:delivery/textScreen.dart';
import 'package:flutter/material.dart';
import 'package:delivery/detail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple, // Update seedColor to primarySwatch
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Giao Hàng'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Orders>? ordersData;
  List<Img> imgDataCheckIn = [];
  File? _image;
  File? _image2;
  var uuid = const Uuid();

  var isLoad = false;

  bool _isShowingImageList = false;
  List<File> _capturedImages = [];

  bool _isShowingImageList2 = false;
  List<File> _capturedImages2 = [];

  late String ginNum = 'GIN009';
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      getPicture(ginNum);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();

  }

  void getPicture(String ginNum) async {
    try {
      final myRemoveService = RemoveService();
      final imgList =
          await myRemoveService.getImgListByGinNum('image/find/', ginNum);
      print('Is it null? $imgList');
      if (imgList != null) {
        setState(() {
          imgDataCheckIn.addAll(imgList);
        });
      } else {
        // Xử lý khi không có hình ảnh
      }
    } catch (e) {
      // Xử lý khi xảy ra lỗi trong quá trình lấy hình ảnh
    }
  }

  getData() async {
    ordersData = await RemoveService().getOrders('orders/findall');
    //debugPrint(ordersData);
    if (ordersData != null) {
      setState(() {
        isLoad = true;
      });
    }
  }

  Future<void> postImage(File image) async {
    var v1 = const Uuid().v4();
    String filePath = image.path;
    String fileName = filePath.split('/').last.split('-').last.split('.').first;

    var removeService = RemoveService();
    await removeService.postImage('image/upload', v1, 'GIN005', filePath);
  }

  void _viewImage(File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(imageFile),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Visibility(
        visible: isLoad,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: ordersData?.length,
          // Set itemCount to 1 since there's only one item
          itemBuilder: (BuildContext context, int index) {
            final rowpointer = ordersData?[index].rowPointer;
            ginNum = ordersData![index].ginNum;
            final address = ordersData?[index].address;
            final shipper = ordersData?[index].shipper;
            final phone = ordersData?[index].phone;
            final siteId = ordersData?[index].siteId;

            return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Detail()),
                  );
                },
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: [
                        const Text('Đơn giao hàng'),
                        Column(
                          children: [
                            // ItemList()
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                // const Text('GIN Num'),
                                // const SizedBox(width: 10),
                                const Expanded(child: Text('GIN Num')),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Tùy chọn: bo tròn các góc của đường viền
                                    ),
                                    // child: TextFormField(
                                    child: Text('$ginNum'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // const Text('GIN Num'),
                                // const SizedBox(width: 10),
                                const Expanded(child: Text('Địa chỉ')),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Tùy chọn: bo tròn các góc của đường viền
                                    ),
                                    // child: TextFormField(),
                                    child: Text('$address'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // const Text('GIN Num'),
                                // const SizedBox(width: 10),
                                const Expanded(child: Text('Hạn giao hàng')),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Tùy chọn: bo tròn các góc của đường viền
                                    ),
                                    // child: TextFormField(),
                                    child: Text('$siteId'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // const Text('GIN Num'),
                                // const SizedBox(width: 10),
                                const Expanded(child: Text('Tên')),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Tùy chọn: bo tròn các góc của đường viền
                                    ),
                                    // child: TextFormField(),
                                    child: Text('$shipper'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // const Text('GIN Num'),
                                // const SizedBox(width: 10),
                                const Expanded(child: Text('Điện thoại')),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Tùy chọn: bo tròn các góc của đường viền
                                    ),
                                    // child: TextFormField(),
                                    child: Text('$phone'),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    getImage2(source: ImageSource.camera);
                                  },
                                  label: const Text(
                                    'Check out',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                  ),
                                ),

                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _isShowingImageList2 =
                                          !_isShowingImageList2;
                                        });
                                      },
                                      child: Text(
                                        'Số ảnh đã chụp: ${imgDataCheckIn.length}',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isShowingImageList =
                                          !_isShowingImageList;
                                        });
                                      },
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down),
                                    ),
                                  ],
                                ),
                                if(_isShowingImageList)
                                GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 8.0,
                                    crossAxisSpacing: 8.0,
                                  ),
                                  itemCount: imgDataCheckIn.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // Handle tap event to view the image in full size
                                        _viewImage(imgDataCheckIn[index].imageData);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: FileImage(File(
                                              imgDataCheckIn[index].imageData.path,
                                            )),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    getImage2(source: ImageSource.camera);
                                  },
                                  label: const Text(
                                    'Check out',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                  ),
                                ),

                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _isShowingImageList2 =
                                                !_isShowingImageList2;
                                          });
                                        },
                                        child: Text(
                                          'Số ảnh đã chụp: ${imgDataCheckIn.length}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isShowingImageList2 =
                                                !_isShowingImageList2;
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                      ),
                                    ],
                                  ),
                                if(_isShowingImageList2)
                                  GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 8.0,
                                      crossAxisSpacing: 8.0,
                                    ),
                                    itemCount: imgDataCheckIn.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // Handle tap event to view the image in full size
                                          _viewImage(imgDataCheckIn[index].imageData);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: FileImage(File(
                                                imgDataCheckIn[index].imageData.path,
                                              )),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Test()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        _capturedImages.add(File(file!.path));

        _isShowingImageList = true; // Hiển thị danh sách ảnh
        _image = File(file.path);
        postImage(_image!);
      });
    }
  }

  void getImage2({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        _capturedImages2.add(File(file!.path)); // Thêm ảnh vào danh sách
        _isShowingImageList2 = true; // Hiển thị danh sách ảnh
        postImage(_image2!);
      });
    }
  }
}
