import 'package:clearn_architecture_practice/util/app_constants.dart';
import 'package:http/http.dart' as http;

class PixabayApi {
  static const baseURL = 'https://pixabay.com/api/';
  static const key = '40046314-c42448acad400288b90bc81b4';

  final http.Client client;

  PixabayApi(this.client);

  Future<http.Response> fetchImages({required String query, int page = 1}) async {
    //client ??= http.Client();
    final response = await client.get(
        Uri.parse("$baseURL?key=$key&q=$query&image_type=photo&page=$page&per_page=$perPage")
      // Uri(
      //   scheme: "https",
      //   host: "pixabay.com",
      //   path: "api/?key=$key",
      //   queryParameters: {
      //     "image_type": "photo",
      //     "page": page,
      //     "per_page": perPage
      //   }
      // )
    );
    return response;
  }
}