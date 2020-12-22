import 'package:flutter/material.dart';
import 'package:my_personal_portfolio/profile_page.dart';

void main() {
  runApp(PersonalPorfolioPage());
}

class PersonalPorfolioPage extends StatelessWidget
{
  const PersonalPorfolioPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColorDark: Colors.black,
        fontFamily: 'GoogleSansRegular',
      ),
      home: ProfilePage(),
    );
  }
}
