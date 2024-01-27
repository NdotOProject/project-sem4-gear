import 'package:flutter/material.dart';
import 'package:gear_ui/src/app.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  runApp(const Application());
}
