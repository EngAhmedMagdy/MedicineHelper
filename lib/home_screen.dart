import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:medicinehelper/dbHelper/mongodbAPI.dart';
import 'package:medicinehelper/models/medicine.dart';


class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  const HomeScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _incrementCounter();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(40), // Adjust the size as needed
                      primary: Colors.blue, // Button color
                      elevation: 8, // Elevation shadow
                    ),
                    child: Icon(
                      Icons.medication_liquid_sharp,
                      size: 250, // Icon size
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  void _incrementCounter() {

    FlutterTts flutterTts = FlutterTts();
    String NOTf = "غير موجود";
    Future<void> speakArabic(String text) async {
      await flutterTts.setLanguage("ar-SA"); // or "ar"
      await flutterTts.setPitch(1);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(text);
    }
    Future<void> scanBar() async {
      var result = await BarcodeScanner.scan();

      medicine? m = await MongoDatabase.ReadMedicine(result.rawContent);
      if(m == null)
        {
          speakArabic(NOTf);
        }
      else
        {
          speakArabic(m.descriptionAr ?? "");
        }
    }
// Call the function with Arabic text
    scanBar();
  }
}
