import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:health_cure/config/theme/app_colors.dart';

class LoadingWidget {
  static void show(
    BuildContext context, {
    Color color = AppColors.primary,
    double size = 30.0,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Center(
            child:  SpinKitWave(color: color, size: size),
          ),
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static circularProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
        strokeWidth: 3,
      ),
    );
  }

  static wave({
    Color color = AppColors.primary,
    double size = 50.0,
  }) {
    return SpinKitWave(
      color: color,
      size: size,
    );
  }
}
