import 'package:clearn_architecture_practice/presentation/home/home_screen_action.dart';
import 'package:clearn_architecture_practice/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final spacing = 13.0;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    final textField = TextField(
      controller: vm.textEditingController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.background.withOpacity(0.8),
          hintText: "What are you looking for?",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 2.0)),
          suffixIcon: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              final query = vm.textEditingController.text;
              vm.onAction(HomeScreenAction.search(query));
            },
            icon: Icon(Icons.search,
                color: Theme.of(context).colorScheme.primary),
          )),
      onSubmitted: (query) {
        vm.onAction(HomeScreenAction.search(query));
      },
    );

    final gridView = GridView.count(
      physics: const BouncingScrollPhysics(),
      controller: vm.scrollController,
      crossAxisCount: 2,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      children: vm.state.images
          .map(
            (image) => ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: InkWell(
                onTap: () {
                  vm.onAction(HomeScreenAction.tapImage(context, image));
                },
                child: Image.network(
                  image.previewURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
          .toList(),
    );

    final errorWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.wifi_off),
        Text(
          "Sorry.\nPlease try again later.",
          textAlign: TextAlign.center,
        ),
      ],
    );

    const loadingWidget = Center(
      child: CircularProgressIndicator(),
    );

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                textField,
                SizedBox(
                  height: spacing,
                ),
                Expanded(
                  child: vm.state.isError
                      ? errorWidget
                      : vm.state.isLoading
                          ? loadingWidget
                          : gridView,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
