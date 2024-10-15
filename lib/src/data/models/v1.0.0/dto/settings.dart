import 'dart:convert';

import 'package:arp_lib/src/domain/controllers/blocs/settings_controller/settings_controller.dart';



class Settings {
  final bool darkTheme;
  final String language;

  Settings({
    required this.darkTheme,
    required this.language,
  });

  Settings copyWith({bool? darkTheme, String? language}) {
    return Settings(
      darkTheme: darkTheme ?? this.darkTheme,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'darkTheme': darkTheme,
      'language': language,
    };
  }

  factory Settings.fromJson(String json) {
    Map<String, dynamic> decodedJson;
    try {
      decodedJson = jsonDecode(json);
    } catch (e) {
      print('Error al decodificar JSON: $e');
      // Usar valores predeterminados si hay un error
      decodedJson = defaultSettings.toJson();
    }

    return Settings(
      darkTheme: decodedJson['darkTheme'] as bool? ?? defaultSettings.darkTheme,
      language: decodedJson['language'] as String? ?? defaultSettings.language,
    );
  }
}
