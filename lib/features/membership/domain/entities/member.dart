import 'package:equatable/equatable.dart';

class Member extends Equatable {
  final String id;
  final String name;
  final DateTime joinDate;
  final bool isActive;

  const Member({
    required this.id,
    required this.name,
    required this.joinDate,
    this.isActive = true,
  });

  Member copyWith({
    String? id,
    String? name,
    DateTime? joinDate,
    bool? isActive,
  }) {
    return Member(
      id: id ?? this.id,
      name: name ?? this.name,
      joinDate: joinDate ?? this.joinDate,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  String toString() {
    return 'Member(id: $id, name: $name, joinDate: $joinDate, isActive: $isActive)';
  }

  @override
  List<Object> get props => [id, name, joinDate, isActive];
}