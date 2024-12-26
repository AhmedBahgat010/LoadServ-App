import 'package:flutter/material.dart';

extension WidgetExtention on Widget {
  Widget margin(EdgeInsetsGeometry margin) {
    return Padding(
      padding: margin,
      child: this,
    );
  }

  Widget marginBottom(double value) {
    return Padding(
      padding: EdgeInsets.only(bottom: value),
      child: this,
    );
  }

  Widget marginTop(double value) {
    return Padding(
      padding: EdgeInsets.only(top: value),
      child: this,
    );
  }

  Widget marginLeft(double value) {
    return Padding(
      padding: EdgeInsets.only(left: value),
      child: this,
    );
  }

  Widget marginRight(double value) {
    return Padding(
      padding: EdgeInsets.only(right: value),
      child: this,
    );
  }

  Widget marginStart(double value) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: value),
      child: this,
    );
  }

  Widget marginEnd(double value) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: value),
      child: this,
    );
  }

  Widget marginHorizontal(double value) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: value),
      child: this,
    );
  }

  Widget marginVertical(double value) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: value),
      child: this,
    );
  }

  Widget marginAll(double value) {
    return Padding(
      padding: EdgeInsetsDirectional.all(value),
      child: this,
    );
  }

  Widget clip(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

  Widget clipBottom(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      ),
      child: this,
    );
  }

  Widget clipTop(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
      child: this,
    );
  }

  Widget background(Color color) {
    return Container(
      color: color,
      child: this,
    );
  }


}
