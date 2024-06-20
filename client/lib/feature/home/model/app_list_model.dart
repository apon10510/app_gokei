import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AppListModel extends ValueNotifier<List<Map<String, String>>> {
  AppListModel(List<Map<String, String>> value) : super(value);

  Future<void> loadAppData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('yourAppsList');
    if (jsonString != null) {
      List<dynamic> jsonResponse = jsonDecode(jsonString);
      value = jsonResponse.map((item) => Map<String, String>.from(item)).toList();
    }
  }

  Future<void> saveAppData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(value);
    await prefs.setString('yourAppsList', jsonString);
  }

  void addApp(Map<String, String> app) {
    value.add(app);
    saveAppData();
    notifyListeners();
  }

  void removeApp(int index) {
    value.removeAt(index);
    saveAppData();
    notifyListeners();
  }
}
