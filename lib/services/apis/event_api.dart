import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:viicsoft_inventory_app/models/eventequipment.dart';
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
      throw Exception('Failed to load Events');
    }
  }

 Future<List<EventEquipmentChecklist>> fetchAllEventsEquipment() async {

    final response = await http
        .get(Uri.parse(super.allEventsEquipmentPath), headers: super.headers);

    if (response.statusCode == 200) {
      final  _data = jsonDecode(response.body);
      final List<EventEquipmentChecklist> events = _data['data']['event_equipment_checklist'].map<EventEquipmentChecklist>((model) => EventEquipmentChecklist.fromJson(model as Map<String, dynamic>)).toList();
      return events;
    } else {
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
    return response;
  }
  
  Future<http.Response> addEventEquipment(String eventId, String equipmentId) async {
    final String token = await SharedPrefrence().getToken();
    var body = jsonEncode({'event_id': eventId, 'equipment_id': equipmentId});
    http.Response response =
    await http.post(Uri.parse(super.addEventsEquipmentPath), headers: {
      "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
      'x-token': token,
    }, body: body);

    if (response.statusCode == 200) {
      print(response.body);
      return response;
    } else {
      throw Exception('Failed auth');
    }
  }


}