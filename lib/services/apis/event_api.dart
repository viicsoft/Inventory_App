import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:viicsoft_inventory_app/models/events.dart';
import '../api.dart';

class EventAPI extends BaseAPI {

  Future<List<Event>> fetchAllEvents() async {

    final response = await http
        .get(Uri.parse(super.allEventsPath), headers: super.headers);

    if (response.statusCode == 200) {
      final  _data = jsonDecode(response.body);
      final List<Event> events = _data['data']['events'].map<Event>((model) => Event.fromJson(model as Map<String, dynamic>)).toList();
      return events;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Events');

    }
  }



}