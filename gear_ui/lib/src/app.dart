import 'package:flutter/material.dart';
import 'package:gear_ui/src/routes/app_router.dart';
import 'package:gear_ui/src/utils/hive_boxes.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      HiveBoxes.clearCache();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Gear",
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.config,
    );
  }
}
