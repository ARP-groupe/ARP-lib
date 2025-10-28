import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

ValueNotifier<bool> isDebug = ValueNotifier<bool>(false);


final Logger logger = Logger('MiApp');
void init_logger() async {
  // Configurar salida de logs
  Logger.root.level = Level.ALL; // Captura todos los niveles
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}
