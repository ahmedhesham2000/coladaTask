import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.message, {this.statusCode});

  @override
  List<Object> get props => [message, statusCode ?? 0];
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Loyalty-specific failure with structured error code for UI handling.
class LoyaltyFailure extends Failure {
  final String errorCode;

  const LoyaltyFailure(this.errorCode, [String? message])
    : super(message ?? errorCode);

  @override
  List<Object> get props => [errorCode, message];
}
