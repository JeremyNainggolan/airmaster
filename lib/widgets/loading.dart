import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: ColorConstants.primaryColor,
          size: 75,
        ),
      ),
    );
  }
}
