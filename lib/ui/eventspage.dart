import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/models/events.dart';
<<<<<<< HEAD
import 'package:viicsoft_inventory_app/services/apis/event_api.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key, }) : super(key: key);
  //final List<Event> events;
=======
import 'package:viicsoft_inventory_app/ui/widgets/eventslist.dart';

import '../models/events.dart';
import '../services/apis/event_api.dart';

class EventsPage extends StatefulWidget {
  EventsPage({Key? key}) : super(key: key);
>>>>>>> 97ba0ff44978d23ee05e63ae2bdfcac92dbdd91b

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
<<<<<<< HEAD
  Future<List<Event>>? futureEvent;
  late final List<Event> events;
  EventAPI? _eventApi;
=======
  final EventAPI _eventApi = EventAPI();
  late final List<Events> eventsList;
  late Future futureEvent;
>>>>>>> 97ba0ff44978d23ee05e63ae2bdfcac92dbdd91b

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    futureEvent = _eventApi?.fetchAllEvents();
=======
    eventsList = [];
    futureEvent = _eventApi.fetchAllEvents();
>>>>>>> 97ba0ff44978d23ee05e63ae2bdfcac92dbdd91b
  }


  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
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
>>>>>>> 97ba0ff44978d23ee05e63ae2bdfcac92dbdd91b
