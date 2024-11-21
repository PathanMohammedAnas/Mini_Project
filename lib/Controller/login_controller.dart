import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/login_model.dart';

class AuthController {
  Future<UserModel?> login(String email, String password) async {
    final url = Uri.parse('https://fakestoreapi.com/users');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> users = jsonDecode(response.body);

        for (var user in users) {
          if (user['email'] == email && user['password'] == password) {
            return UserModel.fromJson(user); // Login success
          }
        }
      }
      return null; // Invalid login if no match found
    } catch (e) {
      print(e);
      return null;
    }
  }
}
