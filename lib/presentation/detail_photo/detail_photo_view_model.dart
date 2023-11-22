import 'package:clearn_architecture_practice/data/source/remote/image_dto.dart';
import 'package:clearn_architecture_practice/presentation/detail_photo/detail_photo_screen_action.dart';
import 'package:clearn_architecture_practice/presentation/detail_photo/detail_photo_screen_state.dart';
import 'package:flutter/material.dart';

class DetailPhotoViewModel extends ChangeNotifier{
  DetailPhotoScreenState _state = const DetailPhotoScreenState();

  DetailPhotoScreenState get state => _state;

  DetailPhotoViewModel({ImageDTO? image}){
    _state = _state.copyWith(
      image: image
    );
  }

  onAction(DetailPhotoScreenAction action){
    action.when(rotate: (orientation){
      _state = _state.copyWith(
        orientation: orientation
      );
    }, close: (context){
      _close(context);
    });
  }

  _close(BuildContext context){
    Navigator.of(context).pop();
  }
}