import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tournament_client/admin_verify.dart';
import 'package:tournament_client/containerpage.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_client/navigation/navigation_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp(
    
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, }) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }
  Future<void> _checkLoginStatus() async {
    isLoggedIn = await UserLoginManager.isLoggedIn();
    setState(() {}); // Update the UI based on the login status
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TNM APP SLOT V1',
        theme: ThemeData(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          cardColor: Colors.white,
          platform: TargetPlatform.windows,
          hoverColor: Colors.grey,
          primaryColor: Colors.orange,
          dividerColor: Colors.grey,
          indicatorColor: Colors.orange,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: false,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: GoogleFonts.poppins().fontFamily,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routes: {
          '/containerPage': (context) => ContainerPage(
                url: MyString.BASEURL,
                selectedIndex: MyString.DEFAULTNUMBER,
          ),
        },
        home: isLoggedIn == false ? const AdminVerify() : const NavigationPage()
        );
  }
}







//user login 
class UserLoginManager {
  static const String _loggedInKey = 'isLoggedIn';
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, value);
  }
}