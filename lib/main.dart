import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:mapmytrip/routes/routes.dart';
import 'package:mapmytrip/services/firestore.dart';
import 'package:mapmytrip/services/models.dart';
import 'package:mapmytrip/themes/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          } else if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider(
              create: (_) => FirestoreService().streamReport(),
              initialData: Report(),
              child: MaterialApp(
                routes: appRoutes,
                theme: appTheme,
              ),
            );
          } else {
            return const Text(
              'loading',
              textDirection: TextDirection.ltr,
            );
          }
        });
  }
}
