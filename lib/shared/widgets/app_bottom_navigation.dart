import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.outline,
      onTap: (index) => _handleNavigation(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Riverpod',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_membership),
          label: 'Membership',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.share),
          label: 'Referral',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.stars),
          label: 'Points',
        ),
      ],
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/membership');
        break;
      case 2:
        context.go('/referral');
        break;
      case 3:
        context.go('/points');
        break;
    }
  }
}
