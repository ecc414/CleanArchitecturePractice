import 'package:clearn_architecture_practice/data/source/remote/image_dto.dart';
import 'package:clearn_architecture_practice/domain/use_case/fetch_images_use_case.dart';
import 'package:clearn_architecture_practice/domain/use_case/lock_orientation_use_case.dart';
import 'package:clearn_architecture_practice/presentation/detail_photo/detail_photo_screen.dart';
import 'package:clearn_architecture_practice/presentation/detail_photo/detail_photo_view_model.dart';
import 'package:clearn_architecture_practice/presentation/home/home_screen_action.dart';
import 'package:clearn_architecture_practice/presentation/home/home_screen_state.dart';
import 'package:clearn_architecture_practice/util/orientation_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeViewModel extends ChangeNotifier {
  final FetchImagesUseCase _fetchImagesUseCase;

  final _lockOrientationUseCase = LockOrientationUseCase();

  HomeScreenState _state = const HomeScreenState();

  HomeScreenState get state => _state;

  HomeViewModel(this._fetchImagesUseCase) {
    scrollController.addListener(onScroll);
  }

  final scrollController = ScrollController();

  final textEditingController = TextEditingController();

  double recentMaxScrollExtent = 0;

  onScroll() async {
    if (recentMaxScrollExtent == scrollController.position.maxScrollExtent) {
      return;
    }
    if (scrollController.position.pixels >
        scrollController.position.maxScrollExtent * 0.8) {
      recentMaxScrollExtent = scrollController.position.maxScrollExtent;
      _more();
    }
  }

  onAction(HomeScreenAction action) {
    action.when(search: (query) {
      _search(query: query);
    }, tapImage: (BuildContext context, ImageDTO image) {
      _tapImage(context, image);
    });
  }

  _search({String query = ''}) async {
    _state = _state.copyWith(
      searchQuery: query,
      isLoading: true,
      isError: false,
    );

    notifyListeners();

    final result = await _fetchImagesUseCase.execute(query: query);

    result.when(success: (images) {
      _state = _state.copyWith(
        images: images,
        isLoading: false,
        page: 1,
      );
      notifyListeners();
    }, error: (e) {
      _state = _state.copyWith(
        isLoading: false,
        isError: true,
      );
      notifyListeners();
    });
  }

  _more() async {
    final nextPage = _state.page + 1;
    final recentQuery = _state.searchQuery;
    final cacheImages = _state.images;

    final result =
        await _fetchImagesUseCase.execute(query: recentQuery, page: nextPage);

    result.when(success: (images) {
      _state = _state.copyWith(
        images: cacheImages + images,
        page: nextPage,
        isError: false,
      );
    }, error: (e) {
      _state = _state.copyWith(
        isError: true,
      );
    });
    notifyListeners();
  }

  _tapImage(BuildContext context, ImageDTO image) {
    _lockOrientationUseCase.execute(OrientationMode.youNameIt);
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                ChangeNotifierProvider<DetailPhotoViewModel>(
              create: (_) => DetailPhotoViewModel(image: image),
              child: const DetailPhotoScreen(),
            ),
          ),
        )
        .then(
          (value) =>
              _lockOrientationUseCase.execute(OrientationMode.portraitOnly),
        );
  }
}
