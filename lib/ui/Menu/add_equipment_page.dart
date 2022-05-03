import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/category.dart';
import 'package:viicsoft_inventory_app/services/apis/category_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_api.dart';

class AddEquipmentPage extends StatefulWidget {
  const AddEquipmentPage({Key? key}) : super(key: key);

  @override
  State<AddEquipmentPage> createState() => _AddEquipmentPageState();
}

class _AddEquipmentPageState extends State<AddEquipmentPage> {
  XFile? _itemimage;
  String _newCondition = 'NEW';
  String _newSize = 'SHORT';
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController equipmentNameController = TextEditingController();
  final picker = ImagePicker();
  bool noImage = false;

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
        source: source, imageQuality: 50, maxHeight: 700, maxWidth: 650);

    setState(() {
      _itemimage = pickedFile;
    });
  }

  String _scanBarcode = '';
  late Future<List<EquipmentCategory>> _category;
  EquipmentCategory? newselectedCategory;
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
      body: Form(
        key: globalFormKey,
        child: FutureBuilder<List<EquipmentCategory>>(
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
                              child: Text(
                                'Add New Equipment',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: AppColor.homePageContainerTextBig),
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
                                child: ListView(
                                  children: [
                                    itemImages(context),
                                    Center(
                                      child: Text(
                                        noImage ? 'No image selected !' : '',
                                        style: TextStyle(
                                            color: AppColor.gradientFirst),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Category*',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.homePageTitle,
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        DropdownButton<EquipmentCategory>(
                                          value: newselectedCategory,
                                          elevation: 16,
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                          onChanged: (newValue) {
                                            setState(() {
                                              newselectedCategory = newValue!;
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
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: equipmentNameController,
                                      validator: (input) => (input!.isEmpty)
                                          ? "Add Equipment Name"
                                          : null,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 10.0),
                                        labelText: 'Equipment Name*',
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          'Condition*',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.homePageTitle,
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        DropdownButton<String>(
                                          value: _newCondition,
                                          elevation: 16,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600]),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _newCondition = newValue!;
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
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Size*',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.homePageTitle,
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        DropdownButton<String>(
                                          value: _newSize,
                                          elevation: 16,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600]),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _newSize = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'SHORT',
                                            'LONG',
                                            'VERY LONG',
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
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: descriptionController,
                                      validator: (input) => (input!.isEmpty)
                                          ? "Add Equipment Description"
                                          : null,
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
                                                  fontSize: 14)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: AppColor.gradientFirst),
                                          onPressed: () async {
                                            if (globalFormKey.currentState!
                                                .validate()) {
                                              if (_itemimage == null) {
                                                setState(() {
                                                  noImage = true;
                                                });
                                              } else {
                                                setState(() {
                                                  noImage = false;
                                                });
                                              }
                                              var res = await _equipmentApi
                                                  .addEquipment(
                                                      equipmentNameController
                                                          .text,
                                                      _itemimage!,
                                                      newselectedCategory!.id,
                                                      _newCondition,
                                                      _newSize,
                                                      descriptionController
                                                          .text,
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
                                            }
                                          },
                                          child: const Text(
                                            'Add Equipment',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                  child:
                      CircularProgressIndicator(color: AppColor.gradientFirst),
                );
              }
            }),
      ),
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
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.06),
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
                    title: Text(
                      'Select Image',
                      style: TextStyle(
                        color: AppColor.homePageSubtitle,
                      ),
                    ),
                    content: const Text(
                        'Select image from device gallery or use device camera'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          getImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Camera',
                          style: TextStyle(
                            color: AppColor.gradientFirst,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          getImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                            color: AppColor.gradientFirst,
                          ),
                        ),
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
