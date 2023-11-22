
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_photo_screen_action.freezed.dart';

@freezed
class DetailPhotoScreenAction with _$DetailPhotoScreenAction{
  const factory DetailPhotoScreenAction.rotate(Orientation orientation) = Rotate;
  const factory DetailPhotoScreenAction.close(BuildContext context) = Close;
}