import 'package:aulataller/presentation/UI/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'injection_container.dart' as getInstances;
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await getInstances.setup();
  runApp(AulaTallerApp());
}

class AulaTallerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown]);
    return MaterialApp(
      theme:ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.orange,
        textTheme:GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme)
        .copyWith(bodyText2: GoogleFonts.mukta())
      ),
      title:'Aula Taller',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}