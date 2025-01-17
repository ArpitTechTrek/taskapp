import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskapp/ui/screens/login_screen.dart';
import 'package:taskapp/ui/screens/tasks_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  static const String id = 'SpalshScreen';
}

class _SplashScreenState extends State<SplashScreen> {
  final GetStorage _getStorage = GetStorage();

  @override
  void initState() {
    super.initState();
    openNextPage(context);
  }

  openNextPage(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      if (_getStorage.read('token') == null ||
          _getStorage.read('token') == '') {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, TasksScreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
