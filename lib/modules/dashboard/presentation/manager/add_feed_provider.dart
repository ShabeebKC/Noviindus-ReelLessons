import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reel_lessons/modules/dashboard/domain/use_cases/dashboard_usecase.dart';
import 'package:video_player/video_player.dart';
import '../../../../utils/utils.dart';

class AddFeedProvider extends ChangeNotifier{
  final DashboardUseCase useCase;
  AddFeedProvider(this.useCase);

  final ImagePicker picker = ImagePicker();

  File? selectedVideo;
  File? selectedImage;
  List<int> selectedCategory = [];
  bool isLoading = false;

  Future<void> pickVideo(BuildContext context) async {
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      final video = File(pickedVideo.path);
      if (!pickedVideo.path.endsWith(".mp4")) {
        Utils.showInSnackBar(context, "Only MP4 videos are allowed.");
        return;
      }

      final controller = VideoPlayerController.file(video);
      await controller.initialize();
      final duration = controller.value.duration;
      if (duration.inMinutes > 5) {
        Utils.showInSnackBar(context, "Video cannot exceed 5 minutes.");
        return;
      }
      selectedVideo = video;
      notifyListeners();
    }
  }

  Future<void> pickThumbnail() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImage = File(pickedImage.path);
      notifyListeners();
    }
  }

  void addCategories(int? id){
    if(id == null) return;
    selectedCategory.add(id);
    notifyListeners();
  }

  void removeCategories(int? category){
    if(category == null) return;
    selectedCategory.removeWhere((element) => element == category);
    notifyListeners();
  }

  Future<String> uploadFeed(String desc,) async {
    isLoading = true;
    notifyListeners();
    if(selectedVideo == null || selectedImage == null){
      return "No Video or Thumbnail is Selected";
    }

    final response = await useCase.uploadFeed(selectedVideo!, selectedImage!, desc, selectedCategory);
    isLoading = false;
    notifyListeners();
    if(!response) return "Failed to Upload";
    return "Feed Uploaded Successfully";
  }
}