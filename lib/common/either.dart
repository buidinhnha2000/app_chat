import 'dart:async';
import 'dart:developer';

typedef Lazy<T> = T Function();

abstract class Either<L, R> {
  const Either();

  Either<L, NR> map<NR>(NR Function(R value) block);

  Either<NL, R> mapLeft<NL>(Function(L value) block);

  Future<Either<L, NR>> mapAsync<NR>(FutureOr<NR> Function(R value) block);

  Future<Either<NL, R>> mapLeftAsync<NL>(FutureOr<NL> Function(L value) block);

  T fold<T>({
    required T Function(L left) ifLeft,
    required T Function(R right) ifRight,
  });

  /// Constructs a new [Either] from a function that might throw
  static Future<Either<L, R>> tryCatch<L, R, Err extends Object>(
      L Function(Err err) onError, Future<R> Function() fnR) async {
    try {
      return Right(await fnR());
    } on Err catch (e) {
      log(e.toString());
      return Left(onError(e));
    }
  }

  /// If the condition is satify then return [rightValue] in [Right] else [leftValue] in [Left]
  static Either<L, R> cond<L, R>(bool test, L leftValue, R rightValue) =>
      test ? Right(rightValue) : Left(leftValue);

  /// If the condition is satify then return [rightValue] in [Right] else [leftValue] in [Left]
  static Either<L, R> condLazy<L, R>(
          bool test, Lazy<L> leftValue, Lazy<R> rightValue) =>
      test ? Right(rightValue()) : Left(leftValue());
}

class Left<L, R> extends Either<L, R> {
  final L left;

  const Left(this.left);

  @override
  T fold<T>(
      {required T Function(L left) ifLeft,
      required T Function(R right) ifRight}) {
    return ifLeft(left);
  }

  @override
  Either<L, NR> map<NR>(NR Function(R value) block) => Left<L, NR>(left);

  @override
  Either<NL, R> mapLeft<NL>(Function(L value) block) =>
      Left<NL, R>(block(left));

  @override
  Future<Either<L, NR>> mapAsync<NR>(FutureOr<NR> Function(R value) block) =>
      Future.value(Left<L, NR>(left));

  @override
  Future<Either<NL, R>> mapLeftAsync<NL>(
          FutureOr<NL> Function(L value) block) =>
      Future.value(block(left)).then((value) => Left<NL, R>(value));
}

class Right<L, R> extends Either<L, R> {
  final R right;

  const Right(this.right);

  @override
  T fold<T>(
      {required T Function(L left) ifLeft,
      required T Function(R right) ifRight}) {
    return ifRight(right);
  }

  @override
  Either<L, NR> map<NR>(NR Function(R value) block) =>
      Right<L, NR>(block(right));

  @override
  Future<Either<L, NR>> mapAsync<NR>(FutureOr<NR> Function(R value) block) =>
      Future.value(block(right)).then((value) => Right<L, NR>(value));

  @override
  Either<NL, R> mapLeft<NL>(Function(L value) block) => Right<NL, R>(right);

  @override
  Future<Either<NL, R>> mapLeftAsync<NL>(
          FutureOr<NL> Function(L value) block) =>
      Future.value(Right<NL, R>(right));
}
