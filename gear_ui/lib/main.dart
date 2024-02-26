import 'package:flutter/material.dart';
import 'package:gear_ui/src/app.dart';
import 'package:gear_ui/src/utils/hive_boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveBoxes.startCache();

  runApp(const Application());
}
