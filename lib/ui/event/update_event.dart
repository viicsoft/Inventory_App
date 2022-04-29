import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/events.dart';
import 'package:viicsoft_inventory_app/services/apis/event_api.dart';

class UpdateEventPage extends StatefulWidget {
  final Event eventDetail;
  const UpdateEventPage({Key? key, required this.eventDetail})
      : super(key: key);

  @override
  State<UpdateEventPage> createState() => _UpdateEventPageState();
}

class _UpdateEventPageState extends State<UpdateEventPage> {
  XFile? _eventImage;
  //DateTime? selecteddate;

  DateTime endingDate = DateTime.now();
  DateTime startingDate = DateTime.now();

  bool hasData = false;

  final EventAPI _eventAPI = EventAPI();

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
        source: source, imageQuality: 50, maxHeight: 700, maxWidth: 650);

    setState(() {
      _eventImage = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    TextEditingController _eventName =
        TextEditingController(text: widget.eventDetail.eventName);
    TextEditingController _eventType =
        TextEditingController(text: widget.eventDetail.eventType);
    TextEditingController _eventLocation =
        TextEditingController(text: widget.eventDetail.eventLocation);
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
              width: screenSize.width,
              height: 110,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: screenSize.width * 0.06,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(child: Container()),
                      Text(
                        'Update Event',
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
                width: screenSize.width,
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
                        padding: EdgeInsets.only(top: screenSize.width * 0.03),
                        child: ListView(
                          children: [
                            eventImages(context),
                            SizedBox(height: screenSize.width * 0.13),
                            TextField(
                              controller: _eventName,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                labelText: 'Event Name*',
                              ),
                            ),
                            SizedBox(height: screenSize.width * 0.06),
                            TextField(
                              controller: _eventType,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                labelText: 'Event Type*',
                              ),
                            ),
                            SizedBox(height: screenSize.width * 0.06),
                            TextField(
                              controller: _eventLocation,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                labelText: 'Event Location*',
                              ),
                            ),
                            SizedBox(height: screenSize.width * 0.06),
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
                            SizedBox(height: screenSize.width * 0.12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: AppColor.gradientFirst),
                                  onPressed: () async {
                                    if (startingDate == DateTime.now() &&
                                        endingDate == DateTime.now()) {
                                      startingDate =
                                          widget.eventDetail.checkOutDate;
                                      endingDate =
                                          widget.eventDetail.checkInDate;
                                    }
                                    var res = await _eventAPI.updateEvent(
                                        _eventName.text,
                                        _eventType.text,
                                        _eventLocation.text,
                                        endingDate.toString(),
                                        startingDate.toString(),
                                        widget.eventDetail.id);

                                    if (res.statusCode == 200) {
                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text("Event Updated")));
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text("Something went wrong"),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Save & Update',
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
      ),
    );
  }

  Column eventImages(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.06),
                image: DecorationImage(
                  image: NetworkImage(widget.eventDetail.eventImage),
                  // _eventImage != null
                  //     ? FileImage(File(_eventImage!.path))
                  //     : const AssetImage('assets/musk.jpg') as ImageProvider,
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

  _startingDate(BuildContext context) async {
    startingDate = widget.eventDetail.checkOutDate;
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: startingDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (selected != null && selected != startingDate) {
      setState(() {
        startingDate = selected;
      });
    }
  }

  _endingDate(BuildContext context) async {
    endingDate = widget.eventDetail.checkInDate;
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: endingDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (selected != null && selected != endingDate) {
      setState(() {
        widget.eventDetail.checkInDate = endingDate;
        endingDate = selected;
      });
    }
  }
}
