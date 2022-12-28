import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'HanNom.dart';


class SQLHelper{

  static const String _dbName = "unihan.db";
  static const List tableName = ['nom_tbl','hv_org','tamthientu','hv_word','tamtukinh','thientuvan','bachgiatinh','analect'];
  late Future<Database> database;

  Future<Database> initializeDB() async{
    return openDatabase(
        join(await getDatabasesPath(),_dbName)
    );
  }

  static Future<bool> existsDb(String path) async{
    return await databaseExists(path);
  }

  static void create() async {
    String path = join(await getDatabasesPath(),_dbName);
    // Should happen only the first time you launch your application
    print("Creating new copy from asset");
    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}
    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", _dbName));
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
    print("done");
  }

  Future<List<HanNom>> search({required String key, required int indexTable}) async {

    if (key.isEmpty) {
      return <HanNom>[];
    }
    var database =await openDatabase(
        join(await getDatabasesPath(),_dbName)
    );

    String condition = "unicode like '%$key%' or ";

    switch(indexTable){
      case 0:
        condition += "nomTxt = '$key'";
        break;
      case 1:
        condition += "hHan ='$key'";
        break;
      case 2:
        condition += "hHan like '%$key%' or hNom like '$key %' or hNom = '$key'";
        break;
      case 3:
        condition += " hHan like '%$key%'";
        break;
      case 4:
        condition += "hHan like '%$key %'";
        break;
      case 5:
        condition += "hHan like '%$key %'";
        break;
      case 6:
        condition += "hHan like '%$key %'";
        break;
      case 7:
        condition += "hHan like '%$key %'";
        break;
    }

    List<Map<String, dynamic>> map = await database.transaction((txn) async {
      return await txn.query(tableName[indexTable],where: condition);
    });

    return List.generate(map.length, (index) {
      return HanNom(
        unicode: map[index]['unicode'],
        nomTxt: map[index]['nomTxt'],
        nomStr: map[index]['nomStr'],
        nomDef: map[index]['nomDef'],
        nomCtx: map[index]['nomCtx'],
        nomSrc: map[index]['nomSrc'],
        strType: map[index]['strType'],
        engDef: map[index]['engDef'],
        hHan: map[index]['hHan'],
        hNom: map[index]['hNom'],
        hDef: map[index]['hDef'],
        hPinyin: map[index]['hPinyin'],
        hTraditionalVariant: map[index]['hTraditionalVariant'],
        hSimplifiedVariant: map[index]['hSimplifiedVariant'],
        hDefinition: map[index]['hDefinition'],
        comment: map[index]['comment']
      );
    });

  }

  static String safeText(String? s){
    return s ?? "";
  }

}