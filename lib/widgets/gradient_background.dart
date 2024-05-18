import 'package:flutter/material.dart';

import '../core/config/themes/app_colors.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(




           /* image: DecorationImage(
              fit: BoxFit.fill,
      alignment: Alignment.center,
      matchTextDirection: true,
      repeat: ImageRepeat.noRepeat,
      image: AssetImage(Images.login_back_png),
    ),*/

            color: AppColors.purplebottomnav,
            // gradient: LinearGradient(
            //   colors: [
            //     Color(0xff3A004F),
            //     Color(0xff8845A0),
            //     Color(0xff3A004F),
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomLeft,
          ),
          // ),
        ),
        SafeArea(
          child: child,
        ),
      ],
    );
  }
}
