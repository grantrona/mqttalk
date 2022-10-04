import 'package:find_my_device/view/home.dart';
import 'package:find_my_device/view/messages.dart';
import 'package:find_my_device/view/preferences.dart';
import 'view/login.dart';
import 'view/register.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/search': (context) => const Messages(),
  '/login': (context) => const Login(),
  '/register': (context) =>  const Register(),
  '/preferences': (context) => const Preferences(), 
};