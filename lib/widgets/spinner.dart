import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner extends StatelessWidget {
  final Color backgroundColor;
  final Color spinkitColor;
  final double spinnerSize;
  final bool spinnerUI;

  const Spinner(
      {Key? key,
      this.backgroundColor = Colors.blue,
      this.spinkitColor = Colors.white,
      this.spinnerSize = 50.0,
      this.spinnerUI = true
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(spinnerUI){
      return Scaffold(
        backgroundColor: backgroundColor,
        body:  Center(
          child: SpinKitCircle(
            color: spinkitColor,
            size: spinnerSize,
          ),
        ),
     );
    }else{
      return Scaffold(
        backgroundColor: backgroundColor,
        body:  Center(
          child: SpinKitThreeBounce(
            color: spinkitColor ,
            size: spinnerSize
          ),
        ),
     );
    }
    
  }
}
