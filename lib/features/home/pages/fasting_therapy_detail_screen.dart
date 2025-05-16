import 'package:flutter/material.dart';

class FastingTherapyDetailScreen extends StatelessWidget {
  const FastingTherapyDetailScreen({super.key, required this.fastingTherapy});
  final Map<String, dynamic> fastingTherapy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(fastingTherapy['therapy'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Duration: ${fastingTherapy['total_duration']?['value'] ?? '1-7'} ${fastingTherapy['total_duration']?['unit'] ?? 'days'}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),
              Text(
                "Diseases: ${fastingTherapy['diseases'].join(', ')}",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
              ),
              const SizedBox(height: 16),
              Text(
                "Treatment Details:",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: fastingTherapy['tasks'].length,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder:
                    (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final task = fastingTherapy['tasks'][index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(10),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task['activity'].toString().toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.grey.shade800),
                        ),
                        if (task['form'] != null)
                        Text(
                          "Form: ${task['form']}",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                        if(task['applies_during'] != null)
                        const SizedBox(height: 8),
                        if(task['applies_during'] != null)
                        Text(
                          "Applies During: ${task['applies_during']}",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                        if(task['duration'] != null)
                        const SizedBox(height: 8),
                        if(task['duration'] != null)
                        Text(
                          "Duration: ${task['duration']['value']} ${task['duration']['unit']}",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                        if(task['mode'] != null)
                        const SizedBox(height: 8),
                        if(task['mode'] != null)
                        Text(
                          "Mode: ${task['mode']}",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                        if(task['note'] != null)
                        const SizedBox(height: 8),
                        if(task['note'] != null)
                        Text(
                          "Note: ${task['note']}",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                     if(task['repeat'] != null )
                     const SizedBox(height: 8),
                     if(task['repeat'] != null )
                     Text(
                      "Repeat: ${task['repeat']? "Yes" : "No"}",
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey.shade600),
                    ),
                        if (task['items'] != null && task['items'].isNotEmpty)
                        Text(
                          "Items:",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                        ...List.generate(task['items']?.length ?? 0, (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).colorScheme.primary.withAlpha(90),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "${task['items'][index]?['name'] ?? ''}",
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                            if (task['items'][index]?['when'] != null)
                            const SizedBox(height: 8),
                            if (task['items'][index]?['when'] != null)
                            Text(
                              "When:",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                            Text(
                              "${task['items'][index]?['when'] ?? ''}",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                            if(task['items'][index]?['note'] != null)
                            const SizedBox(height: 8),
                            if(task['items'][index]?['note'] != null)
                            Text(
                              "Notes:",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                            if(task['items'][index]?['note'] != null)
                            Text(
                              "${task['items'][index]?['note'] ?? ''}",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                          ],
                        )),
                        if(task['duration_range'] != null)
                        const SizedBox(height: 16),
                        if(task['duration_range'] != null)

                        Text(
                          "Duration Range:",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                        if(task['duration_range'] != null)
                        Text(
                          "${task['duration_range']?['min']['value'] ?? ''} ${task['duration_range']?['min']['unit'] ?? ''} - ${task['duration_range']?['max']['value'] ?? ''} ${task['duration_range']?['max']['unit'] ?? ''}",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                          ),
                       
                  
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //   child: ElevatedButton(
      //     onPressed: () {},
      //     child: const Text('Start Therapy'),
      //   ),
      // ),
    );
  }
}
