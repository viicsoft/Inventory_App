import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/models/events.dart';
import 'package:viicsoft_inventory_app/services/apis/event_api.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late Future<List<Event>> futureEvent;
  final EventAPI _eventApi = EventAPI();

  @override
  void initState() {
    super.initState();
    futureEvent = _eventApi.fetchAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Event>>(
            future: futureEvent,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                          height: 75,
                          color: Colors.white,
                          child: Center(child: Text("${snapshot.data!}"),
                          ),
                      )
                  );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
