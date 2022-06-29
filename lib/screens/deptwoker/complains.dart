import 'package:e_gov/model/complain.dart';
import 'package:e_gov/service/complain_service.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:e_gov/screens/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/spinner.dart';

class Complains extends StatefulWidget {
  const Complains({Key? key}) : super(key: key);

  @override
  State<Complains> createState() => _ComplainsState();
}

class _ComplainsState extends State<Complains> {
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
          return const Spinner(
              backgroundColor: Colors.white,
              spinkitColor: Colors.black,
              spinnerSize: 20.0,
              spinnerUI: false,
            );
         }
      }
    );
  }

  Widget shareDropDown(){
    String dropdownValue = 'Jimmy';
    return DropdownButtonFormField<String>(
      value: dropdownValue,
      iconSize: 22,
      elevation: 16,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Jimmy', 'Smith', 'Wanner', 'Marcus']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Future<String?> shareModal( String complainID){
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Share Supervisor'),
        content: SizedBox(
            width: 20,
            child: shareDropDown()
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              _complainService.shareComplain(complainID),
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
      if(e.complainFeedback?.pending == false && e.complainFeedback?.feedbackApproved == false ){
        unapproved.add(e);
      }
    }
    print(unapproved.length);
    return unapproved;
  }
}
