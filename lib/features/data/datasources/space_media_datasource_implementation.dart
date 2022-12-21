// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/features/data/datasources/endpoints/space_endpoints.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/converters/date_input_converter.dart';

class SpaceMediaDatasouceImplementation implements ISpaceMediaDatasource {
  final DateInputConverter converter;
  final http.Client client;

  SpaceMediaDatasouceImplementation({
    required this.converter,
    required this.client,
  });

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final dateConverted = converter.format(date);
    final response = await client.get(NasaEndpoints.getSpaceMedia(
      'DEMO_KEY',
      dateConverted,
    ));
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
