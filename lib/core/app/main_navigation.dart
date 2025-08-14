import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jenosize_loyalty_app/shared/widgets/app_scaffold.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          widget.navigationShell.goBranch(
            index,
            initialLocation: index != _currentIndex,
          );
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.campaign_outlined), label: 'Campaigns'),
          NavigationDestination(icon: Icon(Icons.card_membership_outlined), label: 'Member'),
          NavigationDestination(icon: Icon(Icons.group_add_outlined), label: 'Referral'),
          NavigationDestination(icon: Icon(Icons.stars_outlined), label: 'Points'),
        ],
      ),
    );
  }
}
