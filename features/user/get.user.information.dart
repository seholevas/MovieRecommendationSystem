import 'package:dartz/dartz.dart';
import 'package:recommend/core/errors/failure.interface.dart';
import 'package:recommend/core/usecase/usecase.interface.dart';
import 'package:recommend/features/user/user.entity.dart';
import 'package:recommend/features/user/user.repository.dart';

class GetUserInformation implements UseCase<User, NoParams> {
  final UserRepository repository;

  GetUserInformation(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getUserInformation();
  }
}
