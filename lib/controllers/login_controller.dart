import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hufi/constants/api_endpoints.dart';
import 'package:hufi/views/student_attendance_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> login() async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndpoints.instance.tokenUrl);
    Map body = {
      'username': usernameController.text.trim(),
      'password': passwordController.text.trim()
    };

    try {
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        String accesToken = json['access_token'];

        final SharedPreferences prefs = await _prefs;
        prefs.setString("acces_token", accesToken);

        usernameController.clear();
        passwordController.clear();

        Get.off(const StudentAttendancePage());
      } else {
        throw json["error_message"] ?? "Unknown error occurred";
      }
    } catch (err) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Error"),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(err.toString())],
            );
          });
    }
  }
}
