import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadserv_app/common/constant/app_animations.dart';
import 'package:loadserv_app/common/constant/textStyles.dart';
import 'package:loadserv_app/common/widget/animations/slide.dart';
import 'package:lottie/lottie.dart';
// import 'package:lottie/lottie.dart';

class AppErrorWidget extends StatelessWidget {
  final String errorMessage;
  final Function()? onRefresh;

  const AppErrorWidget({super.key, required this.errorMessage, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideWrapper(
            slideDirection: SlideDirection.down,
            duration: Duration(milliseconds: 1000 ),
            initialOffset: 38,
            child:
                Lottie.asset(AppAnimations.error, width: 150, height: 150)
            
          ),
          Text(
            errorMessage,
            style: TextStyles.bold16(),
          ),
          if (onRefresh != null) ...{
            SlideWrapper(
              
              slideDirection: SlideDirection.up,
              duration: Duration(milliseconds: 1000 ),
              initialOffset: 38,
              child: AppButton(
                text: "refresh",
                height: 40,
                onClick: onRefresh!,
                isWrapContent: true,
              ),
            )
          },
        ],
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final double? height;
  final double? width;
  final bool isWrapContent;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double borderRadius;

  const AppButton({
    Key? key,
    required this.text,
    required this.onClick,
    this.height,
    this.width,
    this.isWrapContent = false,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: height ?? 48.h,
        width: isWrapContent ? null : (width ?? double.infinity),
        padding: isWrapContent ? EdgeInsets.symmetric(horizontal: 16) : null,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
