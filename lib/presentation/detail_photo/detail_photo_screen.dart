import 'package:clearn_architecture_practice/data/source/remote/image_dto.dart';
import 'package:clearn_architecture_practice/presentation/detail_photo/detail_photo_screen_action.dart';
import 'package:clearn_architecture_practice/presentation/detail_photo/detail_photo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPhotoScreen extends StatelessWidget {
  const DetailPhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DetailPhotoViewModel>();

    final errorWidget = Text(
      "An error occurred.",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineLarge,
    );

    final closeButton = IconButton(
      onPressed: () {
        vm.onAction(DetailPhotoScreenAction.close(context));
      },
      icon: const Icon(Icons.close),
    );

    Widget photo(ImageDTO? image) {
      return Center(
        child: image == null
            ? errorWidget
            : Image.network(
                image!.largeImageURL,
                loadingBuilder: (_, child, loadingProgress) {
                  return loadingProgress == null
                      ? child
                      : const CircularProgressIndicator();
                },
                errorBuilder: (_, __, ___) {
                  return errorWidget;
                },
              ),
      );
    }

    return Stack(
      children: [
        OrientationBuilder(builder: (context, orientation) {
          switch (orientation) {
            case Orientation.portrait:
              vm.onAction(DetailPhotoScreenAction.rotate(orientation));
              return photo(vm.state.image!);
            case Orientation.landscape:
              vm.onAction(DetailPhotoScreenAction.rotate(orientation));
              return photo(vm.state.image!);
          }
        }),
        Positioned(right: 10.0, top: 20.0, child: closeButton),
      ],
    );
  }
}
