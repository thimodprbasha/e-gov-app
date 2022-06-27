import 'package:e_gov/screens/supervisor/approved_complains.dart';
import 'package:e_gov/screens/supervisor/supervisor_complains.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/nav_drawer.dart';
import 'package:e_gov/env/env.dart';

class SupervisorDashboard extends StatefulWidget {
  const SupervisorDashboard({Key? key}) : super(key: key);

  @override
  State<SupervisorDashboard> createState() => _SupervisorDashboardState();
}

class _SupervisorDashboardState extends State<SupervisorDashboard> {
  static  List<Tab> tabsList = [
    const Tab(text : "Complaints" , icon: FaIcon(FontAwesomeIcons.file) ),
    const Tab(text : "Approved",icon: FaIcon(FontAwesomeIcons.fileCircleCheck)),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          endDrawer :  const NavDrawer(role: SUPERVISOR , email: "",),
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize:  const Size(0, 60.0),
              child: TabBar(
                  indicatorColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 9.5,fontFamily: 'Family Name'),  //For Selected tab
                  unselectedLabelStyle: TextStyle(fontSize: 8.0,fontFamily: 'Family Name'), //For Un-selected Tabs/For Un-selected Tabs
                  tabs: tabsList
              ),
            ),

          ),
          body: const TabBarView(
            children: [
              SupervisorComplains(),
              ApprovedComplains(),
            ],
          ),
        ),
      ),
    );
  }
}
