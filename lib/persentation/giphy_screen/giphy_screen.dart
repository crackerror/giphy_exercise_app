import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giphy_exercise_app/persentation/giphy_screen/giphy_controller.dart';
import 'package:giphy_get/giphy_get.dart';

class GiphyScreen extends GetView<GiphyController> {
  const GiphyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GiphyController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.withAlpha(77),
        title: const Text(
          "GIPHY EXERCISER",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  GiphyGif? gif = await GiphyGet.getGif(
                    context: context,
                    apiKey: controller.apiKey,
                    lang: GiphyLanguage.english,
                  );
                  if (gif != null) {
                    controller.addSelectedGif(gif.images?.original?.url ?? '');
                  }
                },
                child: const Text(
                  "My Selected GIFs",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.selectedGifList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CachedNetworkImage(
                        imageUrl: controller.selectedGifList[index],
                        placeholder:
                            (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        errorWidget:
                            (context, url, error) => const Icon(Icons.error),
                      ),
                    );
                  },
                );
              }),
              const SizedBox(height: 20),
              const Text(
                "Trending Gif",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.gifList.isEmpty) {
                  return const Center(child: Text('No GIFs found.'));
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: controller.gifList.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: controller.gifList[index].url,
                      placeholder:
                          (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
