import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_cure/config/route/route_name.dart';
import 'package:health_cure/core/widgets/app_logo.dart';
import 'package:health_cure/config/theme/app_colors.dart';
import 'package:health_cure/features/authentication/services/authentication_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_cure/features/home/blocs/therapy_bloc/therapy_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getUserData();
    context.read<TherapyBloc>().add(GetTherapiesEvent());
  }

  User? user;
  void getUserData() async {
    final user = await AuthenticationService().getCurrentUser();
    setState(() {
      this.user = user;
    });
    Logger().i(user);
  }

  List<Map<String, dynamic>> therapies = [
    {
      'name': 'Therapies',
      'description': 'Disease-specific protocols',
      "icon": Icons.medical_services_outlined,
    },
    {
      'name': 'Fasting',
      'description': 'General fasting regimens',
      "icon": Icons.fastfood_outlined,  
    },
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TherapyBloc, TherapyState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: AppLogo(),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<TherapyBloc>().add(GetTherapiesEvent());
                },
                icon: Icon(Icons.refresh),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShaderMask(
                      shaderCallback:
                          (bounds) => LinearGradient(
                            colors: [AppColors.primary, AppColors.secondary],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                      child: Text(
                        'Welcome back, ${user?.displayName?.split(' ')[0] ?? "to HealthCure"}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color:
                              Colors
                                  .white, // This color will be replaced by the gradient
                        ),
                      ),
                    ),
                    Text(
                      'Prioritize your health',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    // Image.asset('assets/images/home_image.png',height: 200,width: 200,),
                    const SizedBox(height: 16),


                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: therapies.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if(index == 0){
                              context.goNamed(RouteName.treatments);
                            } else if(index == 1){
                              context.pushNamed(RouteName.fastingTherapy);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withAlpha(10),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withAlpha(30),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary.withAlpha(20),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    therapies[index]['icon'],
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        therapies[index]['name'],
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          // color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                        Text(
                                          therapies[index]['description'],
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.copyWith(
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.grey.shade400,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
