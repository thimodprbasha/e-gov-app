import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComplainFeedback extends StatefulWidget {
  const ComplainFeedback({Key? key}) : super(key: key);

  @override
  State<ComplainFeedback> createState() => _ComplainFeedbackState();
}

class _ComplainFeedbackState extends State<ComplainFeedback> {
  @override
  Widget build(BuildContext context) {
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
            'Date',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Time',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        // DataColumn(
        //   label: Text(
        //     'Priority',
        //     style: TextStyle(fontStyle: FontStyle.italic),
        //   ),
        // ),
      ],
      rows:  <DataRow>[
        DataRow(
          onSelectChanged: (val) => shareModal(),
          cells: const <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('2022-06-7')),
            DataCell(Text('22:10')),
            // DataCell(
            //   Badge(
            //     toAnimate: false,
            //     shape: BadgeShape.square,
            //     badgeColor: Colors.red,
            //     borderRadius: BorderRadius.circular(8),
            //     badgeContent: const Text('', style: TextStyle(color: Colors.white)),
            //   ),
            // ),

          ],
        ),






      ],
    );
  }
  Future<String?> shareModal(){
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Complain Feedback'),
        content:  const TextField(
          obscureText: false,
          decoration: InputDecoration(
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
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('Approve'),
          ),
        ],
      ),
    );
  }
}
