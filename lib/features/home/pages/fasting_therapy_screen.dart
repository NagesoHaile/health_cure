import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_cure/config/route/route_name.dart';
import 'package:health_cure/features/home/blocs/therapy_bloc/therapy_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FastingTherapyScreen extends StatefulWidget {
  const FastingTherapyScreen({super.key});

  @override
  State<FastingTherapyScreen> createState() => _FastingTherapyScreenState();
}

class _FastingTherapyScreenState extends State<FastingTherapyScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TherapyBloc>().add(GetFastingTherapiesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TherapyBloc, TherapyState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Choose Fasting Regimen')),
          body: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                (state is TherapyLoaded) ? state.fastingTherapies.length : 2,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed(RouteName.fastingTherapyDetail, extra: (state as TherapyLoaded).fastingTherapies[index]);
                },
                child: Skeletonizer(
                  enabled: state is TherapyLoading,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withAlpha(10),
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
                        // Container(
                        //   width: 50,
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //     color: Theme.of(
                        //       context,
                        //     ).colorScheme.primary.withAlpha(20),
                        //     borderRadius: BorderRadius.circular(8),
                        //   ),
                        //   child: Icon(
                        //     therapies[index]['icon'],
                        //     color: Theme.of(context).colorScheme.primary,
                        //   ),
                        // ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (state is TherapyLoaded) ? state.fastingTherapies[index]['therapy'] : 'Loading...',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  // color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                               Text(
                                (state is TherapyLoaded) ? "Tap to view details: ${state.fastingTherapies[index]['total_duration']?['value']?? '1-7'} ${state.fastingTherapies[index]['total_duration']?['unit'] ?? 'days'}" : 'Loading...',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey.shade500),
                              ),
                              // Text(
                              //   (state is TherapyLoaded) ? "Diseases: ${state.fastingTherapies[index]['diseases'].join(', ')}" : 'Loading...',
                              //   style: Theme.of(context).textTheme.bodyMedium
                              //       ?.copyWith(color: Colors.grey.shade500),
                              // ),
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
                ),
              );
            },
          ),
        );
      },
    );
  }
}
