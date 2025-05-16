import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_cure/config/route/route_name.dart';
import 'package:health_cure/config/theme/app_colors.dart';
import 'package:health_cure/core/database/local_storage.dart';
import 'package:health_cure/core/widgets/loading_widget.dart';
import 'package:health_cure/features/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:health_cure/service_locator.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
    required this.password,
  });
  final String verificationId;
  final String phoneNumber;
  final String password;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  int _secondsRemaining = 30;
  bool _isResendEnabled = false;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
            _startTimer();
          } else {
            _isResendEnabled = true;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    otpController.dispose();
    super.dispose();
  }

  final AuthenticationBloc _authenticationBloc = sl<AuthenticationBloc>();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 50,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: _authenticationBloc,
      listener: (context, state) {
        if(state.status == AuthenticationStatus.otpVerified){
          LoadingWidget.hide(context);
          LocalStorage.instance.setBool('user_logged_in', true);
          context.goNamed(RouteName.home);
        }
        if(state.status == AuthenticationStatus.otpVerificationLoading){
          LoadingWidget.show(context);
        }
        if(state.status == AuthenticationStatus.otpVerificationFailure){
          LoadingWidget.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
        }
        
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            
            elevation: 0,
            title: const Text('OTP Verification'),
          ),
          body: Stack(
            children: [
              // Background gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary.withAlpha(0x15),
                      AppColors.secondary.withAlpha(0x10),
                      Colors.white,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
              // Animated circles in background
              ...List.generate(3, (index) {
                return Positioned(
                  top: index * 100.0,
                  right: index * 50.0,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withAlpha(0x05),
                    ),
                  ),
                );
              }),
              // Main content
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: Transform.translate(
                            offset: Offset(0, _slideAnimation.value),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 40),
                                  Text(
                                    'Verify Your Number',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineMedium?.copyWith(
                                      color: AppColors.primary,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Enter the OTP sent to your phone',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.copyWith(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  Pinput(
                                    length: 6,
                                    controller: otpController,
                                    defaultPinTheme: defaultPinTheme,
                                    focusedPinTheme: defaultPinTheme.copyWith(
                                      decoration: defaultPinTheme.decoration!
                                          .copyWith(
                                            border: Border.all(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                    ),
                                    onCompleted: (pin) {
                                      _authenticationBloc.add(VerifyOtpEvent(verificationId: widget.verificationId, otp: pin, password: widget.password));
                                    },
                                  ),
                                  // const SizedBox(height: 24),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Text(
                                  //       'Didn\'t receive the code? ',
                                  //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  //         color: Colors.grey.shade600,
                                  //       ),
                                  //     ),
                                  //     if (_isResendEnabled)
                                  //       TextButton(
                                  //         onPressed: () {
                                  //           // Handle resend OTP
                                  //           setState(() {
                                  //             _secondsRemaining = 30;
                                  //             _isResendEnabled = false;
                                  //           });
                                  //           _startTimer();
                                  //         },
                                  //         child: Text(
                                  //           'Resend',
                                  //           style: TextStyle(
                                  //             color: AppColors.primary,
                                  //             fontWeight: FontWeight.w600,
                                  //           ),
                                  //         ),
                                  //       )
                                  //     else
                                  //       Text(
                                  //         'Resend in $_secondsRemaining s',
                                  //         style: TextStyle(
                                  //           color: Colors.grey.shade600,
                                  //           fontWeight: FontWeight.w500,
                                  //         ),
                                  //       ),
                                  //   ],
                                  // ),
                                  const SizedBox(height: 40),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        context.goNamed(RouteName.home);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: Colors.white,
                                      minimumSize: const Size(
                                        double.infinity,
                                        56,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      'Verify',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
