import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/events.dart';
import 'package:viicsoft_inventory_app/ui/event/all_event.dart';
import 'package:viicsoft_inventory_app/ui/event/future_event.dart';
import 'package:viicsoft_inventory_app/ui/event/past_event.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EventsPage> createState() => _ItemsPageState();
}

late final List<Event> eventsList;
late Future futureEvent;

class _ItemsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: AppColor.gradientFirst, fontSize: 20, fontWeight: FontWeight.w500),
            bottom: TabBar(
              indicatorColor: AppColor.gradientFirst,
              labelColor: AppColor.gradientFirst,
              tabs: [
                Tab(
                    icon: Icon(Icons.event_available, color: AppColor.gradientFirst),
                    text: 'All Event'),
                Tab(
                  icon: Icon(Icons.event_rounded, color: AppColor.gradientFirst),
                  text: 'Future',
                ),
                Tab(
                  icon: Icon(Icons.event_note_sharp, color: AppColor.gradientFirst),
                  text: 'Past',
                ),
              ],
            ),
            title: const Center(child: Text('Events')),
          ),
          body:  const TabBarView(
            children: [
              AllEvent(),
              FutureEvent(),
              PastEvent()
            ],
          ),
        ),
      ),
    );
  }

  
}
