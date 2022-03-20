// To parse this JSON data, do
//
//     final eventEquipmentCheckOut = eventEquipmentCheckOutFromJson(jsonString);

import 'dart:convert';

EventEquipmentCheckOut eventEquipmentCheckOutFromJson(String str) => EventEquipmentCheckOut.fromJson(json.decode(str));

String eventEquipmentCheckOutToJson(EventEquipmentCheckOut data) => json.encode(data.toJson());

class EventEquipmentCheckOut {
  EventEquipmentCheckOut({
    required this.status,
    required this.message,
    required this.data,
    required this.total,
  });

  bool status;
  String message;
  Data data;
  int total;

  factory EventEquipmentCheckOut.fromJson(Map<String, dynamic> json) => EventEquipmentCheckOut(
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
    required this.eventEquipmentCheckout,
  });

  List<EventEquipmentCheckout> eventEquipmentCheckout;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    eventEquipmentCheckout: List<EventEquipmentCheckout>.from(json["event_equipment_checkout"].map((x) => EventEquipmentCheckout.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "event_equipment_checkout": List<dynamic>.from(eventEquipmentCheckout.map((x) => x.toJson())),
  };
}

class EventEquipmentCheckout {
  EventEquipmentCheckout({
    required this.id,
    required this.eventId,
    required this.equipmentId,
    required this.equipmentOutDatetime,
  });

  String id;
  String eventId;
  String equipmentId;
  DateTime equipmentOutDatetime;

  factory EventEquipmentCheckout.fromJson(Map<String, dynamic> json) => EventEquipmentCheckout(
    id: json["id"],
    eventId: json["event_id"],
    equipmentId: json["equipment_id"],
    equipmentOutDatetime: DateTime.parse(json["equipment_out_datetime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "event_id": eventId,
    "equipment_id": equipmentId,
    "equipment_out_datetime": equipmentOutDatetime.toIso8601String(),
  };
}
