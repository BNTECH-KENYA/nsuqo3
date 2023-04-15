/*


import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reading_Excel_File extends StatefulWidget {

  const Reading_Excel_File({Key? key}) : super(key: key);
  @override
  State<Reading_Excel_File> createState() => _Reading_Excel_FileState();

}

class _Reading_Excel_FileState extends State<Reading_Excel_File> {


  void readexcelsheet() async {

    var colIterableSheet = excel['ColumnIterables'];

    var colIterables = ['A', 'B', 'C', 'D', 'E'];
    int colIndex = 0;

    colIterables.forEach((colValue) {
      colIterableSheet.cell(CellIndex.indexByColumnRow(
        rowIndex: colIterableSheet.maxRows,
        columnIndex: colIndex,
      ))
        ..value = colValue;
    });



  }


  List<String> rowdetail = [];
  List<File> photoFiles = [];

  _importFromExcel() async {

    //print(">>>>>>>>>>>>>>>>>>|-pdflength${photoFiles?.length}");
    final result = await FilePicker.platform.pickFiles(
        allowMultiple:false,
        type: FileType.custom,
        allowedExtensions: ['pptx','xlsx']

    );
    if(result == null) return;

    setState(
            (){

          photoFiles =result.paths.map((path) => File(path!)).toList() ;
        }
    );

    var file = photoFiles[0].path;

    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      print("${table}");
      for (var row in excel.tables[table]!.rows) {
        print("${row} !!!!!!!!!!!! *********************");


        if (row?.any((element) => element?.value?.toString() == name) ?? false) {
          Data data = row?.firstWhere((element) => element?.value?.toString()?.toLowerCase() == name);
          nameIndex = data.colIndex;
        }
        // email variable is for Name of Column Heading for Email
        if (row?.any((element) => element?.value?.toString() == email) ?? false) {
          Data data = row?.firstWhere((element) => element?.value?.toString()?.toLowerCase() == email);
          emailIndex = data.colIndex;
        }
        if (nameIndex != nu ll && emailIndex != null) {
          if (row[nameIndex]?.value.toString().toLowerCase() != name.toLowerCase() && row[emailIndex]?.value.toString().toLowerCase() != email.toLowerCase())
            excelList.add(
              ExcelSheetData(
                name: row[nameIndex]?.value.toString(),
                email: row[emailIndex]?.value.toString(),
              ),
            );
        }


        if(row[0] == null)
          {
                  print("*********************");
          }
        else{

          print("${row[0]?.value}");
          rowdetail.add(row[0]!.value.toString());

        }

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(

      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,

        child: Center(
          child: InkWell(

              onTap:() async {

              await _importFromExcel();

              },
              child: Icon(Icons.download, color: Colors.black,)),

        ),
      ),
    );
  }
}

 */