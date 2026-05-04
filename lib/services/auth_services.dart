import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthServices extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCwQYMMlROaHlO12wGuTuIwBxTezL2iBdU';

  String? currentEmail;

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken,
    });

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse.containsKey('idToken')) {
      currentEmail = email;
      notifyListeners();
      return null;
    }

    return decodedResponse['error']['message'];
  }

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken,
    });

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse.containsKey('idToken')) {
      currentEmail = email;
      notifyListeners();
      return null;
    }

    return decodedResponse['error']['message'];
  }

  Future<String?> resetPassword(String email) async {
    final url = Uri.https(_baseUrl, '/v1/accounts:sendOobCode', {
      'key': _firebaseToken,
    });

    final Map<String, dynamic> data = {
      'requestType': 'PASSWORD_RESET',
      'email': email,
    };

    final response = await http.post(url, body: json.encode(data));

    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse.containsKey('email')) {
      return null;
    }

    return decodedResponse['error']['message'];
  }

  void logout() {
    currentEmail = null;
    notifyListeners();
  }
}
