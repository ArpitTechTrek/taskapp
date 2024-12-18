import 'package:flutter/material.dart';
import 'package:taskapp/objectbox.dart';
import 'package:taskapp/services/app_router.dart';
import 'package:taskapp/ui/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'blocs/bloc_exports.dart';

late final Objectbox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Initializing ObjectBox
  objectbox = await Objectbox.create();
  // Initializing Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Application entry point
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter appRouter = AppRouter();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Tasks App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        onGenerateRoute: appRouter.onGenrateRoute,
        initialRoute: SplashScreen.id,
        
      ),
    );
  }
}
