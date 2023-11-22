import 'package:clearn_architecture_practice/data/repository/pixabay_repository_impl.dart';
import 'package:clearn_architecture_practice/data/source/remote/pixabay_api.dart';
import 'package:clearn_architecture_practice/domain/repository/pixabay_repository.dart';
import 'package:clearn_architecture_practice/domain/use_case/fetch_images_use_case.dart';
import 'package:clearn_architecture_practice/presentation/detail_photo/detail_photo_screen.dart';
import 'package:clearn_architecture_practice/presentation/detail_photo/detail_photo_view_model.dart';
import 'package:clearn_architecture_practice/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:http/http.dart' as http;

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider<http.Client>(
    create: (context) => http.Client(),
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<http.Client, PixabayApi>(
    update: (context, client, pixabayApi) => PixabayApi(client),
  ),
  ProxyProvider<PixabayApi, PixabayRepository>(
    update: (context, pixabayApi, pixabayRepository) =>
        PixabayRepositoryImpl(pixabayApi),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<HomeViewModel>(
    create: (context) =>
        HomeViewModel(FetchImagesUseCase(context.read<PixabayRepository>())),
  ),
  ChangeNotifierProvider<DetailPhotoViewModel>(
    create: (context) => DetailPhotoViewModel(),
  ),
];
