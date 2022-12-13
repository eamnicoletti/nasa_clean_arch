import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDatacource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatacource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
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

  test('should return space media model when calls the datasource', () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => tSpaceMediaModel);

    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);

    // Assert
    expect(result, Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test(
      'should return a server failure when the call to datasource is unsuccessful',
      () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenThrow(ServerException());
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });
}
