import 'dart:convert';
import 'package:http/http.dart' as http;

// class Table {
//   Table({
//     this.name,
//     this.createdAt,
//     this.updatedAt,
//     this.id,
//   });
//   String name;
//   String id;
//   DateTime createdAt;
//   DateTime updatedAt;
//   factory Table.fromJson(Map<String, dynamic> json) => Table(
//         name: json["name"] == null ? null : json["name"],
//       );
//   Map<String, dynamic> toJson() => {
//         "_id": id == null ? null : id,
//         "name": name == null ? null : name,
//         "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
//         "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
//       };
// }

class TableService {
  static Future createTable(number) async {
    http.Response response = await http.post(
      Uri.parse("http://64.225.85.5/table/create"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": "Table $number"}),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future tableCount() async {
    http.Response response = await http.get(
      Uri.parse("http://64.225.85.5/table/count"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      return responseMap["tablecount"];
    } else {
      return 0;
    }
  }
}
