import 'package:qareeb_models/global.dart';

class InstitutionResponse {
  InstitutionResponse({
    required this.result,
  });

  final InstitutionModel result;

  factory InstitutionResponse.fromJson(Map<String, dynamic> json) {
    return InstitutionResponse(
      result: InstitutionModel.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class InstitutionsResponse {
  InstitutionsResponse({
    required this.result,
  });

  final InstitutionsResult result;

  factory InstitutionsResponse.fromJson(Map<String, dynamic> json) {
    return InstitutionsResponse(
      result: InstitutionsResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class InstitutionsResult {
  InstitutionsResult({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<InstitutionModel> items;

  factory InstitutionsResult.fromJson(Map<String, dynamic> json) {
    return InstitutionsResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<InstitutionModel>.from(
              json["items"]!.map((x) => InstitutionModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class InstitutionModel {
  InstitutionModel({
    required this.id,
    required this.name,
    required this.government,
    required this.type,
    required this.imageUrl,
    required this.atharKey,
    required this.isActive,
  });

  final int id;
  final String name;
  final int government;
  final InstitutionType type;
  final String imageUrl;
  final String atharKey;
  final bool isActive;

  factory InstitutionModel.fromJson(Map<String, dynamic> json) {
    return InstitutionModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      government: json["government"] ?? 0,
      type: InstitutionType.values[json["type"] ?? 0],
      imageUrl: FixUrl.fixAvatarImage(json["imageUrl"]),
      atharKey: json["atharKey"] ?? "",
      isActive: json["isActive"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "government": government,
        "type": type.index,
        "imageUrl": imageUrl,
        "atharKey": atharKey,
        "isActive": isActive,
      };
}
