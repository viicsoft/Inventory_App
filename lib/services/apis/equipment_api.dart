import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:viicsoft_inventory_app/models/equipments.dart';
import 'package:viicsoft_inventory_app/services/api.dart';
import 'package:http/http.dart' as http;
import '../../models/users.dart';
import '../sharedpref.dart';

class EquipmentAPI extends BaseAPI {
  Future<List<EquipmentElement>> fetchAllEquipments() async {
    final String token = await SharedPrefrence().getToken();

    final response =
        await http.get(Uri.parse(super.allEquipmentsPath), headers: {
      "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'x-token': token,
    });

    if (response.statusCode == 200) {
      final _data = jsonDecode(response.body);
      final List<EquipmentElement> equipments = _data['data']['equipments']
          .map<EquipmentElement>((model) =>
              EquipmentElement.fromJson(model as Map<String, dynamic>))
          .toList();
      return equipments;
    } else {
      throw Exception('Failed to load Equipments');
    }
  }

  Future<http.StreamedResponse> addEquipment(
      String equipmentName,
      XFile image,
      String categoryId,
      String condition,
      String size,
      String description,
      String barcode) async {
    final String token = await SharedPrefrence().getToken();
    Map<String, String> headers = {
      "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
      'x-token': token,
    };
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest(
        "POST", Uri.parse(super.addEquipmentsPath));
    //add header in http request
    request.headers.addAll(headers);

    //add text fields
    request.fields["equipment_name"] = equipmentName;
    request.fields["equipment_condition"] = condition;
    request.fields["equipment_size"] = size;
    request.fields["equipment_description"] = description;
    request.fields["equipment_barcode"] = barcode;
    request.fields["equipment_category_id"] = categoryId;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("equipment_image", image.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    print(response.statusCode);
    return response;
  }
}
