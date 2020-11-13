import 'dart:convert';
import 'package:http/http.dart' as http;

class PdfService {
  static Future createPdf(payload) async {
    http.Response response = await http.post(
      "http://localhost:3000/pdfmaker",
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      print(response.bodyBytes);
      return response.bodyBytes;
    } else {
      print(response.body);
      return false;
    }
  }
}
