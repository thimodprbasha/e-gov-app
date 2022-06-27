import 'package:e_gov/screens/citizen/complain_form.dart';
import 'package:e_gov/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_gov/env/env.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CitizenDashboard extends StatelessWidget {
  static const List<Tab> tabsList = [
     Tab(text : "Electricity Board" , icon: FaIcon(FontAwesomeIcons.bolt) ),
     Tab(text : "Water Board",icon: FaIcon(FontAwesomeIcons.droplet)),
     Tab(text : "Municipal Council",icon: FaIcon(FontAwesomeIcons.landmark)),
     Tab(text : "MOH",icon: FaIcon(FontAwesomeIcons.circleH)),
  ];

  const CitizenDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSharedPrefs(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        String? email = snapshot.data;
        return MaterialApp(
          home: DefaultTabController(
            length: 4,
            child: Scaffold(
              endDrawer:  NavDrawer(role: CITIZEN, email: email),
              appBar: AppBar(
                bottom: const PreferredSize(
                  preferredSize: Size(0, 60.0),
                  child: TabBar(
                      indicatorColor: Colors.white,
                      labelStyle: TextStyle(
                          fontSize: 9.5, fontFamily: 'Family Name'),
                      //For Selected tab
                      unselectedLabelStyle: TextStyle(
                          fontSize: 8.0, fontFamily: 'Family Name'),
                      //For Un-selected Tabs
                      tabs: tabsList
                  ),
                ),

              ),
              body: TabBarView(
                children: [
                  ComplainForm(department: "Electricity Board"),
                  ComplainForm(department: "Water Boar"),
                  ComplainForm(department: "Municipal Council"),
                  ComplainForm(department: "MOH"),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Future<String> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("USER_EMAIL")!;
    return email;
  }
}
