// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';


class Complain {
  final String ? complainId;
  String fullName;
  String telephoneNumber;
  String department;
  String description;
  ComplainFeedback ? complainFeedback;
  ComplainApproved ? complainApproved;

  Complain({
    this.complainId,
    required this.fullName,
    required this.telephoneNumber,
    required this.department,
    required this.description,
     this.complainFeedback,
     this.complainApproved,
  });

  factory Complain.fromJson(Map<String, dynamic> json) => Complain(
    complainId: json["complain_id"],
    fullName: json["full_name"],
    telephoneNumber: json["telephone_number"],
    department: json["department"],
    description: json["description"],
    complainFeedback: ComplainFeedback.fromJson(json["complain_feedback"]),
    complainApproved: ComplainApproved.fromJson(json["complain_approved"]),
  );

  Map<String, dynamic> toJson() => {
    "complain_id": complainId,
    "department": department,
    "full_name": fullName,
    "telephone_number": telephoneNumber,
    "description": description,
    "complain_feedback": complainFeedback?.toJson(),
    "complain_approved": complainApproved?.toJson(),
  };
}

class ComplainApproved {
  String govWorkerId;
  bool approved;
  String citizenFeedback;
  String govWorkerFeedback;

  ComplainApproved({
    required this.govWorkerId,
    required this.approved,
    required this.citizenFeedback,
    required this.govWorkerFeedback,
  });

  factory ComplainApproved.fromJson(Map<String, dynamic> json) => ComplainApproved(
    govWorkerId: json["gov_worker_id"],
    approved: json["Approved"],
    citizenFeedback: json["citizen_feedback"],
    govWorkerFeedback: json["gov_worker_feedback"],
  );

  Map<String, dynamic> toJson() => {
    "gov_worker_id": govWorkerId,
    "Approved": approved,
    "citizen_feedback": citizenFeedback,
    "gov_worker_feedback": govWorkerFeedback,
  };
}

class ComplainFeedback {
  String supervisorId;
  bool feedbackApproved;
  bool pending;
  ComplainDetails complainDetails;

  ComplainFeedback({
    required this.supervisorId,
    required this.pending,
    required this.feedbackApproved,
    required this.complainDetails,
  });

  factory ComplainFeedback.fromJson(Map<String, dynamic> json) => ComplainFeedback(
    supervisorId: json["supervisor_id"],
    feedbackApproved: json["feedback_approved"],
    pending: json["pending"],
    complainDetails: ComplainDetails.fromJson(json["complain_details"]),
  );

  Map<String, dynamic> toJson() => {
    "supervisor_id": supervisorId,
    "feedback_approved": feedbackApproved,
    "pending" : pending ,
    "complain_details": complainDetails.toJson(),
  };
}

class ComplainDetails {
  int numberOfWorkers;
  String nameOfWorkers;
  String time;

  ComplainDetails({
    required this.numberOfWorkers,
    required this.nameOfWorkers,
    required this.time,
  });

  factory ComplainDetails.fromJson(Map<String, dynamic> json) => ComplainDetails(
    numberOfWorkers: json["number_of_workers"],
    nameOfWorkers: json["name_of_workers"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "number_of_workers": numberOfWorkers,
    "name_of_workers": nameOfWorkers,
    "time": time,
  };
}
