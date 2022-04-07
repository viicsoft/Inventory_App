// To parse this JSON data, do
//
//     final avialableEquipment = avialableEquipmentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AvialableEquipment avialableEquipmentFromJson(String str) => AvialableEquipment.fromJson(json.decode(str));

String avialableEquipmentToJson(AvialableEquipment data) => json.encode(data.toJson());

class AvialableEquipment {
    AvialableEquipment({
        required this.status,
        required this.message,
        required this.data,
        required this.total,
    });

    bool status;
    String message;
    Data data;
    int total;

    factory AvialableEquipment.fromJson(Map<String, dynamic> json) => AvialableEquipment(
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
        required this.equipmentsAvailable,
    });

    List<EquipmentsAvailable> equipmentsAvailable;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        equipmentsAvailable: List<EquipmentsAvailable>.from(json["equipments_available"].map((x) => EquipmentsAvailable.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "equipments_available": List<dynamic>.from(equipmentsAvailable.map((x) => x.toJson())),
    };
}

class EquipmentsAvailable {
    EquipmentsAvailable({
        required this.equipmentName,
        required this.equipmentId,
        required this.equipmentCondition,
        required this.equipmentBarcode,
        required this.equipmentImage,
    });

    String equipmentName;
    String equipmentId;
    String equipmentCondition;
    String equipmentBarcode;
    String equipmentImage;

    factory EquipmentsAvailable.fromJson(Map<String, dynamic> json) => EquipmentsAvailable(
        equipmentName: json["equipment_name"],
        equipmentId: json["equipment_id"],
        equipmentCondition: json["equipment_condition"],
        equipmentBarcode: json["equipment_barcode"],
        equipmentImage: json["equipment_image"],
    );

    Map<String, dynamic> toJson() => {
        "equipment_name": equipmentName,
        "equipment_id": equipmentId,
        "equipment_condition": equipmentCondition,
        "equipment_barcode": equipmentBarcode,
        "equipment_image": equipmentImage,
    };
}
