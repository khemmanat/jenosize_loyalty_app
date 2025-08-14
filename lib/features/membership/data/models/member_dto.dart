import 'package:json_annotation/json_annotation.dart';

import '../../../../shared/domain/value_objects.dart';
import '../../domain/entities/member.dart';

part 'member_dto.g.dart';

@JsonSerializable()
class MemberDto {
  final String id, name;
  final String tier;
  final bool isActive;
  final DateTime joinDate;

  MemberDto({required this.id, required this.name, required this.tier, required this.isActive, required this.joinDate});

  factory MemberDto.fromJson(Map<String, dynamic> j) => _$MemberDtoFromJson(j);

  Map<String, dynamic> toJson() => _$MemberDtoToJson(this);

  Member toDomain() => Member(id: id, name: name, joinDate: joinDate.toUtc(), isActive: isActive, tier: MemberTier.values.firstWhere((e) => e.name == tier, orElse: () => MemberTier.basic));
}
