import 'package:http/http.dart' as http;
const String baseUrl = 'http://localhost:3000/';
class Api{

  static Future<String> login (String email, String password) async {
    try {
      final response = await http.post(Uri.parse('${baseUrl}login'),headers: {
      'Accept': 'application/json'
    }, body: {
      'email': email,
      'password': password
    },
    );
      return response.body;
    } catch (e) {
      return 'Error: $e';
    }

  }

  static Future<String> getUsers () async {
    final response = await http.get(Uri.parse('${baseUrl}users'));
    if (response.statusCode == 200){
      return response.body;
    } else {
      return 'Error';
    }
  }

  static Future<String> getLocations () async {
    final response = await http.get(Uri.parse('${baseUrl}locations'));
    if (response.statusCode == 200){
      return response.body;
    } else {
      return 'Error';
    }
  }

  static Future<String> getLocationsbyName (String name) async {
    final response = await http.get(Uri.parse('${baseUrl}locations/$name'));
    if (response.statusCode == 200){
      return response.body;
    } else {
      return 'Error';
    }
  }

  static Future<String> getTypes () async {
    final response = await http.get(Uri.parse('${baseUrl}types'));
    if (response.statusCode == 200){
      return response.body;
    } else {
      return 'Error';
    }
  }

}