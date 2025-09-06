import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/gif_data.dart';

class GiphyController extends GetxController {
  final apiKey = "PXkOQSY14UIOGC2C66LsVKB1mpO5ESyR";
  RxBool isLoading = true.obs;
  RxList gifList = <GifData>[].obs;
   
  var selectedGifList = <String>[].obs;

  @override
  void onInit() {
    fetchTrendingGifs();
    super.onInit();
  }

  Future<void> fetchTrendingGifs() async {
    try {
      isLoading(true);
      final url = Uri.parse(
        'https://api.giphy.com/v1/gifs/trending?api_key=$apiKey&limit=25',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final List<dynamic> data = jsonBody['data'];
        gifList.value = data.map((json) => GifData.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load GIFs');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void addSelectedGif(String gifUrl) {
    selectedGifList.add(gifUrl);
  }
}
