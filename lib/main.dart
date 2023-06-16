import 'package:flutter/material.dart';
import 'package:save_enerrgy/screens/home_screen/home_screen.dart';
import 'package:save_enerrgy/screens/loginScreen/loginScreen.dart';
import 'package:save_enerrgy/screens/signup_screen/signUp_admin.dart';
import 'package:save_enerrgy/themes/myTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('tokenAdmin');
  runApp( MyApp(token??''));
}

class MyApp extends StatelessWidget {
  String token;
  MyApp(this.token);

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.theme,
          initialRoute: token.isEmpty ? LoginScreen.routeName : HomeScreen.routeName,
      routes: {
            LoginScreen.routeName : (_)=> LoginScreen(),
            SignUpScreen.routeName : (_)=> SignUpScreen(),
            HomeScreen.routeName : (_)=> HomeScreen(),
      },
    );
  }
}
