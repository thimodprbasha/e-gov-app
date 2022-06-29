import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/complain.dart';
import '../../service/complain_service.dart';
import '../../widgets/spinner.dart';

class ApprovedComplains extends StatefulWidget {
  const ApprovedComplains({Key? key}) : super(key: key);

  @override
  State<ApprovedComplains> createState() => _ApprovedComplainsState();
}

class _ApprovedComplainsState extends State<ApprovedComplains> {
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
            ],
            rows: complains.map((e) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(e.fullName)),
                  DataCell(Text(e.department)),
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

  Future<List<Complain>> getComplains() async {
    List<Complain> unapproved =[];
    var list = await _complainService.getComplains();
    for (var e in list) {
      print(e.department);
      if(e.complainFeedback?.feedbackApproved == true){
        unapproved.add(e);
      }
    }
    print(unapproved.length);
    return unapproved;
  }
}
