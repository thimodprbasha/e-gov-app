import 'dart:convert';
import 'package:http/http.dart';
import '../env/env.dart';
import '../model/complain.dart';

class ComplainService {
  Future<String> createComplain(Complain complain) async{
    Uri url = Uri.parse(URL_CREATE_COMPLAIN);

    Map<String,dynamic> body = complain.toJson();

    var complainBody = json.encode(body);

    Response response = await post(url , body: complainBody , headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      return "ok";
    } else {
      return response.body;
    }
  }

  Future<List<Complain>> getComplains() async{
    Uri url = Uri.parse(URL_GET_COMPLAIN);

    Response response = await get (url , headers: {"Content-Type": "application/json"});

    final complains = json.decode(response.body)as List<dynamic>;

    List<Complain> complainList = complains.map((e) => Complain.fromJson(e)).toList();
    return complainList;


  }

  Future<int> shareComplain ( String complainID) async {
    Uri url = Uri.parse(URL_SHARE_COMPLAIN);

    String id = "car0ilasahskh1dqm4m0";

    Map<String,String> body = {
      "supervisor_id" : id,
      "complain_id" : complainID,
    };
    var jsonBody = json.encode(body);

    Response response = await post(url , body: jsonBody , headers: {"Content-Type": "application/json"});

    return response.statusCode;

  }

  Future<int> giveFeedbackApprovedComplain ( String complainID , feedback) async {
    Uri url = Uri.parse(URL_FEEDBACK_APPROVE_COMPLAIN);

    Map<String,String> body = {
      "gov_worker_id" : "car0ilisahskh1dqm4mg",
      "complain_id" : complainID,
      "description" : feedback,
    };

    var jsonBody = json.encode(body);

    Response response = await post(url , body: jsonBody , headers: {"Content-Type": "application/json"});

    return response.statusCode;

  }

  Future<int> approvedComplain ( String complainID , worker , workersName , details ) async {
    print("Sssss");
    Uri url = Uri.parse("http://localhost:8080/api/user/supervisor/feedback/" + complainID);
    print(url);

    String id = "car0ilasahskh1dqm4m0";

    Map<String,dynamic> body = {
      "supervisor_id" : id ,
      "feedback_approved" : true,
      "complain_details" : {
        "number_of_workers" : int.parse(worker) ,
        "name_of_workers" : workersName ,
        "complain_details" : details ,
      },
    };

    var jsonBody = json.encode(body);

    Response response = await post(url , body: jsonBody , headers: {"Content-Type": "application/json"});
    print(response.body);

    return response.statusCode;

  }

}