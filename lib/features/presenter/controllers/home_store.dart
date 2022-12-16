import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';

class HomeStore extends NotifierStore<Failure, SpaceMediaEntity> {
  final GetSpaceMediaFromDateUsecase usecase;

  HomeStore(this.usecase)
      : super(SpaceMediaEntity(
            description: '', mediaType: '', title: '', mediaUrl: ''));

  getSpaceMediaFromDate(DateTime date) async {
    executeEither(() =>
        usecase(date) as Future<EitherAdapter<Failure, SpaceMediaEntity>>);

    // * executeEither() does the same as the four lines below:
    // setLoading(true);
    // final result = await usecase(date);
    // result.fold((error) => setError(error), (success) => update(success));
    // setLoading(false);
  }
}
