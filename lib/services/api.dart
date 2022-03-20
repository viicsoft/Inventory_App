//list all api endpoints

import '../models/auth.dart';

class BaseAPI {
  static String apiKey = "632F2EC9771B6C4C0BDF30BE21D9009B";
  static String base = 'http://34.79.101.196';   
  static var api = base + '/crisp_inventory/api';



  Map<String, String> key = {"X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B"};

  Map<String, String> headers = {
    "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",   
    "Content-Type": "application/json"
  };

  // more routes
  var registerPath = api + "/user/signup";  
  var loginPath = api + "/user/login";
  var logoutPath = api + "";
  var deleteUserPath = api + "/user/delete?id=";
  var profileUserPath = api + "/user/profile";
  var allUsersPath = api + "/user/all";
  var allEventsPath = api + "/events/all";
  var addEventsPath = api + "/events/add";
  var allEventsEquipmentPath = api + "/event_equipment_checklist/all";
  var addEventsEquipmentPath = api + "/event_equipment_checklist/add";
  var allEquipmentsPath = api + "/equipments/all";
  var addEquipmentsPath = api +  "/equipments/add";
  var addEquipmentsCategoryPath = api +  "/equipment_category/add";
  var allEquipmentsCategoryPath = api +  "/equipment_category/all";
  var allEventEquipmentsChecklistPath = api = "/event_equipment_checklist/all";
  var addEventEquipmentsChecklistPath = api + "/event_equipment_checklist/add";
  var updateEventEquipmentsChecklistPath = api + "/event_equipment_checklist/update";
  var detailEventEquipmentsChecklistPath = api + "/event_equipment_checklist/detail?id=";
  var deleteEventEquipmentsChecklistPath = api + "/event_equipment_checklist/delete?id=";

  var allEquipmemntCheckInPath = api + "/equipment_checkin/all";
  var checkinEquipmentsPath = api + "/equipment_checkin/add";
  var allEquipmemntCheckOutPath = api + "/event_equipment_checkout/all";
  var checkoutEquipmentsPath = api + "/event_equipment_checkout/add";
}
