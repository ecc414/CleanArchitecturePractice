import 'package:clearn_architecture_practice/data/source/remote/image_dto.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_photo_screen_state.freezed.dart';

@freezed
class DetailPhotoScreenState with _$DetailPhotoScreenState {
  const factory DetailPhotoScreenState({
    ImageDTO? image,
    @Default(Orientation.portrait) Orientation orientation,
  }) = _DetaulPhotoScreenState;
}
