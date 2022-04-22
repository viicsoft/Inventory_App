import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/services/apis/category_api.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController _categoryName = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  XFile? _categoryimage;
  final picker = ImagePicker();
  bool noImage = false;

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
        source: source, imageQuality: 50, maxHeight: 700, maxWidth: 650);

    setState(() {
      _categoryimage = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 70),
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
        child: Column(children: [
          Text(
            'Create New Category',
            style: TextStyle(
                fontSize: 25, color: AppColor.homePageContainerTextBig),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(70),
                topLeft: Radius.circular(70),
              ),
            ),
            child: Form(
              key: globalFormKey,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        categoryImages(context),
                        Center(
                          child: Text(
                            noImage ? 'No image selected !' : '',
                            style: TextStyle(color: AppColor.gradientFirst),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 8),
                        TextFormField(
                          controller: _categoryName,
                          validator: (input) =>
                              (input!.isEmpty) ? "Add Category Name" : null,
                          decoration: const InputDecoration(
                            //border: OutlineInputBorder(),
                            labelText: 'Category name',
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColor.gradientFirst),
                              onPressed: () async {
                                if (globalFormKey.currentState!.validate()) {
                                  if (_categoryimage == null) {
                                    setState(() {
                                      noImage = true;
                                    });
                                  } else {
                                    setState(() {
                                      noImage = false;
                                    });
                                  }
                                  var res = await CategoryAPI().addCategory(
                                      _categoryName.text.trim(),
                                      _categoryimage!);

                                  if (res.statusCode == 200) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text("Category added")));
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: const Text(
                                'Create Category',
                                style: TextStyle(fontSize: 14),
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
          )),
        ]),
      ),
    );
  }

  Column categoryImages(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: _categoryimage != null
                      ? FileImage(File(_categoryimage!.path))
                      : const AssetImage('assets/profile.jpg') as ImageProvider,
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
