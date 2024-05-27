import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/radio_model.dart';


class ApiServices {


  /// = = = = = = RADIO API SERVICES = = = = = =

  static Future<List<RadioStation>?> fetchRadios({required String country}) async {
    List<String> servers = [
      'https://de1.api.radio-browser.info',
      'https://nl.api.radio-browser.info',
      'https://at1.api.radio-browser.info',
    ];

    // Randomize the server list
    servers.shuffle();
    String selectedServer = servers.first;

    // Make the request to the selected server
    try {
      final response = await http.get(Uri.parse('$selectedServer/json/stations/bystate/$country'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((station) => RadioStation.fromJson(station)).toList();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }


}