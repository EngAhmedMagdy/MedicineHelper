// add_product_screen.dart

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:medicinehelper/dbHelper/mongodbAPI.dart';
import 'package:medicinehelper/models/medicine.dart';


class AddMedicineScreen extends StatefulWidget {
  static String routeName = "/add_medicine";

  const AddMedicineScreen({super.key});
  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  TextEditingController barcodeController = TextEditingController();
  TextEditingController nameArController = TextEditingController();
  TextEditingController descriptionArController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  // Map of dropdown items
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Medicine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: barcodeController,
                    readOnly: true,
                    decoration: InputDecoration(labelText: 'barcode'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String barcodeValue = await _incrementCounter();
                    setState(() {
                      barcodeController.text = barcodeValue;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16), // Adjust the size as needed
                    primary: Colors.blue, // Button color
                    elevation: 8, // Elevation shadow
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 25, // Icon size
                  ),
                )
              ],
            ),

            SizedBox(height: 20),
            TextField(
              controller: nameArController,
              decoration: InputDecoration(labelText: 'الاسم بالعربي'),
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionArController,
              decoration: InputDecoration(labelText: 'وصف'),
              keyboardType: TextInputType.multiline,
              maxLines: 3 //or null,
            ),

            SizedBox(height: 20),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'السعر'),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Handle saving the product
                    await _saveMedicine();
                  },
                  child: Text('حفظ الدواء'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveMedicine() async {
    String newRec = "نجحت الاضافة";
    String exRec = "نجح التعديل";
    String faild = "فشل الاضافة";
    try {
      //if(barcodeController.text =="" || await MongoDatabase.validBar(barcodeController.text))
      //{
       // throw Exception("not vaild barcode");
      //}
      int outcome = await MongoDatabase.insertMedicine(medicine(barcode: barcodeController.text,
          nameAr: nameArController.text,
          descriptionAr: descriptionArController.text));
      //print(outcome);
      if(outcome == 1)
        {
          _Sound(newRec);
        }
      if(outcome == 2)
      {
        _Sound(exRec);
      }
        _clear();
        //Navigator.pop(context);
    }
    catch (ex) {
      print(ex);

    }

  }

  Future<String> _incrementCounter() async {
    var result = await BarcodeScanner.scan();
    return result.rawContent;
  }
  void _clear() {
    barcodeController.text = "";
    nameArController.text = "";
    descriptionArController.text = "";
    priceController.text = "";
  }
  void _Sound(String text) {

    FlutterTts flutterTts = FlutterTts();

    Future<void> speakArabic(String text) async {
      await flutterTts.setLanguage("ar-SA"); // or "ar"
      await flutterTts.setPitch(1);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(text);
    }
    speakArabic(text);
  }
}
