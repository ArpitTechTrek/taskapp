// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskapp/ui/screens/tasks_screen.dart';
import 'register_screen.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Insert email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value) == false){
                      return 'Please enter a valid email';
                    }
                      return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: 'Insert password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 6) {
                      return 'Password should be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _auth
                      .signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text)
                      .then((value) {
                    GetStorage().write('token', value.user!.uid);
                    GetStorage().write('email', value.user!.email);
                    Navigator.pushReplacementNamed(context, TasksScreen.id);
                  }).onError((error, stackTrace) {
                    var snackBar = const SnackBar(
                      content: Text("These is an error",
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.red,
                      duration: Duration(milliseconds: 1000),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                child: const Text('Login'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RegisterScreen.id);
                  },
                  child: const Text('Don\'t have an Account?')),
            ],
          ),
        ),
      ),
    );
  }
}