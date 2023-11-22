import 'package:clearn_architecture_practice/data/source/remote/image_dto.dart';
import 'package:clearn_architecture_practice/util/result.dart';

abstract class PixabayRepository{
  Future<Result<List<ImageDTO>>> fetchImages({required String query, required int page});
}