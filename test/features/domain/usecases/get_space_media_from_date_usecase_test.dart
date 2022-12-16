import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

// https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2022-12-08

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  test('should get space media entity for a given date from the repository',
      () async {
    // Stub a method before interacting with the mock.
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => const Right<Failure, SpaceMediaEntity>(tSpaceMedia));

    final result = await usecase(tDate);

    // Interact with the mock.
    expect(result, Right(tSpaceMedia));

    // Verify the interaction.
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });

  test('should return a ServerFailure when don\'t succeed', () async {
    // Stub a method before interacting with the mock.
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));

    final result = await usecase(tDate);

    // Interact with the mock.
    expect(result, Left(ServerFailure()));

    // Verify the interaction.
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });
}
