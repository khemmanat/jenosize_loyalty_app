import 'failures.dart';

sealed class Result<T> {
  const Result();

  R fold<R>({required R Function(T) onSuccess, required R Function(Failure) onFailure});
}

class Ok<T> extends Result<T> {
  final T value;

  const Ok(this.value);

  @override
  R fold<R>({required R Function(T) onSuccess, required R Function(Failure) onFailure}) => onSuccess(value);
}

class Err<T> extends Result<T> {
  final Failure failure;

  const Err(this.failure);

  @override
  R fold<R>({required R Function(T) onSuccess, required R Function(Failure) onFailure}) => onFailure(failure);
}
