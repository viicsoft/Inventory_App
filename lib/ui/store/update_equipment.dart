import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/category.dart';
import 'package:viicsoft_inventory_app/services/apis/category_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_api.dart';
import 'package:viicsoft_inventory_app/ui/store/store_page.dart';

class UpdateEquipmentPage extends StatefulWidget {
  String? equipmentName;
  String image;
  String categoryId;
  String condition;
  String size;
  String description;
  String barcode;
  String id;
  UpdateEquipmentPage(
      {Key? key,
      required this.barcode,
      required this.categoryId,
      required this.condition,
      required this.description,
      required this.equipmentName,
      required this.image,
      required this.size,
      required this.id})
      : super(key: key);

  @override
  State<UpdateEquipmentPage> createState() => _UpdateEquipmentPageState();
}

class _UpdateEquipmentPageState extends State<UpdateEquipmentPage> {
  bool _isOnlineImage = true;
  XFile? _itemimage;

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
        source: source, imageQuality: 50, maxHeight: 700, maxWidth: 650);

    setState(() {
      _itemimage = pickedFile;
      _isOnlineImage = false;
    });
  }

  late Future<List<EquipmentCategory>> _category;
  EquipmentCategory? selectedCategory;
  final CategoryAPI _categoryApi = CategoryAPI();
  final EquipmentAPI _equipmentApi = EquipmentAPI();

  @override
  void initState() {
    _category = _categoryApi.fetchAllCategory();
    super.initState();
  }

  Future scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      widget.barcode = barcodeScanRes;
    });
  }

  List data = [];

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController =
        TextEditingController(text: widget.description);
    TextEditingController equipmentNameController =
        TextEditingController(text: widget.equipmentName);
    return Scaffold(
      body: FutureBuilder<List<EquipmentCategory>>(
          future: _category,
          builder: (context, snapshot) {
            final category = snapshot.data;
            if (category != null) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.gradientFirst,
                      AppColor.gradientSecond,
                    ],
                    begin: const FractionalOffset(0.0, 0.4),
                    end: Alignment.topRight,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 30, left: 30, right: 30),
                      width: MediaQuery.of(context).size.width,
                      height: 130,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Update Equipment',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: AppColor.homePageContainerTextBig),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(70),
                            topLeft: Radius.circular(70),
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: ListView(
                                  children: [
                                    itemImages(context),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Text(
                                          'Category*',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.homePageTitle,
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        DropdownButton<EquipmentCategory>(
                                          value:
                                              selectedCategory,
                                          elevation: 16,
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedCategory = newValue!;
                                            });
                                          },
                                          items: category
                                              .map((EquipmentCategory value) {
                                            return DropdownMenuItem<
                                                EquipmentCategory>(
                                              value: value,
                                              child: Text(
                                                value.name,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.gradientFirst,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: equipmentNameController,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 10.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        labelText: 'Equipment Name',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Condition*',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.homePageTitle,
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        DropdownButton<String>(
                                          value: widget.condition,
                                          elevation: 16,
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              widget.condition = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'NEW',
                                            'OLD',
                                            'BAD',
                                            'FAIR',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Size*',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.homePageTitle,
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        DropdownButton<String>(
                                          value: widget.size,
                                          elevation: 16,
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              widget.size = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'NORMAL',
                                            'LONG',
                                            'VERY LONG',
                                            'SHORT',
                                            'VERY SHORT',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: descriptionController,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 25.0, horizontal: 10.0),
                                        border: OutlineInputBorder(),
                                        labelText: 'Description',
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: AppColor.homePageTitle),
                                          onPressed: () => scanBarcodeNormal(),
                                          child: const Text('Scan Barcode'),
                                        ),
                                        Expanded(child: Container()),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Text(
                                              'Barcode : ${widget.barcode}\n',
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: AppColor.gradientFirst),
                                          onPressed: () async {
                                            var res = await _equipmentApi
                                                .updateEquipment(
                                                    equipmentNameController
                                                        .text,
                                                    //_itemimage!,
                                                    selectedCategory!.id,
                                                    widget.condition,
                                                    widget.size,
                                                    descriptionController.text,
                                                    widget.barcode,
                                                    widget.id);
                                            if (res.statusCode == 200 ||
                                                res.statusCode == 201) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      content: Text(
                                                          "Equipment Updated")));
                                              Navigator.pop(context);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      "Something went wrong"),
                                                ),
                                              );
                                            }
                                          },
                                          child: const Text(
                                            'Update Equipment',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: AppColor.gradientFirst),
              );
            }
          }),
    );
  }

  Column itemImages(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: userimage(_isOnlineImage, widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: InkWell(
            //     onTap: () => showDialog<String>(
            //       context: context,
            //       builder: (BuildContext context) => AlertDialog(
            //         title: const Text('Select Image'),
            //         content: const Text(
            //             'Select image from device gallery or use device camera'),
            //         actions: <Widget>[
            //           TextButton(
            //             onPressed: () {
            //               getImage(ImageSource.camera);
            //               Navigator.pop(context);
            //             },
            //             child: const Text('Camera'),
            //           ),
            //           TextButton(
            //             onPressed: () {
            //               getImage(ImageSource.gallery);
            //               Navigator.pop(context);
            //             },
            //             child: const Text('Gallery'),
            //           ),
            //         ],
            //       ),
            //     ),
            //     child: Container(
            //       height: 25,
            //       width: 25,
            //       decoration: BoxDecoration(
            //         color: AppColor.homePageTitle,
            //         shape: BoxShape.circle,
            //         border: Border.all(
            //           width: 1.5,
            //           color: Colors.white,
            //         ),
            //       ),
            //       child: const Icon(
            //         Icons.edit,
            //         size: 15,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  ImageProvider userimage(bool saverImage, String url) {
    if (saverImage) {
      return NetworkImage(url);
    } else {
      return FileImage(File(_itemimage!.path));
    }
  }
}
