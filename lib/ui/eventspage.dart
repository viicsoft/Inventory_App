import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/models/events.dart';
import 'package:viicsoft_inventory_app/ui/widgets/eventslist.dart';

import '../models/events.dart';
import '../services/apis/event_api.dart';

class EventsPage extends StatefulWidget {
  EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final EventAPI _eventApi = EventAPI();
  late final List<Event> eventsList;
  late Future futureEvent;

  @override
  void initState() {
    super.initState();
    futureEvent = _eventApi.fetchAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("EventsPage"),
        ),
        body: Container(
            child: Center(
          child: FutureBuilder<List<Event>>(
              future: EventAPI().fetchAllEvents(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final results = snapshot.data!;
                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (ctx) =>
                                //         DetailScreen(productModel: results[index]),
                                //   ),
                                // );
                              },
                              title: Text(
                                // ignore: avoid_dynamic_calls
                                results[index].eventName.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                // ignore: avoid_dynamic_calls
                                results[index].eventLocation.toString(),
                                style: TextStyle(color: Colors.black87),
                              ),
                              leading: Icon(
                                Icons.circle,
                                color: Colors.grey.shade900,
                                size: 15,
                              ),
                            ),
                            const Text(
                              "...........................................................................................",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              }),
        )));
  }
}
