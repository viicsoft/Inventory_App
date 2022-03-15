import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:viicsoft_inventory_app/models/events.dart';
import 'package:viicsoft_inventory_app/services/sharedpref.dart';
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



  Future<http.StreamedResponse> addEvent(
      String eventName,
      XFile eventImage,
      String eventType,
      String eventLocation,
      String checkinDate,
      String checkOutDate) async {
    final String token = await SharedPrefrence().getToken();
    Map<String, String> headers = {
      "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
      'x-token': token,
    };
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest(
        "POST", Uri.parse(super.addEventsPath));
    //add header in http request
    request.headers.addAll(headers);

    //add text fields
    request.fields["event_name"] = eventName;
    request.fields["event_type"] = eventType;
    request.fields["event_location"] = eventLocation;
    request.fields["check_in_date"] = checkinDate;
    request.fields["check_out_date"] = checkOutDate;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("event_image", eventImage.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
          // var responseData = await response.stream.toBytes();
          // var responseString = String.fromCharCodes(responseData);
          // print(responseString);
          // print(response.statusCode);
    return response;
  }


}