import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  final response = await http.get(Uri.parse('http://localhost:3000/data'));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data);
  } else {
    throw Exception('Error al obtener datos');
  }
}

Future<void> sendData(String campo1, String campo2) async {
  final response = await http.post(
    Uri.parse('http://localhost:3000/data'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'campo1': campo1,
      'campo2': campo2,
    }),
  );

  if (response.statusCode == 201) {
    print('Datos insertados con éxito');
  } else {
    throw Exception('Error al insertar datos');
  }
}