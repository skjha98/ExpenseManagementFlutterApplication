import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_manager/providers/settingsState.dart';
import 'package:expense_manager/screens/create.dart';
import 'package:expense_manager/screens/home.dart';
import 'package:expense_manager/screens/login.dart';
import 'package:expense_manager/screens/register.dart';
import 'package:expense_manager/screens/settings.dart';
import 'package:expense_manager/screens/welcome.dart';
import 'package:expense_manager/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Color primaryColor = Color(0xff03da9d);
  final Color accentColor = Color(0xff333333);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsState>(
      create: (context) => SettingsState(),
      child: MaterialApp(
        title: 'Tabs',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: accentColor,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: Colors.white),
          fontFamily: 'Rubik',
          textTheme: TextTheme(
            display1:
            TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            display2: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            button: TextStyle(color: Colors.white),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: primaryColor,
            textTheme: ButtonTextTheme.normal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.all(8),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        routes: {
          Welcome.id: (context) => Welcome(),
          Register.id: (context) => Register(),
          Login.id: (context) => Login(),
          Create1.id: (context) => Create1(),
          Settings.id: (context) => Settings()
        },
        home: FutureBuilder<FirebaseUser>(
          future: Auth.getCurrentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.done) {
              if (userSnapshot.error != null) {
                print("error");
                return Text(userSnapshot.error.toString());
              }
              return userSnapshot.hasData
                  ? Home(userSnapshot.data.uid)
                  : Welcome();
            } else {
              return Text(
                "Tabs",
                style: Theme.of(context).textTheme.display1,
              );
            }
          },
        ),
      ),
    );
  }
}