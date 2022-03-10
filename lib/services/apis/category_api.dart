import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viicsoft_inventory_app/models/category.dart';
import 'package:viicsoft_inventory_app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:viicsoft_inventory_app/ui/Menu/add_category.dart';
import '../sharedpref.dart';

class CategoryAPI extends BaseAPI {

  Future<List<EquipmentCategory>> fetchAllCategory () async {
    final String token = await SharedPrefrence().getToken();
    final response = await http
        .get(Uri.parse(super.allEquipmentsCategoryPath),
        headers: {
          "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'x-token': token,
        });

    if (response.statusCode == 200) {
      final  _data = jsonDecode(response.body);
      final List<EquipmentCategory> category = _data['data']['equipment_category'].map<EquipmentCategory>((model) => EquipmentCategory.fromJson(model as Map<String, dynamic>)).toList();
      return category;
    } else {
      throw Exception('Failed to load Equipments');
    }
  }



  Future<http.Response> addCategory(String categoryName, XFile? categoryImage) async {
    final String token = await SharedPrefrence().getToken();
    var body = jsonEncode({
        'name': categoryName,
        'image': categoryImage,});
    http.Response response =
    await http.post(Uri.parse(super.addEquipmentsCategoryPath), headers: {
          "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'x-token': token,
        }, body: body);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load Equipments');
    }
  }
}