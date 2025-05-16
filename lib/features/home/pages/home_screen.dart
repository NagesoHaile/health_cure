import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_cure/core/widgets/app_logo.dart';
import 'package:health_cure/config/theme/app_colors.dart';
import 'package:health_cure/features/authentication/services/authentication_service.dart';
import 'package:logger/logger.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  User? user;
  void getUserData() async {
    final user = await AuthenticationService().getCurrentUser();
    setState(() {
      this.user = user;
    });
    Logger().i(user);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppLogo(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
            child: Column(                                                                                                                                                                                                                                                                                                                                                                                                                                                        
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                  'Welcome back, ${user?.displayName?.split(' ')[0] ?? "to HealthCure"}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white, // This color will be replaced by the gradient
                    ),
                  ),
                ),
                Text('Your health is our priority',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),),
                // Image.asset('assets/images/home_image.png',height: 200,width: 200,),
                const SizedBox(height: 16,),
             
                // const SizedBox(height: 16,),
                // Text('Treatment Categories',style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 400, // Fixed height for the grid
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: 4, // Specify the number of items
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // context.pushNamed(RouteName.treatmentDetails);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            // color: Colors.grey.shade200,
                            color: Theme.of(context).colorScheme.primary.withAlpha(10),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'KV Millet',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Disease specific treatments',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey.shade600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
                    ),
          ),
      ),
    );
  }
}
