// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'App Gokai',
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      home: const MyHomePage(),
      material: (_, __) => MaterialAppData(),
      cupertino: (_, __) => CupertinoAppData(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Platform Widgets'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlatformText('Hello, Platform!'),
            const SizedBox(height: 20),
            PlatformElevatedButton(
              child: PlatformText('Press Me'),
              onPressed: () {
                showPlatformDialog(
                  context: context,
                  builder: (_) => PlatformAlertDialog(
                    title: PlatformText('Alert'),
                    content: PlatformText('This is a platform-specific dialog'),
                    actions: <Widget>[
                      PlatformDialogAction(
                        child: PlatformText('OK'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
