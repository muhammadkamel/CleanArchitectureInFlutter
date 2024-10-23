import 'package:dartz/dartz.dart';
import 'package:oth_app/src/core/network/failure.dart';

typedef FutureEitherFailureOrType<T> = Future<Either<Failure, T>>;
