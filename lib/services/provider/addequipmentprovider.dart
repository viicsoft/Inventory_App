
// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:viicsoft_inventory_app/models/equipments.dart';
// import 'package:http/http.dart' as http;
// import 'package:viicsoft_inventory_app/models/eventequipment.dart';
// import 'package:viicsoft_inventory_app/services/api.dart';
// import 'package:viicsoft_inventory_app/services/apis/equipment_api.dart';
// import 'package:viicsoft_inventory_app/services/apis/event_api.dart';
// import 'package:viicsoft_inventory_app/services/sharedpref.dart';

// class AddEventEquipmentData extends ChangeNotifier { 
//   List<String, dynamic> _map =[];

//   Future<List<EquipmentElement>> fetchAllEquipments() async {
//     final String token = await SharedPrefrence().getToken();

//     final response =
//         await http.get(Uri.parse(BaseAPI().allEquipmentsPath), headers: {
//       "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
//       "Content-Type": "application/json",
//       'Accept': 'application/json',
//       'x-token': token,
//     });

//     if (response.statusCode == 200) {
//       final _data = jsonDecode(response.body);
//       final List<EquipmentElement> equipments = _data['data']['equipments']
//           .map<EquipmentElement>((model) =>
//               EquipmentElement.fromJson(model as Map<String, dynamic>))
//           .toList();
//           notifyListeners();
//       return equipments;
//     } else {
//       throw Exception('Failed to load Equipments');
//     }
    
//   }

//   // void allEquipment(){
//   //   = fetchAllEquipments();
   
   
//   // }

//   // List<EventEquipmentChecklist> equipment = [];
//   // final EventAPI _eventAPI = EventAPI();
//   //  final EquipmentAPI _equipmentAPI = EquipmentAPI();

//   // void getEventId({String? eventId}){
//   // }
  
//   // void addEquipment(){
//   //   var eventEquipment = _eventAPI.addEventEquipment(eventId, equipmentId);
//   //   equipment.add(eventEquipment.);
//   //   notifyListeners();
   
      

//   //  }
// }