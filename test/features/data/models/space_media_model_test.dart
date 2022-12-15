import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';

import '../../mocks/space_media_mock.dart';

void main() {
  final tSpaceMediaModel = SpaceMediaModel(
      description:
          "On December 8 a full Moon and a full Mars were close, both bright and opposite the Sun in planet Earth's sky. In fact Mars was occulted, passing behind the Moon when viewed from some locations across Europe and North America.  Seen from the city of Kosice in eastern Slovakia, the lunar occultation of Mars happened just before sunrise. The tantalizing spectacle was recorded in this telescopic timelapse sequence of exposures. It took about an hour for the Red Planet to disappear behind the lunar disk and then reappear as a warm-hued full Moon, the last full Moon of 2022, sank toward the western horizon. The next lunar occultation of bright planet Mars will be in the new year on January 3, when the Moon is in a waxing gibbous phase. Lunar occultations are only ever visible from a fraction of the Earth's surface, though. The January 3 occultation of Mars will be visible from parts of the South Atlantic, southern Africa, and the Indian Ocean.",
      mediaType: 'image',
      title: "Full Moon, Full Mars",
      mediaUrl:
          "https://apod.nasa.gov/apod/image/2212/MarsTrailsSMALL1024.jpg");

  test('should be a subclass of SpaceMediaEntity', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('should return a valid model', () {
    // Arrange
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);

    // Act
    final result = SpaceMediaModel.fromJson(jsonMap);

    // Assert
    expect(result, tSpaceMediaModel);
  });

  test('should return a json map containing the proper data', () {
    // Arrange
    final expectedMap = {
      "explanation":
          "On December 8 a full Moon and a full Mars were close, both bright and opposite the Sun in planet Earth's sky. In fact Mars was occulted, passing behind the Moon when viewed from some locations across Europe and North America.  Seen from the city of Kosice in eastern Slovakia, the lunar occultation of Mars happened just before sunrise. The tantalizing spectacle was recorded in this telescopic timelapse sequence of exposures. It took about an hour for the Red Planet to disappear behind the lunar disk and then reappear as a warm-hued full Moon, the last full Moon of 2022, sank toward the western horizon. The next lunar occultation of bright planet Mars will be in the new year on January 3, when the Moon is in a waxing gibbous phase. Lunar occultations are only ever visible from a fraction of the Earth's surface, though. The January 3 occultation of Mars will be visible from parts of the South Atlantic, southern Africa, and the Indian Ocean.",
      "media_type": "image",
      "title": "Full Moon, Full Mars",
      "url": "https://apod.nasa.gov/apod/image/2212/MarsTrailsSMALL1024.jpg"
    };

    // Act
    final result = tSpaceMediaModel.toJson();

    // Assert
    expect(result, expectedMap);
  });
}
