import 'dart:io';
import 'package:delivery/model/orders.dart';
import 'package:delivery/network/network_request.dart';
import 'package:flutter/material.dart';
import 'package:delivery/detail.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:intl/intl.dart';
import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/rng.dart';

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
  File? _image;
  File? _image2;
  var uuid = const Uuid();

  var isLoad = false;


  bool _isShowingImageList = false;
  List<File> _capturedImages = [];

  bool _isShowingImageList2 = false;
  List<File> _capturedImages2 = [];

  @override
  void initState() {
    super.initState();
    getData();
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
            final ginNum = ordersData?[index].ginNum;
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
                                    getImage(source: ImageSource.camera);
                                  },
                                  label: const Text(
                                    'Check in',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                  ),
                                ),
                                if (_capturedImages.isNotEmpty)
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _isShowingImageList =
                                            !_isShowingImageList;
                                          });
                                        },
                                        child: Text(
                                          'Số ảnh đã chụp: ${_capturedImages
                                              .length}',
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
                                if (_isShowingImageList)
                                  GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 8.0,
                                      crossAxisSpacing: 8.0,
                                    ),
                                    itemCount: _capturedImages.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // Handle tap event to view the image in full size
                                          _viewImage(_capturedImages[index]);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: FileImage(
                                                  _capturedImages[index]),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                8.0),
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
                                if (_capturedImages2.isNotEmpty)
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
                                          'Số ảnh đã chụp: ${_capturedImages2
                                              .length}',
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
                                if (_isShowingImageList2)
                                  GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 8.0,
                                      crossAxisSpacing: 8.0,
                                    ),
                                    itemCount: _capturedImages2.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // Handle tap event to view the image in full size
                                          _viewImage(_capturedImages2[index]);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: FileImage(
                                                  _capturedImages2[index]),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                8.0),
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
        onPressed: () async {
          var v1 = uuid.v4();
          DateTime currentDate = DateTime.now();
          //String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
          // print(v1);
          var od = Orders(
              rowPointer: v1,
              ginNum: 'GIN004',
              address: 'Q12, HCM',
              shipper: 'Luaan',
              phone: '0123456789',
              siteId: 'Site4',
              createBy: 'Luaanaa',
              createDate: currentDate,
              updateBy: 'luan',
              updateDate: currentDate);
          var response = await RemoveService().post('orders/create', od);
          print(v1);
          if (response == null) return;
          //  debugPrint('thêm thành công $uuid');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        _capturedImages.add(File(file!.path)); // Thêm ảnh vào danh sách
        _isShowingImageList = true; // Hiển thị danh sách ảnh
      });
    }
  }

  void getImage2({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        _capturedImages2.add(File(file!.path)); // Thêm ảnh vào danh sách
        _isShowingImageList2 = true; // Hiển thị danh sách ảnh
      });
    }
  }
}
