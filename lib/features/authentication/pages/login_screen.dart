import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_cure/config/route/route_name.dart';
import 'package:health_cure/config/theme/app_colors.dart';
import 'package:health_cure/core/widgets/loading_widget.dart';
import 'package:health_cure/features/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:health_cure/features/authentication/widgets/sign_in_with_google_button.dart';
import 'package:health_cure/service_locator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:logger/logger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  String? _phoneNumber;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    phoneController.dispose();
    super.dispose();
  }

  final AuthenticationBloc _authenticationBloc = sl<AuthenticationBloc>();
  bool obscureText = true;

  void _handleLogin() {
    if (formKey.currentState!.validate()) {
      if (_phoneNumber == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid phone number'),
          ),
        );
        return;
      }
      
      _authenticationBloc.add(
        LoginWithPhoneNumberEvent(
          phoneNumber: _phoneNumber!,
        ),
      );  
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: _authenticationBloc,
      listener: (context, state) {
        Logger().d(state);
        if (state.status == AuthenticationStatus.sendingOtpLoading ||
            state.status == AuthenticationStatus.loginWithPhoneNumberLoading) {
          LoadingWidget.show(context);
        }
        if (state.status == AuthenticationStatus.sendingOtpSuccess) {


          LoadingWidget.hide(context);
            phoneController.clear();
          context.pushNamed(RouteName.otp, extra: {
            'verificationId': state.verificationId,
            'phoneNumber': _phoneNumber,
          });
          
        }
        if (state.status == AuthenticationStatus.loginWithPhoneNumberSuccess) {
          LoadingWidget.hide(context);
          context.goNamed(RouteName.home);
        }
        if (state.status == AuthenticationStatus.sendingOtpFailure) {
          LoadingWidget.hide(context);
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.error),
                ),
          );
        }
        if(state.status == AuthenticationStatus.signInWithGoogleLoading){
          LoadingWidget.show(context);
        }
        if(state.status == AuthenticationStatus.signInWithGoogleSuccess){
          LoadingWidget.hide(context);
          context.goNamed(RouteName.home);
        }
        if(state.status == AuthenticationStatus.signInWithGoogleFailure){
          LoadingWidget.hide(context);
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error'),
            ),
          );
        }
      
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
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
                                    'Welcome Back!',
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
                                    'Login to your account',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.copyWith(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 40),

                                  const SizedBox(height: 8),
                                  IntlPhoneField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (phone) {
                                      setState(() {
                                        _phoneNumber = phone.completeNumber;
                                      });
                                      Logger().d('Phone number: $_phoneNumber');
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                    initialCountryCode: 'ET',
                                    validator: (value) {
                                      if (value == null || value.number.isEmpty) {
                                        return 'Please enter your phone number';
                                      }
                                      return null;
                                    },
                                  ),



                                  const SizedBox(height: 40),
                                  ElevatedButton(
                                    onPressed: _handleLogin,
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
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 48),
                                  Row(
                                    spacing: 10,
                                    children: [
                                      Expanded(child: Divider(
                                        color: AppColors.secondary,
                                      )),
                                      Text('OR',style: Theme.of(context).textTheme.bodyMedium,),
                                      Expanded(child: Divider(
                                        color: AppColors.secondary,
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 48),
                                  SignInWithGoogleButton(
                                    onPressed: (){
                                      _authenticationBloc.add(SignInWithGoogleEvent());
                                    },
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
