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
  var deleteUserPath = api + "/user/delete";
  var allUsersPath = api + "/user/all";
  var allEventsPath = api + "/events/all";
  var allEquipmentsPath = api + "/equipments/all";
  var addEquipmentsCategoryPath = api +  "/equipment_category/add";
  var allEquipmentsCategoryPath = api +  "/equipment_category/all";
}
