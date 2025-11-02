import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reel_lessons/constants/app_colors.dart';
import 'package:reel_lessons/constants/app_resources.dart';
import 'package:reel_lessons/constants/app_styles.dart';
import 'package:reel_lessons/modules/dashboard/presentation/manager/dashboard_provider.dart';
import 'package:reel_lessons/modules/dashboard/presentation/widgets/app_app_bar.dart';

class AddFeedScreen extends StatefulWidget {
  const AddFeedScreen({super.key});

  @override
  State<AddFeedScreen> createState() => _AddFeedScreenState();
}

class _AddFeedScreenState extends State<AddFeedScreen> {
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppAppBar(
          "Add Feeds",
          actions: [
            Container(
              margin: EdgeInsets.only(right: 16),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.containerBg,
                  border: Border.all(color: AppColors.secondary)
              ),
              child: Text(
                  "Share Post",
                  style: AppTextStyles.montserratRegular(14)
              ),
            )
      ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                _renderAddVideo(),
                const SizedBox(height: 15,),
                _renderAddThumbnail(),
                const SizedBox(height: 15),
                ..._renderAddDescription(),
                ..._renderCategories()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderAddVideo(){
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.grey, width: 0.3)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppResources.uploadVideo),
          const SizedBox(height: 5,),
          Text("Select a video from gallery", style: AppTextStyles.montserratRegular(16))
        ],
      ),
    );
  }

  Widget _renderAddThumbnail(){
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.grey, width: 0.3)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppResources.uploadImage),
          const SizedBox(height: 5,),
          Text("Add a Thumbnail", style: AppTextStyles.montserratRegular(16))
        ],
      ),
    );
  }

  List<Widget> _renderAddDescription() {
    return [
      Text(
          "Add Description",
          style: AppTextStyles.montserratMedium(16)
      ),
      const SizedBox(height: 15),
      TextFormField(
        controller: _descController,
        style: AppTextStyles.montserratRegular(14),
        maxLines: 4,
      ),
      const SizedBox(height: 50)
    ];
  }

  List<Widget> _renderCategories(){
    return [
      Text(
          "Categories This Project",
          style: AppTextStyles.montserratMedium(16)
      ),
      const SizedBox(height: 15),
      SizedBox(
        height: MediaQuery.of(context).size.height / 3.2,
        child: Consumer<DashboardProvider>(
            builder: (context, cat, child) {
              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cat.categories?.categories?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3
                ), itemBuilder: (context, index) {
                return Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.secondary,
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                        cat.categories?.categories?[index].title ?? "",
                        style: AppTextStyles.montserratRegular(12)
                    ),
                  ),
                );
              },);
            }
        ),
      ),
    ];
  }
}