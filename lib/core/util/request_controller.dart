import 'package:domain/domain.dart';

mixin RequestController {
  Future<void> getDataWithPramas<T>(
    BaseUseCase<Params, T> createCall, {
    required Params params,
    required void Function(T) onSuccess,
    void Function(BaseError)? onFailure,
  }) async {
    await createCall.execute(params).then((value) {
      value.fold(
        (error) {
          onFailure?.call(error);
        },
        (data) {
          onSuccess(data);
        },
      );
    });
  }

  Future<void> getData<T>(
    BaseUsesCaseNoParams< T> createCall, {
    required void Function(T) onSuccess,
    void Function(BaseError)? onFailure,
  }) async {
    await createCall.execute().then((value) {
      value.fold(
        (error) {
          onFailure?.call(error);
        },
        (data) {
          onSuccess(data);
        },
      );
    });
  }
}
