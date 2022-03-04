import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EventsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<EventsPage> {
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
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Events in View',
                    style: TextStyle(
                        fontSize: 20, color: AppColor.homePageContainerTextBig),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          itemCount: 4,//Provider.of<InventoryData>(context).event.length,
                          itemBuilder: (_, int index) {
                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => EventsDetailPage(
                                //             eventDetail: Provider.of<InventoryData>(context).event[index],
                                //           )),
                                // );
                              },
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 3,
                                  shadowColor: AppColor.gradientSecond,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // image: DecorationImage(
                                              //   image: Provider.of<InventoryData>(context).event[index].eventImage,
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("",
                                                //Provider.of<InventoryData>(context).event[index].eventName,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                'Created by:  John Due',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Text("",
                                                    //Provider.of<InventoryData>(context).event[index].startingDate,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey[500],
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  const Text(
                                                    'To',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text("",
                                                    //Provider.of<InventoryData>(context).event[index].endingDate,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey[500],
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Expanded(child: Container()),
                                          IconButton(
                                            onPressed: () {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           EventsDetailPage(
                                              //             eventDetail:
                                              //                Provider.of<InventoryData>(context).event[index],
                                              //           )),
                                              // );
                                            },
                                            icon: Icon(
                                              Icons.arrow_forward_ios,
                                              color: AppColor.gradientFirst,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
