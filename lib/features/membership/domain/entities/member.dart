import 'package:equatable/equatable.dart';

import '../../../../shared/domain/value_objects.dart';

class Member extends Equatable {
  final String id;
  final String name;
  final DateTime joinDate;
  final bool isActive;
  final MemberTier tier;

  const Member({required this.id, required this.name, required this.joinDate, this.isActive = true, this.tier = MemberTier.basic});

  Member copyWith({String? id, String? name, DateTime? joinDate, bool? isActive, MemberTier? tier}) =>
      Member(id: id ?? this.id, name: name ?? this.name, joinDate: joinDate ?? this.joinDate, isActive: isActive ?? this.isActive, tier: tier ?? this.tier);

  @override
  List<Object> get props => [id, name, joinDate, isActive, tier];
}
