
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadserv_app/common/constant/app_animations.dart';
import 'package:lottie/lottie.dart';

class AppLoading extends StatelessWidget {
  final Color? color;
  final double? size;

  const AppLoading({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size ?? 50,
        height: size ?? 50,
        child: Lottie.asset(
          
          AppAnimations.loading,
          width: size ?? 50,
          height: size ?? 50,
        ),
      
      ),
    );
  }
}
