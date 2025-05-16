import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_cure/config/theme/app_colors.dart';

class SignInWithGoogleButton extends StatelessWidget {
  SignInWithGoogleButton({
    super.key,
    this.isLoading = false,
    required this.onPressed,
  });
  bool isLoading = false;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          // surfaceTintColor: const Color(0xFFFFB101),
        ),
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator(strokeWidth: 3))
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/googlelogo.svg",
                      width: 24,
                      semanticsLabel: 'linkedin  Logo',
                    ),
                    const SizedBox(width: 10),
                     Text(
                      'Continue with google',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
      ),
    );
  }
}
