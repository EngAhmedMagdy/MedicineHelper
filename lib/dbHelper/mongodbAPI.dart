



import 'package:mongo_dart/mongo_dart.dart';
import 'package:medicinehelper/models/medicine.dart';

class MongoDatabase {
  static var db, collectionMedicine;
  static bool _isConnected = false;
  static connect() async {


    if (!_isConnected) {
      final String MongoDbUrl = "mongodb+srv://ahmedmahdya:imOABn8XZxX4YIT2@cluster0.uagnhjl.mongodb.net/medicineai?retryWrites=true&w=majority&appName=Cluster0";
      final String mongodbUrlOld= "mongodb://ahmedmahdya:imOABn8XZxX4YIT2@ac-cquifam-shard-00-00.uagnhjl.mongodb.net:27017,ac-cquifam-shard-00-01.uagnhjl.mongodb.net:27017,ac-cquifam-shard-00-02.uagnhjl.mongodb.net:27017/medicineai?ssl=true&replicaSet=atlas-mfw8lr-shard-0&authSource=admin&retryWrites=true&w=majority&appName=Cluster0";
      db = await Db.create(mongodbUrlOld);
      await db.open();
      collectionMedicine = db.collection("medicine");
      _isConnected = true;
    }
  }

  static Future<medicine?> ReadMedicine(String barcode) async {
    await connect();
    final data = await collectionMedicine.findOne(where.eq("barcode", barcode));
    if(data == null)
      {
        return null;
      }
    return medicine.fromJson(data);
  }

  static Future<int> insertMedicine(medicine document) async {
    await connect();
    var v1 = await collectionMedicine.findOne({"barcode": document.barcode});
    print(v1);
    if(v1 == null)
      {
        var d = await collectionMedicine.insert(document.toJson());
        return 1;
      }
    else
      {
        v1 = document.toJson();
        await collectionMedicine.replaceOne({"barcode": document.barcode}, v1);
        return 2;
      }

  }
  static Future<void> updateMedicine(medicine document) async {
    //print(document.toJson());
    await connect();
    await collectionMedicine.insert(document.toJson());
  }
  static Future<bool> validBar(String str) async {
    //print(document.toJson());
    await connect();
    final data = await collectionMedicine.findOne(where.eq("barcode", str));
    if(data == null)
    {
      return false;
    }
    else
    {
      return true;
    }
  }
}

