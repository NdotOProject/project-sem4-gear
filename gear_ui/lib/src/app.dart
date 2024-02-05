import 'package:flutter/material.dart';
import 'package:gear_ui/src/routes/app_router.dart';
import 'package:gear_ui/src/utils/hive_boxes.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with WidgetsBindingObserver {
  AppLifecycleState? _lastLifecycleState;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecycleState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_lastLifecycleState == null) {
      // print("on active");
    } else {
      HiveBoxes.closeApp();
    }

    return MaterialApp.router(
      title: "Gear",
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.config,
    );
  }
}
