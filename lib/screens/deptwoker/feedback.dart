import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/complain.dart';
import '../../service/complain_service.dart';
import '../../widgets/spinner.dart';

class FeedbackComplains extends StatefulWidget {
  const FeedbackComplains({Key? key}) : super(key: key);

  @override
  State<FeedbackComplains> createState() => _FeedbackComplainsState();
}

class _FeedbackComplainsState extends State<FeedbackComplains> {


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
                  DataCell(statusApproved(e.complainApproved!.approved)),
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

  Badge statusApproved(bool feedbackSent){
    if (feedbackSent){
      return Badge(
        toAnimate: false,
        shape: BadgeShape.square,
        badgeColor: Colors.green,
        borderRadius: BorderRadius.circular(8),
        badgeContent: const Text('Feedback', style: TextStyle(color: Colors.white)),
      );
    }else {
       return Badge(
        toAnimate: false,
        shape: BadgeShape.square,
        badgeColor: Colors.red,
        borderRadius: BorderRadius.circular(8),
        badgeContent: const Text('Feedback', style: TextStyle(color: Colors.white)),
      );
    }
  }

  Future<List<Complain>> getComplains() async {
    List<Complain> approved =[];
    var list = await _complainService.getComplains();
    for (var e in list) {
      print(e.department);
      if(e.complainFeedback?.feedbackApproved == true){
        approved.add(e);
      }
    }
    return approved;
  }

  Future<String?> shareModal(String complainID) {
    final feedback = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Complain Feedback'),
            content:  TextField(
              controller: feedback,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Feedback',
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => {
                  _complainService.giveFeedbackApprovedComplain(complainID , feedback.text),
                  setState(() {}),
                  Navigator.pop(context, 'OK'),
                },
                child: const Text('Approve'),
              ),
            ],
          ),
    );
  }
}
