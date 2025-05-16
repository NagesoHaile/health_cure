import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TreatmentDetailScreen extends StatefulWidget {
  const TreatmentDetailScreen({super.key});

  @override
  State<TreatmentDetailScreen> createState() => _TreatmentDetailScreenState();
}

class _TreatmentDetailScreenState extends State<TreatmentDetailScreen> {
  Map<String, dynamic> treatment = {};
  @override
  Widget build(BuildContext context) {
    final args = GoRouterState.of(context).extra as Map<String, dynamic>?;
    treatment = args ?? {};
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Treatment Detail'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(treatment['therapy'],style: Theme.of(context).textTheme.titleLarge,),
                SizedBox(height: 16,),
                TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 2,
                  indicator: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withAlpha(20),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  dividerHeight: 1,
                  dividerColor: Theme.of(context).colorScheme.surface,
                  tabs: [
                    Tab(text: 'Plans'),
                    Tab(text: 'Overview'),
                    Tab(text: 'FAQ'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}