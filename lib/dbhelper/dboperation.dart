  import 'dart:developer';
// import 'package:badmiton_app/controller/dashbatchconroller/batch_list_provider.dart';
import 'package:badmiton_app/dbmodel/batchmodel.dart';
import 'package:sqflite/sqflite.dart';

class DBOperation{
      static Future insertBatchTable(
      Database db, List<Batchs> values) async {
    var data = values.map((e) => e.toMap()).toList();
    var batch = db.batch();
    data.forEach((es) async {
      batch.insert(batchtablename, es);
    });
    final List<Map<String, Object?>> result =
        await db.rawQuery('''SELECT * FROM  $batchtablename ''');
    log("batchtablename:::$result");
    await batch.commit();
  }

  }

