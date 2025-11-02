class AddFeedResponse {
  String? message;
  bool? status;

  AddFeedResponse({this.message, this.status});

  AddFeedResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }
}