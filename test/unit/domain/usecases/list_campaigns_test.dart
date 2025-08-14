import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize_loyalty_app/core/errors/failures.dart';
import 'package:jenosize_loyalty_app/core/errors/result.dart';
import 'package:jenosize_loyalty_app/features/campaigns/domain/entities/campaign.dart';
import 'package:jenosize_loyalty_app/features/campaigns/domain/repositories/campaign_repository.dart';
import 'package:jenosize_loyalty_app/features/campaigns/domain/usecases/list_campaigns.dart';
import 'package:mocktail/mocktail.dart';

class MockCampaignsRepository extends Mock implements CampaignsRepository {}

void main() {
  late ListCampaigns useCase;
  late MockCampaignsRepository mockRepository;

  setUp(() {
    mockRepository = MockCampaignsRepository();
    useCase = ListCampaigns(mockRepository);
  });

  group('ListCampaigns', () {
    final tCampaigns = [
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

    test('should return campaigns when repository call is successful', () async {
      // Arrange
      when(() => mockRepository.listCampaigns(page: 1, limit: 20))
          .thenAnswer((_) async => Ok(tCampaigns));

      // Act
      final result = await useCase(page: 1, limit: 20);

      // Assert
      expect(result, isA<Ok<List<Campaign>>>());
      result.fold(
        onSuccess: (campaigns) => expect(campaigns, equals(tCampaigns)),
        onFailure: (_) => fail('Should return success'),
      );
      verify(() => mockRepository.listCampaigns(page: 1, limit: 20)).called(1);
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      const tFailure = NetworkFailure('Network error');
      when(() => mockRepository.listCampaigns(page: 1, limit: 20))
          .thenAnswer((_) async => const Err(tFailure));

      // Act
      final result = await useCase(page: 1, limit: 20);

      // Assert
      expect(result, isA<Err<List<Campaign>>>());
      result.fold(
        onSuccess: (_) => fail('Should return failure'),
        onFailure: (failure) => expect(failure, equals(tFailure)),
      );
    });
  });
}