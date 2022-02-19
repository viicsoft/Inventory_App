//list all api endpoints
import 'package:viicsoft_inventory_app/services/api_keys.dart';


class API {
  API({required this.apiKey});
  final String apiKey;

  factory API.inventory() => API(apiKey: APIKeys.apiKey);

  static const String host = '34.79.101.196';

  Uri tokenUri() =>  Uri(
    scheme: "http",
    host: host,
    path: 'token',
    queryParameters: {'grant_type': 'client_credentials'},
  );
}