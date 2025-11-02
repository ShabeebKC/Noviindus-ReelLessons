import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../../utils/utils.dart';
import '../../data/models/categories_reponse.dart';

class AddFeedProvider extends ChangeNotifier{
  final ImagePicker picker = ImagePicker();

  File? selectedVideo;
  File? selectedImage;
  List<Categories> selectedCategory = [];

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

  void addCategories(Categories? category){
    if(category == null) return;
    selectedCategory.add(category);
    notifyListeners();
  }

  void removeCategories(Categories? category){
    if(category == null) return;
    selectedCategory.removeWhere((element) => element == category);
    notifyListeners();
  }
}