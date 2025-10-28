import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter/services.dart';

ValueNotifier<bool> isDebug = ValueNotifier<bool>(false);









// Logger
final Logger logger = Logger('MiApp');
void init_logger() async {
  // Configurar salida de logs
  Logger.root.level = Level.ALL; // Captura todos los niveles
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}










// Tools
void copyOnClipboard(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  // copied successfully
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Item copied to clipboard')),
  );
}

SnackBar errorSnackBar(String text) {
  return SnackBar(
    content: Text(text),
    backgroundColor: Colors.redAccent,
  );
}
