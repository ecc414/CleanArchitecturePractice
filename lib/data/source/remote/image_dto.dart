import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_dto.g.dart';

part 'image_dto.freezed.dart';

@freezed
class ImageDTO with _$ImageDTO {
  const factory ImageDTO({
    required int id,
    required String pageURL,
    required String type,
    required String tags,
    required String previewURL,
    required int previewWidth,
    required int previewHeight,
    required String webformatURL,
    required int webformatWidth,
    required int webformatHeight,
    required String largeImageURL,
    required int imageWidth,
    required int imageHeight,
    required int imageSize,
    required int views,
    required int downloads,
    required int collections,
    required int likes,
    required int comments,
    @JsonKey(name: 'user_id') required int userId,
    required String user,
    required String userImageURL,
  }) = _ImageDTO;

  factory ImageDTO.fromJson(Map<String, Object?> json) =>
      _$ImageDTOFromJson(json);
}
