
import 'package:aquagoal/app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/*void main(){
  runApp(const MyApp());
}*/

Future<void> main() async {
  await Hive.initFlutter();
  runApp(const MyApp());

}
