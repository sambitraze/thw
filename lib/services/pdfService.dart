
import 'package:http/http.dart' as http;

class PdfService {
  static Future createPdf(payload) async {
    http.Response response = await http.post(
      "http://tandoorhut.tk/pdfmaker",
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      print(response.body);
      return false;
    }
  }
}
