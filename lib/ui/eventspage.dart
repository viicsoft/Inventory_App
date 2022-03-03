import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/models/events.dart';
import 'package:viicsoft_inventory_app/services/apis/event_api.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key, }) : super(key: key);
  //final List<Event> events;

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  Future<List<Event>>? futureEvent;
  late final List<Event> events;
  EventAPI? _eventApi;

  @override
  void initState() {
    super.initState();
    futureEvent = _eventApi?.fetchAllEvents();
  }


  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
          itemCount: events == null ? 0 : events.length,
          itemBuilder: (BuildContext context, int index) {
            return
              Card(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => DetailWidget(cases[index])),
                      // );
                    },
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(events[index].eventName.toString()),
                      subtitle: Text(events[index].eventLocation.toString()),
                    ),
                  )
              );
          }
          );
  }
}