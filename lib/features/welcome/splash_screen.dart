import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_cure/config/route/route_name.dart';
import 'package:health_cure/core/database/local_storage.dart';
import 'package:health_cure/core/widgets/app_logo.dart';
import 'package:health_cure/config/route/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _controller.forward().then((_) {
      // Start checking user status after animation completes
      checkFirstTimeUser();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> checkFirstTimeUser() async {
    try {
      // Add a delay to show the splash animation
      await Future.delayed(const Duration(seconds: 2));
      
      if (!mounted) return;

      // Check if user is first time using LocalDatabase
      final isFirstTime = await   LocalStorage.instance.isFirstTimeUser();
      
      if (!mounted) return;

      if (isFirstTime) {
        // First time user - go to onboarding and set the flag
        debugPrint('First time user');
        await LocalStorage.instance.setFirstTimeUser(false);
        if (!mounted) return;
        context.goNamed(RouteName.onboarding);
      } else {
        // Returning user - go to home
        final isLoggedIn = await LocalStorage.instance.getBool('user_logged_in');
        if(isLoggedIn){
          debugPrint('Returning user');
          context.goNamed(RouteName.home);
        }else{
          debugPrint('Returning user');
          context.goNamed(RouteName.login);
        }
       
      }
    } catch (e) {
      debugPrint('Error checking first time user status: $e');
      // In case of error, default to onboarding
      if (mounted) {
        context.goNamed(RouteName.onboarding);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Theme.of(context).primaryColor.withAlpha(38),
                  Theme.of(context).colorScheme.secondary.withAlpha(26),
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
                  color: Theme.of(context).primaryColor.withAlpha(13),
                ),
              ),
            );
          }),
          // Main content
          SafeArea(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const AppLogo(
                              size: 40,
                              alignment: LogoAlignment.vertical,
                            ),
                        
                            const SizedBox(height: 24),
                            Transform.translate(
                              offset: Offset(0, _slideAnimation.value),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Your Health, Your Priority',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
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
        ],
      ),
    );
  }
}


