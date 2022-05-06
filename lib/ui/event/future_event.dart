import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/futureevent.dart';
import 'package:viicsoft_inventory_app/services/apis/event_api.dart';
import 'package:viicsoft_inventory_app/ui/event/events_detail_page.dart';

class FutureEvent extends StatefulWidget {
  const FutureEvent({Key? key}) : super(key: key);

  @override
  State<FutureEvent> createState() => _FutureEventState();
}

class _FutureEventState extends State<FutureEvent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  child: FutureBuilder<List<EventsFuture>>(
                      future: EventAPI().fetchFutureEvents(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: CircularProgressIndicator(
                                color: AppColor.gradientFirst),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          final results = snapshot.data!;
                          return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              itemCount: results.length,
                              itemBuilder: (_, int index) {
                                var startingdate = DateTime.parse(
                                    "${results[index].checkOutDate}");
                                var endingdate = DateTime.parse(
                                    "${results[index].checkInDate}");
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EventsDetailPage(
                                          eventDetail: results[index],
                                        ),
                                      ),
                                    );
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
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        results[index]
                                                            .eventImage),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    results[index]
                                                        .eventName
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .homePageSubtitle,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    'Location: ${results[index].eventLocation.toString()}',
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${startingdate.day}-${startingdate.month}-${startingdate.year}',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey[500],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      const Text(
                                                        'To',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        '${endingdate.day}-${endingdate.month}-${endingdate.year}',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey[500],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Expanded(child: Container()),
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EventsDetailPage(
                                                        eventDetail:
                                                            results[index],
                                                      ),
                                                    ),
                                                  );
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
                              });
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                                color: AppColor.gradientFirst),
                          );
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
