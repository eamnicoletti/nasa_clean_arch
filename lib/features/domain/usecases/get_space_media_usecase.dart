import 'package:nasa_clean_arch/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_clean_arch/core/usecase/usecase.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';

class GetSpaceMediaUsecase implements Usecase<SpaceMediaEntity, NoParams> {
  @override
  Future<Either<Failure, SpaceMediaEntity>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
