// import 'package:flutter/cupertino.dart';
// import 'package:viicsoft_inventory_app/models/avialable_equipment.dart';
// import 'package:viicsoft_inventory_app/models/equipments.dart';
// import 'package:viicsoft_inventory_app/services/apis/equipment_api.dart';

// class DataClass extends ChangeNotifier {
//   List<EquipmentsAvailable>? availableEquiments;
//   List<EquipmentElement>? equiment;
//   bool loading = false;
//   Future<void> avialableEquipments() async {
//     loading = true;
//     availableEquiments = await EquipmentAPI().fetchAvialableEquipments();

//     loading = false;
//     notifyListeners();
//   }

//   Future<void> equipments() async {
//     loading = true;
//     equiment = await EquipmentAPI().fetchAllEquipments();

//     loading = false;
//     notifyListeners();
//   }
// }
