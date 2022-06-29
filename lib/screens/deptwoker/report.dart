import 'dart:convert';

import 'package:charts_flutter/flutter.dart';
import 'package:e_gov/service/complain_service.dart';
import 'package:e_gov/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../theme.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final ComplainService _complainService = ComplainService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: buidBarchart(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Series<ComplainDetails, String>>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complain Summary',
                            style: heading2.copyWith(color: textBlack),
                          ),
                          const SizedBox(height: 20),
                          Image.asset(
                            'assets/images/accent.png',
                            width: 99,
                            height: 4,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 500,
                            child: BarChart(
                              snapshot.data
                                  as List<Series<ComplainDetails, String>>,
                              animate: true,
                            ),
                          ),
                        ]),
                  ),
                ),
              );
            } else {
              return Scaffold(
                body: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
                  child: Center(
                    child: Text(
                      'No Data',
                      style: heading2.copyWith(color: textBlack),
                    ),
                  ),
                )),
              );
            }
          } else {
            return const Spinner(
              backgroundColor: Colors.white,
              spinkitColor: Colors.black,
              spinnerSize: 20.0,
              spinnerUI: false,
            );
          }
        });
  }

  Future<List<Series<ComplainDetails, String>>> buidBarchart() async {
    final List<ComplainDetails> data = [];

    Response response = await _complainService.generateReport();
    if (response.statusCode == 200) {
      final Map complainStats = json.decode(response.body);
      data.add(ComplainDetails(
          "Total complains",
          complainStats["num_of_complains"],
          ColorUtil.fromDartColor(Colors.blue)));
      data.add(ComplainDetails(
          "Resolved",
          complainStats["num_of_resolved_complains"],
          ColorUtil.fromDartColor(Colors.green)));
      data.add(ComplainDetails(
          "Unresolved",
          complainStats["num_of_unresolved_complains"],
          ColorUtil.fromDartColor(Colors.red)));

      return [
        Series<ComplainDetails, String>(
          id: 'Complains',
          colorFn: (ComplainDetails series, _) => series.color,
          domainFn: (ComplainDetails series, _) => series.statName,
          measureFn: (ComplainDetails series, _) => series.count,
          data: data,
        )
      ];
    } else {
      return [];
    }
  }
}

class ComplainDetails {
  final String statName;
  final int count;
  final Color color;

  ComplainDetails(this.statName, this.count, this.color);
}
