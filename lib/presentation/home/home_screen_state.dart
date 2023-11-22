import 'package:clearn_architecture_practice/data/source/remote/image_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_screen_state.freezed.dart';

@freezed
class HomeScreenState with _$HomeScreenState{
  const factory HomeScreenState({
    @Default([]) List<ImageDTO> images,
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    //@Default(false) bool isTextFieldFocused,
    @Default('') String searchQuery,
    @Default(0) int page,
  }) = _HomeScreenState;
}