// To parse this JSON data, do
//
//     final equipmentCheckIn = equipmentCheckInFromJson(jsonString);

import 'dart:convert';

EquipmentCheckIn equipmentCheckInFromJson(String str) => EquipmentCheckIn.fromJson(json.decode(str));

String equipmentCheckInToJson(EquipmentCheckIn data) => json.encode(data.toJson());

class EquipmentCheckIn {
  EquipmentCheckIn({
    required this.status,
    required this.message,
    required this.data,
    required this.total,
  });

  bool status;
  String message;
  Data data;
  int total;

  factory EquipmentCheckIn.fromJson(Map<String, dynamic> json) => EquipmentCheckIn(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
    "total": total,
  };
}

class Data {
  Data({
    required this.equipmentCheckin,
  });

  List<EquipmentCheckin> equipmentCheckin;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    equipmentCheckin: List<EquipmentCheckin>.from(json["equipment_checkin"].map((x) => EquipmentCheckin.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "equipment_checkin": List<dynamic>.from(equipmentCheckin.map((x) => x.toJson())),
  };
}

class EquipmentCheckin {
  EquipmentCheckin({
    required this.id,
    required this.equipmentId,
    required this.equipmentInDatetime,
  });

  String id;
  String equipmentId;
  DateTime equipmentInDatetime;

  factory EquipmentCheckin.fromJson(Map<String, dynamic> json) => EquipmentCheckin(
    id: json["id"],
    equipmentId: json["equipment_id"],
    equipmentInDatetime: DateTime.parse(json["equipment_in_datetime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "equipment_id": equipmentId,
    "equipment_in_datetime": equipmentInDatetime.toIso8601String(),
  };
}
