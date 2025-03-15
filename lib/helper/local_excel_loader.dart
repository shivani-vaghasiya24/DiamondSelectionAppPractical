import 'dart:typed_data';
import 'package:diamond_selection_app/utils/app_assets.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocalExcelLoader {
  static Future<List<Map<String, dynamic>>> loadExcelData() async {
    try {
      // Load Excel file from assets
      ByteData data = await rootBundle.load(AppAssets.diamondPath);
      Uint8List bytes = data.buffer.asUint8List();

      var excel = Excel.decodeBytes(bytes);
      List<Map<String, dynamic>> diamonds = [];

      // Read the first sheet
      var sheet = excel.tables[excel.tables.keys.first];
      if (sheet == null) return [];

      // Get column headers
      List<String> headers =
          sheet.rows[1].map((cell) => cell?.value.toString() ?? '').toList();

      // Convert rows to a list of maps
      for (var row in sheet.rows.skip(2)) {
        Map<String, dynamic> diamond = {};
        for (int i = 0; i < headers.length; i++) {
          if (i < row.length) {
            diamond[headers[i]] = row[i]?.value;
          }
        }
        diamonds.add(diamond);
      }
      // log("Diamods Data $diamonds");
      return diamonds;
    } catch (e) {
      print("Error loading Excel: $e");
      return [];
    }
  }
}
