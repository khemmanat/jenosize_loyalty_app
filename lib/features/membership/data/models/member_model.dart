import 'package:jenosize_loyalty_app/features/membership/domain/entities/member.dart';

class MemberModel extends Member {
  const MemberModel({
    required super.id,
    required super.name,
    required super.joinDate,
    super.isActive,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    print('Parsing MemberModel from JSON: $json');
    return MemberModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      joinDate: json['joinDate'] != null
          ? DateTime.parse(json['joinDate'])
          : DateTime.now(),
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Member toEntity() {
    return Member(
      id: id,
      name: name,
      joinDate: joinDate,
      isActive: isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'joinDate': joinDate.toIso8601String(),
      'isActive': isActive,
    };
  }
}