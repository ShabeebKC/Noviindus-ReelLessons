import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reel_lessons/constants/app_colors.dart';
import 'package:reel_lessons/constants/app_resources.dart';
import 'package:reel_lessons/constants/app_styles.dart';
import 'package:reel_lessons/modules/dashboard/presentation/manager/dashboard_provider.dart';
import 'package:reel_lessons/modules/dashboard/presentation/pages/add_feed_screen.dart';
import 'package:chewie/chewie.dart';
import '../../../../utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello Maria", style: AppTextStyles.montserratMedium(16)),
            const SizedBox(height: 10),
            Text("Welcome back to section", style: AppTextStyles.montserratRegular(12)),
          ],
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddFeedScreen())),
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Image.asset(AppResources.user, height: 40,),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: AppColors.secondary,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddFeedScreen())),
          child: Icon(Icons.add, color: AppColors.white, size: 35,)
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          _renderCategories(),
          const SizedBox(height: 10),
          _renderVideoFeeds()
        ],
      ),
    );
  }

  Widget _renderCategories(){
    return Consumer<DashboardProvider>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          children: List.generate(value.homeComponents?.categories.length ?? 0, (index) {
            return Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  margin: EdgeInsets.only(right: index != 0 ? 10 : 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.containerBorder,
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      if(index == 0)
                        ...[SvgPicture.asset(AppResources.explore),
                          const SizedBox(width: 5,)],
                      Text(
                          value.homeComponents?.categories[index].title ?? "",
                          style: AppTextStyles.montserratRegular(14)
                      ),
                    ],
                  ),
                ),
                if(index == 0) SizedBox(
                  height: 25,
                  child: VerticalDivider(
                    color: AppColors.white,
                    thickness: 0.5,
                    width: 20,
                  ),
                ),
              ],
            );
          }),
        ),
      );
    });
  }

  Widget _renderVideoFeeds() {
    return Consumer<DashboardProvider>(
      builder: (context, content, child) {
        if (content.homeComponents?.results.isEmpty ?? true) return const SizedBox.shrink();

        return Expanded(
          child: ListView.separated(
            itemCount: content.homeComponents?.results.length ?? 0,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final feed = content.homeComponents?.results[index];
              final isPlaying = content.currentPlayingIndex == index;
          
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset(AppResources.user, width: 35),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(feed?.user.name ?? "", style: AppTextStyles.montserratRegular(13),),
                          Text(Utils.formatDate(feed?.createdAt ?? ""), style: AppTextStyles.montserratRegular(13),)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      content.playVideo(index);
                    },
                    child: AspectRatio(
                      aspectRatio: content.getController(index).value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (!isPlaying)
                            Image.network(
                              feed?.image ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),

                          if (isPlaying)
                            Chewie(controller: content.getChewieController(index)),

                          if (!isPlaying)
                            const Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(feed?.description ?? "", style: AppTextStyles.montserratRegular(13),),
                  const SizedBox(height: 10,),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(height: 10, thickness: 5, color: AppColors.black,),
          ),
        );
      },
    );
  }
}