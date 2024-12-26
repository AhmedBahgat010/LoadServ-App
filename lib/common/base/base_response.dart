abstract class BaseResponse<T> {
  final int? status;
  final String? message;
  final T? data;

  BaseResponse({this.status, this.message, this.data});


  Map<String, dynamic> toJson();
}

class EmptyResponse extends BaseResponse<Nothing> {
  EmptyResponse({super.status, super.message, super.data});

  factory EmptyResponse.fromJson(Map<String, dynamic> json) => EmptyResponse(status: json["status"], message: json["message"]);

  @override
  Map<String, dynamic> toJson() => {"status": status, "message": message};
}

class Nothing{}
