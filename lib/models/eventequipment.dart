// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Welcome({
      required  this.status,
       required  this.message,
       required  this.data,
       required  this.total,
    });

    bool status;
    String message;
    Data data;
    int total;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
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
        required this.eventEquipmentChecklist,
    });

    List<EventEquipmentChecklist> eventEquipmentChecklist;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        eventEquipmentChecklist: List<EventEquipmentChecklist>.from(json["event_equipment_checklist"].map((x) => EventEquipmentChecklist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "event_equipment_checklist": List<dynamic>.from(eventEquipmentChecklist.map((x) => x.toJson())),
    };
}

class EventEquipmentChecklist {
    EventEquipmentChecklist({
        required this.id,
        required this.eventId,
        required this.equipmentId,
    });

    String id;
    String eventId;
    String equipmentId;

    factory EventEquipmentChecklist.fromJson(Map<String, dynamic> json) => EventEquipmentChecklist(
        id: json["id"],
        eventId: json["event_id"],
        equipmentId: json["equipment_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
        "equipment_id": equipmentId,
    };
}
