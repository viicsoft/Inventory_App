import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:viicsoft_inventory_app/models/events.dart';
import '../api.dart';

class EventAPI extends BaseAPI {

  Future<List<Event>> fetchAllEvents() async {
    final response = await http
        .get(Uri.parse(super.allEventsPath), headers: super.headers);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> body = jsonDecode(response.body);
      List<Event> events = body.map((dynamic item) => Event.fromJson(item)).toList();
      return events;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Events');

    }
  }

}