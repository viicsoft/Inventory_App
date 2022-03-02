import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viicsoft_inventory_app/models/events.dart';
import '../api.dart';

class EventAPI extends BaseAPI {

  static List<Event> parse(String responseBody) {
    final Map<String, dynamic> parsed = json.decode(responseBody);

    return List<Event>.from(
        parsed["data"]["events"].map((x) => Event.fromJson(x)));
  }

  Future<Events> fetchAllEvents() async {

    final response = await http
        .get(Uri.parse(super.allEventsPath), headers: super.headers);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      //print total events
      print(Events.fromJson(body).data.events.length);
      return Events.fromJson(body);

      print(body);
      return body;
      // final parsed = parse(body);
      // final result = parsed as List<EventAPI>;


    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Events');

    }
  }

}