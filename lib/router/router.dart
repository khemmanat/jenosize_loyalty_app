import 'package:go_router/go_router.dart';
import 'package:jenosize_loyalty_app/features/campaigns/presentation/screens/campaign_page.dart';
import 'package:jenosize_loyalty_app/features/membership/presentation/membership_page.dart';
import 'package:jenosize_loyalty_app/features/points/presentation/points_page.dart';
import 'package:jenosize_loyalty_app/features/referral/presentation/referral_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CampaignPage(),
    ),
    GoRoute(
      path: '/membership',
      builder: (context, state) => const MembershipPage(),
    ),
    GoRoute(
      path: '/referral',
      builder: (context, state) => const ReferralPage(),
    ),
    GoRoute(
      path: '/points',
      builder: (context, state) => const PointsPage(),
    ),
  ],
);