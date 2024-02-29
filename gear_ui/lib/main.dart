import 'package:flutter/material.dart';

// external packages
import 'package:get/get.dart';

// internal packages
import 'package:gear_ui/src/app.dart';
import 'package:gear_ui/src/features/cart/presentation/page_controller.dart';
import 'package:gear_ui/src/local_storage/utils/cached_objects.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CachedObjects.startCache();

  Get.lazyPut(() => CartPageController());

  runApp(const Application());
}
