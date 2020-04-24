import 'package:dartz/dartz.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/core/usecase/usecase.interface.dart';
import 'package:recommend/features/user/user.entity.dart';
import 'package:recommend/features/user/user.repository.dart';

class CreateAccount implements UseCase<User, Params> {
  final UserRepository repository;

  CreateAccount(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.createAccount(params.dictionary);
  }
}
