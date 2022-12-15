import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';

// https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2022-12-08

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  const tSpaceMedia = SpaceMediaEntity(
      description:
          '''A camera on board the uncrewed Orion spacecraft captured this view 
          on December 5 as Orion approached its return powered flyby of the Moon.
          Below one of Orion's extended solar arrays lies dark, smooth, 
          terrain along the western edge of the Oceanus Procellarum. Prominent 
          on the lunar nearside Oceanus Procellarum, the Ocean of Storms, is 
          the largest of the Moon's lava-flooded maria. The lunar terminator, 
          shadow line between lunar night and day, runs along the left of the 
          frame. The 41 kilometer diameter crater Marius is top center, with 
          ray crater Kepler peeking in at the edge, just right of the solar 
          array wing. Kepler's bright rays extend to the north and west, 
          reaching the dark-floored Marius. Of course the Orion spacecraft 
          is now headed toward a December 11 splashdown in planet Earth's 
          water-flooded Pacific Ocean.''',
      mediaType: 'image',
      title: 'Orion and the Ocean of Storms',
      mediaUrl:
          'https://apod.nasa.gov/apod/image/2212/art001e002132_apod1024.jpg');

  final tDate = DateTime(2022, 12, 10);

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
