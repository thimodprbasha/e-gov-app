import 'package:e_gov/screens/deptwoker/complains.dart';
import 'package:e_gov/screens/deptwoker/feedback.dart';
import 'package:e_gov/screens/deptwoker/report.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_gov/env/env.dart';
import '../../widgets/nav_drawer.dart';

class GovWorkerDashBoard extends StatefulWidget {
  const GovWorkerDashBoard({Key? key}) : super(key: key);

  @override
  State<GovWorkerDashBoard> createState() => GovWorkerDashBoardState();
}

class GovWorkerDashBoardState extends State<GovWorkerDashBoard> {
  static  List<Tab> tabsList = [
    const Tab(text : "Complaints" , icon: FaIcon(FontAwesomeIcons.file) ),
    const Tab(text : "FeedBack",icon: FaIcon(FontAwesomeIcons.commentDots)),
    const Tab(text : "Generate Report",icon: FaIcon(FontAwesomeIcons.chartColumn)),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          endDrawer : const NavDrawer(role: GOV_WORKER , email: "",),
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize:  const Size(0, 60.0),
              child: TabBar(
                  indicatorColor: Colors.white,
                  labelStyle: const TextStyle(fontSize: 9.5,fontFamily: 'Family Name'),  //For Selected tab
                  unselectedLabelStyle: const TextStyle(fontSize: 8.0,fontFamily: 'Family Name'), //For Un-selected Tabs/For Un-selected Tabs
                  tabs: tabsList
              ),
            ),

          ),
          body:  const TabBarView(
            children: [
               Complains(),
               FeedbackComplains(),
               Report()
            ],
          ),
        ),
      ),
    );
  }
}
