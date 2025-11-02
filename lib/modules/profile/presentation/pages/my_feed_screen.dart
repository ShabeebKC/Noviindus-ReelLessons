import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reel_lessons/constants/app_colors.dart';
import 'package:reel_lessons/constants/app_styles.dart';
import 'package:reel_lessons/modules/dashboard/presentation/widgets/app_app_bar.dart';
import 'package:reel_lessons/modules/profile/presentation/manager/profile_provider.dart';
import '../../../../constants/app_resources.dart';
import '../../../../utils/utils.dart';

class MyFeedScreen extends StatefulWidget {
  const MyFeedScreen({super.key});

  @override
  State<MyFeedScreen> createState() => _MyFeedScreenState();
}

class _MyFeedScreenState extends State<MyFeedScreen> {

  final ScrollController _scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    context.read<ProfileProvider>().fetchMyFeeds(page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
          !context.read<ProfileProvider>().isCompleted) {
        context.read<ProfileProvider>().fetchMyFeeds(page++);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
          "My Feeds",
          actions: []),
      body: Consumer<ProfileProvider>(
        builder: (context, content, child) {
          if (content.myFeeds.isEmpty) return const SizedBox.shrink();

          return ListView.separated(
            controller: _scrollController,
            itemCount: content.myFeeds.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final feed = content.myFeeds[index];
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
                          Text(feed.user?.name ?? "", style: AppTextStyles.montserratRegular(13),),
                          Text(Utils.formatDate(feed.createdAt ?? ""), style: AppTextStyles.montserratRegular(13),)
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
                              feed.image ?? "",
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
                  Text(feed.description ?? "", style: AppTextStyles.montserratRegular(13),),
                  const SizedBox(height: 10,),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(height: 10, thickness: 5, color: AppColors.black,),
          );
        },
      ),
    );
  }
}