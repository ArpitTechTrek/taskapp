import 'package:flutter/material.dart';
import 'package:taskapp/ui/screens/login_screen.dart';
import 'package:taskapp/ui/screens/register_screen.dart';
import 'package:taskapp/ui/screens/tasks_screen.dart';

class AppRouter {

    Route? onGenrateRoute(RouteSettings routeSettings){
        switch(routeSettings.name){
            case TasksScreen.id:
                return MaterialPageRoute(builder: (_) => const TasksScreen());
            case RegisterScreen.id:
                return MaterialPageRoute(builder: (_) => const RegisterScreen());
            case LoginScreen.id:
                return MaterialPageRoute(builder: (_) => const LoginScreen());
            default:
              return null;

        }
    }
}