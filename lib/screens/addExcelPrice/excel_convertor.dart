import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<List> excelToJson() async {
  List returnList = [];
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, allowedExtensions: ['xls', 'xlsx', 'csv']);
  if (result != null) {
    late Uint8List uploadfile;

    // String filename = basename(result.files.single.name);

    // print(filename)
    // File excelFile = File(result.files.single.path!);
    // var bytes = excelFile.readAsBytesSync();

    if (kIsWeb) {
      uploadfile = result.files.single.bytes!;
    } else {
      File excelFile = File(result.files.single.path!);
      uploadfile = excelFile.readAsBytesSync();
    }
    SpreadsheetDecoder decoder = SpreadsheetDecoder.decodeBytes(uploadfile);
    SpreadsheetTable? table = decoder.tables['Sheet'];
    // returnList = table!.rows.sublist(7);
    returnList = table!.rows;

    // var values = table!.rows[0];
    // decoder.updateCell('Sheet1', 0, 0, 1337);
  }
  // saveToDatabase();
  return returnList;
}

void customersDataGenerator(List excelCustomersList) {
  if (excelCustomersList.length > 1) {
    List hList = excelCustomersList[0]; // headers list
    bool isError = false;
    int code, name, ph, area;
    code = hList.indexOf('Code');
    name = hList.indexOf('Name');
    ph = hList.indexOf('Phone');
    area = hList.indexOf('Area');
    print(excelCustomersList.length);
    if (name != -1 && code != -1 && ph != -1 && area != -1) {
      int i = 4;
      Map<String, dynamic> dict = {};
      while (excelCustomersList[i][name] != null) {
        dict = {
          'code': excelCustomersList[i][code],
          'name': excelCustomersList[i][name],
          'area': excelCustomersList[i][area],
          'phone': excelCustomersList[i][ph],
        };
        print(dict);
        saveCustomersToDatabase(dict);
        i++;
        if (i == 100) {
          break;
        }
      }
    }
  } else {
    print("customers list is empty");
  }
}

Future<void> saveCustomersToDatabase(Map<String, dynamic> data) async {
  FirebaseFirestore.instance
      .collection("excelCustomers")
      .doc(data['code'])
      .set(data);
}
