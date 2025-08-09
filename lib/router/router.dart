import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jenosize_loyalty_app/features/campaigns/presentation/screens/campaign_page.dart';
import 'package:jenosize_loyalty_app/features/membership/presentation/membership_page.dart';
import 'package:jenosize_loyalty_app/features/points/presentation/points_page.dart';
import 'package:jenosize_loyalty_app/features/referral/presentation/referral_page.dart';
import 'package:jenosize_loyalty_app/shared/widgets/scaffold_with_nested_navigation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>();
final _shellNavigatorMembershipKey = GlobalKey<NavigatorState>();
final _shellNavigatorReferralKey = GlobalKey<NavigatorState>();
final _shellNavigatorPointsKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/',
              builder: (context, state) => const CampaignPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorMembershipKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/membership',
              builder: (context, state) => const MembershipPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorReferralKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/referral',
              builder: (context, state) => const ReferralPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorPointsKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/points',
              builder: (context, state) => const PointsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
