import 'package:flutter/widgets.dart';
import 'package:medicinehelper/addmedicine.dart';
import 'package:medicinehelper/home_screen.dart';
import 'package:medicinehelper/init_screen.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(title: "scan medicine"),
  AddMedicineScreen.routeName: (context) => const AddMedicineScreen(),
};
