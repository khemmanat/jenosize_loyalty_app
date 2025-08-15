import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize_loyalty_app/features/campaigns/domain/entities/campaign.dart';
import 'package:jenosize_loyalty_app/features/campaigns/presentation/pages/campaign_page.dart';
import 'package:jenosize_loyalty_app/features/campaigns/presentation/providers/campaign_ui_providers.dart';

void main() {
  group('CampaignsPage Widget Tests', () {
    testWidgets('should display loading indicator when campaigns are loading', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            campaignsVMProvider.overrideWith(
                  (ref) => Future.delayed(const Duration(seconds: 10)),
            ),
          ],
          child: const MaterialApp(home: CampaignsPage()),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display campaign cards when data is loaded', (tester) async {
      final mockCampaigns = [
         Campaign(
          id: '1',
          title: 'Test Campaign',
          description: 'Test Description',
          imageUrl: 'https://test.com/image.jpg',
          ctaText: 'Join Now',
          rewardPoints: 100,
          isActive: true,
          createdAt: DateTime(2023, 1, 1),
        ),
      ];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            campaignsVMProvider.overrideWith(
                  (ref) => mockCampaigns,
            ),
          ],
          child: const MaterialApp(home: CampaignsPage()),
        ),
      );

      expect(find.byType(Card), findsWidgets);
      expect(find.text('Test Campaign'), findsOneWidget);
      expect(find.text('Join Now'), findsOneWidget);
    });

    testWidgets('should display error message when loading fails', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            campaignsVMProvider.overrideWith(
                    (ref) => Future.error('Network error'),
            ),
          ],
          child: const MaterialApp(home: CampaignsPage()),
        ),
      );

      expect(find.text('Network error'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });
  });
}