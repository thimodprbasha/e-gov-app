import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/complain.dart';
import '../../service/complain_service.dart';

class SupervisorComplains extends StatefulWidget {
  const SupervisorComplains({Key? key}) : super(key: key);

  @override
  State<SupervisorComplains> createState() => _SupervisorComplainsState();
}

class _SupervisorComplainsState extends State<SupervisorComplains> {
  final ComplainService _complainService = ComplainService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder( future: getComplains(), builder: (BuildContext context, AsyncSnapshot<List<Complain>> snapshot) {
      if (snapshot.hasData) {
        var complains = snapshot.data as List<Complain>;
        return DataTable(
            columnSpacing: 45.0,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Department',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Priority',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: complains.map((e) => DataRow(
                onSelectChanged: (val) => shareModal(e.complainId!),
                cells: <DataCell>[
                  DataCell(Text(e.fullName)),
                  DataCell(Text(e.department)),
                  DataCell(
                    Badge(
                      toAnimate: false,
                      shape: BadgeShape.square,
                      badgeColor: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                      badgeContent: const Text('Low', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ]

            )).toList()
        );
      } else {
        return  Container();
      }
    }
    );
  }
  Future<String?> shareModal(String complainID){
    final workers = TextEditingController();
    final workersName = TextEditingController();
    final time = TextEditingController();


    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Complain Feedback'),
        content:  Column(
          children:  [
            TextField(
              controller: workers,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Workers',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: workersName,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Workers Name',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: time,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Details',
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              _complainService.approvedComplain(complainID , workers.text , workersName.text , time.text),
              setState(() {}),
              Navigator.pop(context, 'OK')
          },
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }
  Future<List<Complain>> getComplains() async {
    List<Complain> unapproved =[];
    var list = await _complainService.getComplains();
    for (var e in list) {
      print(e.department);
      if(e.complainFeedback?.pending == true){
        unapproved.add(e);
      }
    }
    print(unapproved.length);
    return unapproved;
  }
}
