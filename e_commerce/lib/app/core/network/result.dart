// Wadah hasil operasi: Success atau Failure.
sealed class Result<T, E> {
  const Result();

  bool get isSuccess => this is Success<T, E>;
  bool get isFailure => this is Failure<T, E>;
}

// Operasi berhasil dan membawa data.
class Success<T, E> extends Result<T, E> {
  final T data;

  const Success(this.data);
}

// Operasi gagal dan membawa informasi error.
class Failure<T, E> extends Result<T, E> {
  final E error;

  const Failure(this.error);
}
