import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Pour émulateur Android
  static const String baseUrl = 'http://10.0.2.2:3000/';
  
  // Pour appareil physique (remplacez par votre IP locale)
  // static const String baseUrl = 'http://192.168.1.100:3000/';
  
  // Pour iOS
  // static const String baseUrl = 'http://localhost:3000/';

  Future<dynamic> get(String endpoint) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    
    try {
      print('GET Requête: ${baseUrl + endpoint}');
      final response = await http.get(
        Uri.parse(baseUrl + endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      ).timeout(const Duration(seconds: 15));
      print('GET Réponse: ${response.statusCode}');
      return _handleResponse(response);
    } catch (e) {
      print('GET Erreur: $e');
      throw Exception('Erreur de connexion: $e');
    }
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      print('POST Requête: ${baseUrl + endpoint}');
      print('POST Data: ${jsonEncode(data)}');
      
      final response = await http.post(
        Uri.parse(baseUrl + endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 15));
      
      print('POST Réponse: ${response.statusCode} ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      print('POST Erreur: $e');
      throw Exception('Erreur de connexion: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur ${response.statusCode}: ${response.body}');
    }
  }
} 