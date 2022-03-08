import 'package:flutter/cupertino.dart';
import 'package:viicsoft_inventory_app/models/equipments.dart';

import '../../services/apis/equipment_api.dart';

class allEquipments extends StatefulWidget {
  const allEquipments({Key? key}) : super(key: key);

  @override
  _allEquipmentsState createState() => _allEquipmentsState();
}

class _allEquipmentsState extends State<allEquipments> {
  final EquipmentAPI _equipmentAPI = EquipmentAPI();
  late final List<Equipment> equipmentList;
  late Future futureEvent;

  @override
  void initState() {
    super.initState();
    futureEvent = _equipmentAPI.fetchAllEquipments();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
