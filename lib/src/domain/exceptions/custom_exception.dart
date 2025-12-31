
import 'package:arp_lib/src/app.dart';
import 'package:http/http.dart' as http;



  Future<T> safeCall<T>(
    String name, 
    Future<T> Function() function, 
  ) async {
  try {
    return await function();
  } on CustomException {
    rethrow; // Si ya es una CustomException, no la envuelvas de nuevo
  } on http.ClientException catch (e) {
    throw CustomException(cause: 'Network error in $name: ${e.message}');
  } on FormatException catch (e) {
    throw CustomException(cause: 'JSON format error in $name', originalError: e);
  } catch (e) {
    throw CustomException(
      cause: 'Unexpected error in $name',
      originalError: e,
    );
  }
}


class CustomException implements Exception {
  final String cause;
  final Function? function;
  final dynamic originalError; // Para depuración técnica

  CustomException({
    required this.cause,
    this.function,
    this.originalError,
  }) {
    String logMsg = '${DateTime.now()} $runtimeType: $cause';
    if (originalError != null) logMsg += ' | Original: $originalError';
    
    logger.severe(logMsg);

    if (function != null) {
      function!();
    }
  }

  @override
  String toString() => cause;
}

