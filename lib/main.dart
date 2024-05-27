
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:world_tunes/core/providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/models/radio_model.dart';
import 'core/providers/radio_provider.dart';
import 'core/routing/router.dart';
import 'core/utils/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyASaVVDsXzum_224hmhAe4u-dgPLc5SbbQ",
          authDomain: "world-tunes-fc900.firebaseapp.com",
          projectId: "world-tunes-fc900",
          storageBucket: "world-tunes-fc900.appspot.com",
          messagingSenderId: "6782180243",
          appId: "1:6782180243:web:d9c37b82deb0e672706666",
          measurementId: "G-GBKC98Q3LH"
      ),
    );
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  Hive.registerAdapter<RadioStation>(RadioStationAdapter());
  await Hive.initFlutter();

  await initializeDependencies();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    print("Flutter error: ${details.exception}");
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppRouter>(
          lazy: false,
          create: (_) => AppRouter(),
        ),
        ChangeNotifierProvider(create: (context) => injector.get<RadioProvider>()),
        ChangeNotifierProvider(create: (_) => injector.get<AuthProvider>()),
      ],
      child: Builder(builder: (BuildContext context) {
        final router = Provider.of<AppRouter>(context, listen: false).router;
        return MaterialApp.router(
          builder: (context, child) => BaseWidget(child: child!),
          debugShowCheckedModeBanner: false,
          title: 'World Tunes',
          theme: ThemeData(
            useMaterial3: true,
          ),
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
          routeInformationParser: router.routeInformationParser,
          );
        },
    )
    );
  }
}

class BaseWidget extends StatelessWidget {
  final Widget? child;
  const BaseWidget({super.key, this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child!,
    );
  }
}