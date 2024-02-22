import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MaterialApp.router(
    title: 'Navigation Basics',
    routerConfig: GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: "page1",
          builder: (context, state) {
            return const FirstRoute();
          },
        ),
        GoRoute(
          path: "/second",
          name: "page2",
          builder: (context, state) {
            return const SecondRoute();
          },
        ),
      ],
    ),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            context.pushNamed("page2");
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const SecondRoute()),
            // );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pop(context);
            context.pop();
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
