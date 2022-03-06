import 'dart:convert';

import 'package:viicsoft_inventory_app/models/equipments.dart';
import 'package:viicsoft_inventory_app/services/api.dart';
import 'package:http/http.dart' as http;
import '../../models/users.dart';
import '../sharedpref.dart';

class EquipmentAPI extends BaseAPI {

  Future<List<EquipmentElement>> fetchAllEquipments () async {

    final String token = await SharedPrefrence().getToken();

    final response = await http
        .get(Uri.parse(super.allEquipmentsPath),
        headers: {
          "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'x-token': '$token',
        });

    if (response.statusCode == 200) {
      final  _data = jsonDecode(response.body);
      final List<EquipmentElement> equipments = _data['data']['equipments'].map<EquipmentElement>((model) => EquipmentElement.fromJson(model as Map<String, dynamic>)).toList();
      return equipments;
    } else {
      throw Exception('Failed to load Equipments');
    }
  }
}