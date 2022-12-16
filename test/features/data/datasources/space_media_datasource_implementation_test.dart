import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/http_client/http_client.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_to_String_converter.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

import '../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDatasource datasource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = NasaDatasourceImplementation(client);
  });

  final tDateTime = DateTime(2022, 12, 14);
  const urlExpected =
      'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2022-12-14';

  DateToStringConverter.convert(tDateTime);

  void successMock() {
    when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(data: spaceMediaMock, statusCode: 200));
  }

  test('should call the get method with correct url', () async {
    // Arrange
    successMock();

    // Act
    await datasource.getSpaceMediaFromDate(tDateTime);

    // Assert
    verify(
      () => client.get(urlExpected),
    ).called(1);
  });

  test('should return a SpaceMediaModel when is successful', () async {
    // Arrange
    successMock();

    final tSpaceMediaModelExpected = SpaceMediaModel(
        description:
            "On December 8 a full Moon and a full Mars were close, both bright and opposite the Sun in planet Earth's sky. In fact Mars was occulted, passing behind the Moon when viewed from some locations across Europe and North America.  Seen from the city of Kosice in eastern Slovakia, the lunar occultation of Mars happened just before sunrise. The tantalizing spectacle was recorded in this telescopic timelapse sequence of exposures. It took about an hour for the Red Planet to disappear behind the lunar disk and then reappear as a warm-hued full Moon, the last full Moon of 2022, sank toward the western horizon. The next lunar occultation of bright planet Mars will be in the new year on January 3, when the Moon is in a waxing gibbous phase. Lunar occultations are only ever visible from a fraction of the Earth's surface, though. The January 3 occultation of Mars will be visible from parts of the South Atlantic, southern Africa, and the Indian Ocean.",
        mediaType: "image",
        title: "Full Moon, Full Mars",
        mediaUrl:
            "https://apod.nasa.gov/apod/image/2212/MarsTrailsSMALL1024.jpg");

    // Act
    final result = await datasource.getSpaceMediaFromDate(tDateTime);

    // Assert
    expect(result, tSpaceMediaModelExpected);
  });

  test('should throw a ServerException when the call is unccessful', () async {
    // Arrange
    when(() => client.get(any())).thenAnswer((_) async =>
        HttpResponse(data: 'SOMETHING WENT WRONG', statusCode: 400));

    // Act
    final result = datasource.getSpaceMediaFromDate(tDateTime);

    // Assert
    expect(() => result, throwsA(ServerException()));
  });
}
