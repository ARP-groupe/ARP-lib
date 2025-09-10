import 'dart:html' as html;
import 'dart:io' as io;

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:path_provider/path_provider.dart';

abstract class ExcelTools {
  /// Convierte una lista de textos en una lista de TextCellValue para
  /// insertarla en un excel
  static List<TextCellValue> toTextCellValue(List<String> list) {
    // Inicializa una lista vacía de TextCellValue.
    List<TextCellValue> cellList = [];

    // Añade cada elemento de la lista como un TextCellValue.
    for (var element in list) {
      cellList.add(TextCellValue(element));
    }

    return cellList;
  }

  static Future<void> generateFile(
    BuildContext context,
    Excel excel,
    String appName,
  ) async {
    // Nombre del archivo
    String excelName =
        '${appName}_report_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.xlsx';

    // Guardar archivo
    // Usa encode() en vez de save() para evitar la descarga automática
    List<int>? fileBytes = excel.encode();

    if (fileBytes != null) {
      if (kIsWeb) {
        // WEB: Descargar archivo usando el navegador
        final blob = html.Blob([Uint8List.fromList(fileBytes)]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', excelName)
          ..click();
        html.Url.revokeObjectUrl(url);
      } else {
        // DESKTOP/MÓVIL: Guardar en descargas
        final io.Directory? downloadsDir = await getDownloadsDirectory();
        if (downloadsDir == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('No se pudo obtener el directorio de descargas')),
          );
          return;
        }
        String excelPath = '${downloadsDir.path}\\$excelName';
        io.File(excelPath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo excel exportado: $excelName')),
      );
    }
  }
}
