import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_cure/config/route/route_name.dart';
import 'package:health_cure/features/home/blocs/treatment_bloc/treatment_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
class TreatmentsScreen extends StatefulWidget {
  const TreatmentsScreen({super.key});

  @override
  State<TreatmentsScreen> createState() => _TreatmentsScreenState();
}

class _TreatmentsScreenState extends State<TreatmentsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TreatmentBloc>().add(GetTreatmentsEvent());
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TreatmentBloc, TreatmentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Treatments'),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Select Treatments',style: Theme.of(context).textTheme.titleLarge,),
                Text(
                  'Select the treatments you want to apply',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: (state is TreatmentLoaded) ? state.treatments.length : 4,
                    itemBuilder: (context, index) {
                      return Skeletonizer(
                        enabled: state is TreatmentLoading,
                        child: Card(
                          color: Theme.of(context).colorScheme.primary.withAlpha(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(color: Colors.grey.shade300),
                            
                          ),
                          elevation: 0,
                          child: ListTile(
                            title: Text((state is TreatmentLoaded) ? "${state.treatments[index]['therapy']} (${state.treatments[index]['total_duration']['value']} ${state.treatments[index]['total_duration']['unit']})" : 'KV Millet'),
                            subtitle: Text(
                              (state is TreatmentLoaded) ? state.treatments[index]['diseases'].join(', ') : '',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              context.pushNamed(RouteName.treatmentDetails,extra: (state is TreatmentLoaded)?state.treatments[index]:null);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
