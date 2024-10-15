import 'package:excel/excel.dart';

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
}
