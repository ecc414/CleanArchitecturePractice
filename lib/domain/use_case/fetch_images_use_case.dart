import 'package:clearn_architecture_practice/data/source/remote/image_dto.dart';
import 'package:clearn_architecture_practice/domain/repository/pixabay_repository.dart';
import 'package:clearn_architecture_practice/util/result.dart';

class FetchImagesUseCase {
  final PixabayRepository _repository;

  FetchImagesUseCase(this._repository);

  Future<Result<List<ImageDTO>>> execute({required String query, int page = 1}) async {
    final result = await _repository.fetchImages(query: query, page: page);
    return result.when(success: (images) {
      return Result.success(images);
    }, error: (message) {
      return Result.error(message);
    });
  }
}
