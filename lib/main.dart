import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/ui/eventspage.dart';

void main() async {
  runApp( const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory App',
      home: EventsPage(),
    );
  }
}