import 'package:clearn_architecture_practice/data/source/remote/image_dto.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_screen_action.freezed.dart';

@freezed
class HomeScreenAction with _$HomeScreenAction{
  const factory HomeScreenAction.search(String query) = Search;
  const factory HomeScreenAction.tapImage(BuildContext context, ImageDTO image) = tapImage;
  // const factory HomeScreenAction.onTextFieldFocusChange(bool isFocused) = OnTextFieldFocusChange;
  // const factory HomeScreenAction.searchIconClick() = SearchIconClick;
}