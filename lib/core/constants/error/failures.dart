import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {}

class GeneralFailure extends Failure {
  final String message;

  const GeneralFailure(this.message);

  @override
  List<Object?> get props => [message];
}