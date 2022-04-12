class HTTPResponse {
  HTTPResponse({required this.isError, this.errorData, this.data});

  bool isError = false;
  Map? errorData = {"message": String, "statusCode": int};
  dynamic data;

  factory HTTPResponse.success(data) =>
      HTTPResponse(isError: false, data: data);

  factory HTTPResponse.apiError(message, statuscode) => HTTPResponse(
      isError: true, errorData: {"message": message, "statusCode": statuscode});

  factory HTTPResponse.networkError() => HTTPResponse(
      isError: true, errorData: {"message": '네트워크 오류입니다', "statusCode": 59});

  factory HTTPResponse.serverError() => HTTPResponse(
      isError: true, errorData: {"message": '서버 오류입니다', "statusCode": 500});

  factory HTTPResponse.unexpectedError(e) =>
      HTTPResponse(isError: true, errorData: {"message": e, "statusCode": 500});
}
