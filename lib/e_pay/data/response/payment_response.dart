class PaymentResponse {
  PaymentResponse({
    required this.result,
  });

  final PaymentResult result;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      result: PaymentResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class PaymentResult {
  PaymentResult({
    required this.statusCode,
    required this.data,
    required this.error,
  });

  final int statusCode;
  final Data data;
  final String error;

  factory PaymentResult.fromJson(Map<String, dynamic> json) {
    return PaymentResult(
      statusCode: json["statusCode"] ?? 0,
      data: Data.fromJson(json["data"] ?? {}),
      error: json["error"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data.toJson(),
        "error": error,
      };
}

class Data {
  Data({
    required this.url,
    required this.processId,
    required this.operationNumber,
    required this.guid,
  });

  final String url;
  final String processId;
  final String operationNumber;
  final String guid;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      url: json["url"] ?? "",
      operationNumber: json["operationNumber"] ?? "",
      guid: json["guid"] ?? "",
      processId: json["processId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "operationNumber": operationNumber,
        "guid": guid,
      };
}
