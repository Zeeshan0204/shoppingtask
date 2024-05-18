import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertask/core/config/size_config.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});



  @override
  Widget build(BuildContext context) {

    return  SizedBox(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: const Icon(Icons.add),

    );
  }
}


