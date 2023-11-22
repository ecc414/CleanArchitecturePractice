import 'dart:async';
import 'dart:convert';

import 'package:clearn_architecture_practice/data/source/remote/image_dto.dart';
import 'package:clearn_architecture_practice/data/source/remote/pixabay_api.dart';
import 'package:clearn_architecture_practice/domain/repository/pixabay_repository.dart';
import 'package:clearn_architecture_practice/util/result.dart';

class PixabayRepositoryImpl extends PixabayRepository{

  final PixabayApi _api;

  PixabayRepositoryImpl(this._api);

  @override
  Future<Result<List<ImageDTO>>> fetchImages({required String query, int page = 1}) async{
    try {
      final response = await _api.fetchImages(query: query, page: page).timeout(const Duration(seconds: 10),);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final images = (jsonResponse['hits'] as Iterable).map((result) => ImageDTO.fromJson(result)).toList();
      return Result.success(images);
    } catch (e) {
      return Result.error(Exception("Load data failed: ${e.toString()}"));
    }
  }

}