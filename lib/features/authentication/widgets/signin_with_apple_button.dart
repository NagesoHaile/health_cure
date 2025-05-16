import 'package:flutter/material.dart';

class SignInWithAppleButton extends StatelessWidget {
  SignInWithAppleButton({
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
          backgroundColor: Colors.white,
          surfaceTintColor: const Color(0xFFFFB101),
        ),
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator(strokeWidth: 3))
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/apple_logo.png", width: 20),
                    const SizedBox(width: 10),
                    const Text(
                      'Sign in  with Apple',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
