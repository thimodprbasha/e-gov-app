import 'package:e_gov/screens/authenticate/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/citizen/citizen_dashboard.dart';
import 'package:e_gov/env/env.dart';

class NavDrawer extends StatelessWidget {
  final String name = "Tim Jake";
  final  String? email;
  final String role;



  const NavDrawer({Key? key, required this.role , required this.email}) : super(key: key);
  static List<ListTile> citizenDrawerItems = [


  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
           SizedBox(
            height: 220.0,
            child: UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1485290334039-a3c69043e517?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTYyOTU3NDE0MQ&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=300'),
              ),
              accountEmail: Text(email!),
              accountName: const Text(
                'Citizen',
                style: TextStyle(fontSize: 24.0),
              ),
              decoration: const BoxDecoration(
                color: Colors.black87,
              ),
            ),
          ),
          for (var list in navigation(context, role)) list
        ],
      ),
    );
  }

  List<ListTile> navigation(BuildContext context , String role ){
    List<ListTile> citizenDrawerItems = [
      ListTile(
        leading: const FaIcon(FontAwesomeIcons.user),
        title: Text('Profile'),
        onTap: () => {},
      ),
      ListTile(
        leading: const FaIcon(FontAwesomeIcons.gear),
        title: Text('Settings'),
        onTap: () => {},
      ),
      ListTile(
        leading: const FaIcon(FontAwesomeIcons.commentDots),
        title: Text('Feedback'),
        onTap: () => {},
      ),
      ListTile(
        leading: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
        title: Text('Logout'),
        onTap: () => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          )
        },
      ),
    ];

    List<ListTile> adminDrawerItems = [
      ListTile(
        leading: const FaIcon(FontAwesomeIcons.user),
        title: Text('Profile'),
        onTap: () => {},
      ),
      ListTile(
        leading: const FaIcon(FontAwesomeIcons.gear),
        title: Text('Settings'),
        onTap: () => {},
      ),
      ListTile(
        leading: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
        title: Text('Logout'),
        onTap: () => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          )
        },
      ),
    ];
    if (role == CITIZEN){
        return citizenDrawerItems;
    }else{
      return adminDrawerItems;
    }
  }
}
