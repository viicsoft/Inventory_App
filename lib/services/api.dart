//list all api endpoints
import 'package:viicsoft_inventory_app/services/api_keys.dart';

class BaseAPI {

  static String apiKey = "632F2EC9771B6C4C0BDF30BE21D9009B";
  static String base = 'http://34.79.101.196';
  static var api = base + '/crisp_inventory/api';


  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B"
  };

  // more routes
  var registerPath = api + "/user/signup";
  var loginPath = api + "/user/login";
  var logoutPath = api + "/events/all";
  var allUsersPath = api + "/users/all";
  var allEventsPath = api + "/events/all";


}
