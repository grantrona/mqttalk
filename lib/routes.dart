import 'package:find_my_device/view/home.dart';
import 'package:find_my_device/view/manage_email.dart';
import 'package:find_my_device/view/manage_password.dart';
import 'package:find_my_device/view/messages.dart';
import 'package:find_my_device/view/about.dart';
import 'view/login.dart';
import 'view/register.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/search': (context) => const Messages(),
  '/login': (context) => const Login(),
  '/register': (context) =>  const Register(),
  '/preferences': (context) => const About(), 
  '/managePassword' : (context) => const ManagePassword(),
  '/manageEmail' : (context) => const ManageEmail(),
};