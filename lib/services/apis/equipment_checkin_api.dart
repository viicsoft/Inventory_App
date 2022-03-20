

import 'dart:convert';

import 'package:viicsoft_inventory_app/services/api.dart';
import 'package:http/http.dart' as http;
import '../../models/equipmentcheckin.dart';
import '../sharedpref.dart';

class EquipmentCheckInAPI extends BaseAPI {

  Future<List<EquipmentCheckin>> fetchAllEquipmentCheckIn() async {
    final String token = await SharedPrefrence().getToken();
    final response = await http
        .get(Uri.parse(super.allEquipmemntCheckInPath),
        headers: {
        "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'x-token': token,
        });

    if (response.statusCode == 200) {
      final  _data = jsonDecode(response.body);
      final List<EquipmentCheckin> equipments = _data['data']['equipment_checkin'].map<EquipmentCheckin>((model) => EquipmentCheckin.fromJson(model as Map<String, dynamic>)).toList();
      return equipments;
    } else {
      throw Exception('Failed to load Events');
    }
  }

  Future<http.Response> checkinEquipments(String id) async {
    final String token = await SharedPrefrence().getToken();

    var body = jsonEncode({'equipment_id': id});
    final http.Response response = await http.post(
        Uri.parse(super.checkinEquipmentsPath),
        headers: <String, String>{
          "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'x-token': token,
        },
        body: body
    );
    if (response.statusCode == 200) {
      //print(' delete user: ${response.body}');
      print(response.body);
      return response;
    } else {
      throw Exception('Failed to Add Equipment to CheckList.');
    }
  }

}