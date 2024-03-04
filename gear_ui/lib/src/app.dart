import 'package:flutter/material.dart';
import 'package:gear_ui/src/features/product/presentation/home_page/page.dart';
import 'package:gear_ui/src/local_storage/utils/cached_objects.dart';
import 'package:gear_ui/src/routes/app_router.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    _listener = AppLifecycleListener(
      onPause: () {
        CachedObjects.clearCache();
      },
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
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
