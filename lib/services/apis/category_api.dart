import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:viicsoft_inventory_app/models/category.dart';
import 'package:viicsoft_inventory_app/services/api.dart';
import 'package:http/http.dart' as http;
import '../sharedpref.dart';

class CategoryAPI extends BaseAPI {
  Future<List<EquipmentCategory>> fetchAllCategory() async {
    final String token = await SharedPrefrence().getToken();
    final response =
        await http.get(Uri.parse(super.allEquipmentsCategoryPath), headers: {
      "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'x-token': token,
    });

    if (response.statusCode == 200) {
      final _data = jsonDecode(response.body);
      final List<EquipmentCategory> category = _data['data']
              ['equipment_category']
          .map<EquipmentCategory>((model) =>
              EquipmentCategory.fromJson(model as Map<String, dynamic>))
          .toList();
      return category;
    } else {
      throw Exception('Failed to load Equipments');
    }
  }

  Future<http.StreamedResponse> addCategory(String name, XFile image) async {
    final String token = await SharedPrefrence().getToken();
    Map<String, String> headers = {
      "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
      'x-token': token,
    };
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest(
        "POST", Uri.parse(super.addEquipmentsCategoryPath));
    //add header in http request
    request.headers.addAll(headers);

    //add text fields
    request.fields["name"] = name;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("image", image.path);
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
