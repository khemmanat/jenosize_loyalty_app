import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jenosize_loyalty_app/core/app/main_navigation.dart';
import 'package:jenosize_loyalty_app/features/campaigns/presentation/pages/campaign_page.dart';
import 'package:jenosize_loyalty_app/features/membership/presentation/pages/membership_page.dart';
import 'package:jenosize_loyalty_app/features/points/presentation/pages/points_page.dart';
import 'package:jenosize_loyalty_app/features/referral/presentation/pages/referral_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _campaignsKey  = GlobalKey<NavigatorState>(debugLabel: 'campaigns');
final _membershipKey = GlobalKey<NavigatorState>(debugLabel: 'membership');
final _referralKey   = GlobalKey<NavigatorState>(debugLabel: 'referral');
final _pointsKey     = GlobalKey<NavigatorState>(debugLabel: 'points');

final GoRouter appRouter = GoRouter(
  initialLocation: '/campaigns',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainNavigation(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _campaignsKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/campaigns',
              name: 'campaigns',
              builder: (context, state) => const CampaignsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _membershipKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/membership',
              name: 'membership',
              builder: (context, state) => const MembershipPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _referralKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/referral',
              name: 'referral',
              builder: (context, state) => const ReferralPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _pointsKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/points',
              name: 'points',
              builder: (context, state) => const PointsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
