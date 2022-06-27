import 'package:e_gov/service/complain_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_gov/widgets/primary_button.dart';
import 'package:e_gov/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';
import '../../model/complain.dart';
import '../theme.dart';

class ComplainForm extends StatefulWidget {
  String department;

   ComplainForm({Key? key , required this.department}) : super(key: key);

  @override
  State<ComplainForm> createState() => _ComplainFormState();
}

class _ComplainFormState extends State<ComplainForm> {
  final ComplainService _complainService = ComplainService();

  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;
  bool isLording = false;

  final nameController = TextEditingController();
  final telephoneController = TextEditingController();
  final descriptionController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Report a Problem',
                    style: heading2.copyWith(color: textBlack),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/accent.png',
                    width: 99,
                    height: 4,
                  ),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter details';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Full Name',
                          hintStyle: heading6.copyWith(color: textGrey),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: telephoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter details';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Telephone Number',
                          hintStyle: heading6.copyWith(color: textGrey),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      height: 120,
                      child: TextFormField(
                        controller: descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter details';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Description',
                          hintStyle: heading6.copyWith(color: textGrey),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: textWhiteGrey,
                    //     borderRadius: BorderRadius.circular(14.0),
                    //   ),
                    //   child: TextFormField(
                    //     decoration: InputDecoration(
                    //       hintText: 'Date',
                    //       hintStyle: heading6.copyWith(color: textGrey),
                    //       border: const OutlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 25,
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: textWhiteGrey,
                    //     borderRadius: BorderRadius.circular(14.0),
                    //   ),
                    //   child: TextFormField(
                    //     decoration: InputDecoration(
                    //       hintText: 'Time',
                    //       hintStyle: heading6.copyWith(color: textGrey),
                    //       border: const OutlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomPrimaryButton(
                buttonColor: primaryBlue,
                textValue: 'Complain',
                textColor: Colors.white,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    createComplain();
                  }
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
  void snackBar({
    required textColor  ,
    required text ,
    required onPress ,
    actionTextColor : null ,
    required actionLabelText
  }) {

    final snackBar = SnackBar(
      content:  Text(
        text ,
        style: TextStyle(
            color: textColor
        ),
      ),
      action: SnackBarAction(
        textColor: actionTextColor,
        label: actionLabelText,
        onPressed: onPress,
      ),

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void createComplain() async{
    Complain complain = Complain(department: widget.department , fullName: nameController.text , telephoneNumber: telephoneController.text , description: descriptionController.text );
    String response = await _complainService.createComplain(complain);

    if (response == "ok"){
      nameController.clear();
      telephoneController.clear();
      descriptionController.clear();
      snackBar(
          text: "Success",
          textColor: Colors.green,
          actionLabelText: "Close",
          actionTextColor: Colors.white,
          onPress: (){}
      );
    }else {
      snackBar(
          text: response,
          textColor: Colors.red,
          actionLabelText: "Close",
          actionTextColor: Colors.white,
          onPress: (){}
      );
      setState(() {
        isLording = false;
      });
    }


  }
}
