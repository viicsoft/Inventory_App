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
  late final List<Events> eventsList;
  late Future futureEvent;

  @override
  void initState() {
    super.initState();
    eventsList = [];
    futureEvent = _eventApi.fetchAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    if (eventsList == null) {
      eventsList = [];
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("EventsPage"),
      ),
      body: Container(
        child: Center(
            child: FutureBuilder<Events>(
          future: EventAPI().fetchAllEvents(),
          builder: (context, snapshot) {
            return snapshot.hasError
                ?  EventsList(context, snapshot)
                : Center(child: Text('${snapshot.error.toString()}'));
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _navigateToAddScreen(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }


  Widget EventsList(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
        itemCount: 10,
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
                    title: Text(snapshot.data.events[index].eventName),
                    subtitle: Text(snapshot.data.events[index].toString()),
                  ),
                )
            );
        });
  }

  // _navigateToAddScreen (BuildContext context) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => AddDataWidget()),
  //   );
  // }
}
