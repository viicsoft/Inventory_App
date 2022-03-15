import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:provider/provider.dart';


class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  XFile? _itemimage;
  DateTime? selecteddate;
  bool hasData = false;
  TextEditingController controller = TextEditingController();
  DateTime startingDate = DateTime.now();
  DateTime endingDate = DateTime.now();

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 50, maxHeight: 700, maxWidth: 650);

    setState(() {
      _itemimage = pickedFile;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              padding: const EdgeInsets.only(top: 50, left: 10, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 110,
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
                          size: 23,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(child: Container()),
                      Text(
                        'Add Event',
                        style: TextStyle(
                            fontSize: 23,
                            color: AppColor.homePageContainerTextBig),
                      ),
                      Expanded(child: Container()),
                    ],
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
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: ListView(
                          children: [
                            itemImages(context),
                            const SizedBox(height: 40),
                            TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                labelText: 'Event name*',
                              ),
                            ),
                            const SizedBox(height: 20),
                            ListTile(
                              trailing: Text(
                                  "${startingDate.day}/${startingDate.month}/${startingDate.year}"),
                              leading: const Text(
                                'Event starting Date',
                                style: TextStyle(fontSize: 14),
                              ),
                              title: const Icon(Icons.arrow_drop_down),
                              onTap: () => _startingDate(context),
                            ),
                            ListTile(
                              trailing: Text(
                                  "${endingDate.day}/${endingDate.month}/${endingDate.year}"),
                              leading: const Text(
                                'Event Ending Date',
                                style: TextStyle(fontSize: 14),
                              ),
                              title: const Icon(Icons.arrow_drop_down),
                              onTap: () => _endingDate(context),
                            ),
                            const SizedBox(height: 50),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                //for (int i = 0; i < event.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: AppColor.gradientFirst),
                                    onPressed: () {
                                      // Provider.of<InventoryData>(context,
                                      //         listen: false)
                                      //     .addEvent(
                                      //         _itemimage != null
                                      //             ? FileImage(
                                      //                 File(_itemimage!.path))
                                      //             : const AssetImage(
                                      //                     'assets/musk.jpg')
                                      //                 as ImageProvider,
                                      //         controller.text,
                                      //         '${startingDate.day}/${startingDate.month}/${startingDate.year}',
                                      //         '${endingDate.day}/${endingDate.month}/${endingDate.year}');
                                      // Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Save & Update',
                                      style: TextStyle(fontSize: 16),
                                    ),
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
              width: 200,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: _itemimage != null
                      ? FileImage(File(_itemimage!.path))
                      : const AssetImage('assets/musk.jpg') as ImageProvider,
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

  _startingDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: startingDate,
      firstDate: DateTime(2016),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != startingDate) {
      setState(() {
        startingDate = selected;
      });
    }
  }

  _endingDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: endingDate,
      firstDate: DateTime(2016),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != endingDate) {
      setState(() {
        endingDate = selected;
      });
    }
  }
}
