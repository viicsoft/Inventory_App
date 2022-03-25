import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/category.dart';
import 'package:viicsoft_inventory_app/services/apis/category_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_api.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  XFile? _itemimage;
  String dropdowncondition = 'NEW';
  String dropdownsize = 'LONG';
  TextEditingController descriptionController = TextEditingController();
  TextEditingController equipmentNameController = TextEditingController();

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 50, maxHeight: 700, maxWidth: 650);

    setState(() {
      _itemimage = pickedFile;
    });
  }

  String _scanBarcode = '';
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
      _scanBarcode = barcodeScanRes;
    });
  }

  List data = [];

  @override
  Widget build(BuildContext context) {
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
                                  'Add New Item',
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
                                              selectedCategory ?? category[0],
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
                                              child: Text(value.name),
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
                                        labelText: 'item name*',
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
                                          value: dropdowncondition,
                                          elevation: 16,
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdowncondition = newValue!;
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
                                          value: dropdownsize,
                                          elevation: 16,
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownsize = newValue!;
                                            });
                                          },
                                          items: <String>[
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
                                              'Result : $_scanBarcode\n',
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
                                            var res =
                                                await _equipmentApi.addEquipment(
                                                    equipmentNameController
                                                        .text,
                                                    _itemimage!,
                                                    selectedCategory!.id,
                                                    dropdowncondition,
                                                    dropdownsize,
                                                    descriptionController.text,
                                                    _scanBarcode);
                                            if (res.statusCode == 200 ||
                                                res.statusCode == 201) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      content: Text(
                                                          "Equipment added")));
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
                                            'Add Item',
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
                  image: _itemimage != null
                      ? FileImage(File(_itemimage!.path))
                      : const AssetImage('assets/camera.jpg') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Select Image'),
                    content: const Text(
                        'Select image from device gallery or use device camera'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          getImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                        child: const Text('Camera'),
                      ),
                      TextButton(
                        onPressed: () {
                          getImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                        child: const Text('Gallery'),
                      ),
                    ],
                  ),
                ),
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: AppColor.homePageTitle,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
