import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';

import '../../models/events.dart';

class EventsDetailPage extends StatefulWidget {
  final Event eventDetail;
  const EventsDetailPage({Key? key, required this.eventDetail}) : super(key: key);

  @override
  State<EventsDetailPage> createState() => _EventsDetailPageState();
}

class _EventsDetailPageState extends State<EventsDetailPage> {
  
  @override
  Widget build(BuildContext context) { 
    var startingdate = DateTime.parse("${widget.eventDetail.checkOutDate}");
  var endingdate = DateTime.parse("${widget.eventDetail.checkInDate}"); 
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
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
                  ),
                ),
                Expanded(child: Container()),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: AppColor.gradientFirst),
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image:  NetworkImage(widget.eventDetail.eventImage),
                    fit: BoxFit.fill,
                  ),
                  color: AppColor.homePageContainerTextBig,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(80),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(2, 5),
                      blurRadius: 4,
                      color: AppColor.gradientSecond.withOpacity(0.2),
                    )
                  ]),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 25, left: 40, right: 20, bottom: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Event Name:    ${widget.eventDetail.eventName}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.homePageSubtitle),
                    ),
                    const SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location:  ${widget.eventDetail.eventLocation}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.homePageSubtitle,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Center(
                              child: Text(
                                'Date:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColor.homePageSubtitle,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${startingdate.day}-${startingdate.month}-${startingdate.year}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.gradientFirst,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'To',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${endingdate.day}-${endingdate.month}-${endingdate.year}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.gradientFirst,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Equipments  Needed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColor.homePageTitle,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (_, int index) {
                  return Container(
                    height: 150,
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      shadowColor: AppColor.gradientSecond,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColor.homePageTitle),
                                      padding: const EdgeInsets.all(5),
                                      height: 18,
                                      child: Text(
                                        'microphone',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                            color: AppColor
                                                .homePageContainerTextBig),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                          image:
                                              AssetImage('assets/squat1.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:   [
                                     SizedBox(
                                       width: MediaQuery.of(context).size.width,
                                        child:  Text(
                                          '360 Camera',
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: AppColor.homePageTitle,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: const Text(
                                          'Camera long lens with high dimension, highest quality',
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                  ],),
                                )
                              ],
                            ),
                            Row(children: [
                              Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green,
                              ),
                              padding: const EdgeInsets.all(5),
                              height: 20,
                              width: 50,
                              child: Center(
                                child: Text(
                                  'Good',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: AppColor.homePageContainerTextBig),
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColor.gradientFirst),
                                padding: const EdgeInsets.all(5),
                                height: 20,
                                width: 50,
                                child: Center(
                                  child: Text(
                                    'Scan',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: AppColor.homePageContainerTextBig),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            const SizedBox(height: 10),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: AppColor.gradientFirst,
                              ),
                            ),
                            ],)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
