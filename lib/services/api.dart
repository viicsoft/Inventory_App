//list all api endpoints

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
  var allUsersPath = api + "/users/all";
  var allEventsPath = api + "/events/all";
}
