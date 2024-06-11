import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';

import 'package:kchat/global/environment.dart';
import 'package:kchat/models/login_response.dart';
import 'package:kchat/models/register_response.dart';
import 'package:kchat/models/usuario.dart';

class AuthService extends ChangeNotifier {
  Usuario? usuario;

  // Create storage
  final _storage = new FlutterSecureStorage();

  //Getters del token de forma estatica
  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token!;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  bool _authenticating = false;
  bool get authenticating => _authenticating;
  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  bool _registering = false;
  bool get registering => _registering;
  set registering(bool value) {
    _registering = value;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    authenticating = true;

    final data = {
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Environment.apiUrl}/login');

    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    authenticating = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;

      await _saveToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    registering = true;
    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Environment.apiUrl}/login/new');

    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    registering = false;

    if (resp.statusCode == 200) {
      final registerResponse = registerResponseFromJson(resp.body);
      usuario = registerResponse.usuario;

      await _saveToken(registerResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future _saveToken(String token) async {
    // Write value
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    // Delete value
    await _storage.delete(key: 'token');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token') ?? '';

    final uri = Uri.parse('${Environment.apiUrl}/login/renew');

    final resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      },
    );

    if (resp.statusCode == 200) {
      final registerResponse = registerResponseFromJson(resp.body);
      usuario = registerResponse.usuario;

      await _saveToken(registerResponse.token);

      return true;
    } else {
      logout();
      return false;
    }
  }
}
