import 'dart:convert';
import 'dart:developer';

import 'package:arp_lib/src/data/models/v1.0.0/dto/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SetttingsRepository {
  static Future<Settings?> read(String pameter) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      Settings settings = Settings.fromJson(prefs.getString(pameter) ?? '');

      return settings;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> write(String pameter, Map object) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString(pameter, jsonEncode(object));

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
