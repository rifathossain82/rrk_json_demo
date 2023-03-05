import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rrk_json_demo/controller/home_controller.dart';
import 'package:rrk_json_demo/model/game_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (homeController.gameData.value.data!.isEmpty) {
          return const Center(
            child: Text('No Data Found!'),
          );
        } else {
          return ListView.separated(
            itemCount: homeController.gameData.value.data!.length,
            itemBuilder: (context, index) {
              Data data = homeController.gameData.value.data![index];
              return Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: data.days!.length,
                        itemBuilder: (context, index) => Container(
                          height: 60,
                          width: 120,
                          color: Colors.green,
                          child: Text("Data ${data.days![index].number}"),
                        ),
                      ),
                    ),
                    Text('${data.title}'),
                    const SizedBox(height: 15),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.countries!.length,
                      itemBuilder: (context, index) =>
                          Text(data.countries![index]),
                    ),
                    const SizedBox(height: 15),
                    Image.network(data.photos!.first),
                    const SizedBox(height: 15),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.days!.length,
                      itemBuilder: (context, index) => Container(
                        height: 120,
                        child: Column(),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          );
        }
      }),
    );
  }
}
