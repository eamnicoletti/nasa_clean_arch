// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:nasa_clean_arch/core/errors/failure.dart';
import 'package:nasa_clean_arch/core/usecase/usecase.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/features/domain/repositories/space_media_repository.dart';

class GetSpaceMediaFromDateUsecase
    implements Usecase<SpaceMediaEntity, NoParams> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase(
    this.repository,
  );

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(NoParams params) async {
    return await repository.getSpaceMediaFromDate();
  }
}
