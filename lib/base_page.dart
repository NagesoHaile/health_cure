import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_cure/config/route/route_name.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key, required this.child});
  final Widget child;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
         currentIndex: () {
            final String currentUri = GoRouterState.of(context).uri.toString();
            return _convertRouteNameIntoIndex(currentUri);
          }(),
       onTap: (index) {
          context.go(_convertIndexIntoRouteName(index));
        },  
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: 'Treatments'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

   String _convertIndexIntoRouteName(int index) {
    switch (index) {
      case 0:
        return RouteName.home;
      case 1:
        return RouteName.treatments;
    
      case 2:
        return RouteName.settings;
      default:
        return RouteName.home;
    }
  }

  int _convertRouteNameIntoIndex(String pathName) {
    if (pathName.startsWith(RouteName.home)) {
      return 0;
    } else if (pathName.startsWith(RouteName.treatments)) {
      return 1;
    } else if (pathName.startsWith(RouteName.settings)) {
      return 2;
    }
    else {
      return 0;
    }
  }
  
}