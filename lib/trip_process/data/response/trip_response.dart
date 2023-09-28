import '../../../shared_trip/data/response/shared_trip.dart';

import '../shared/location_model.dart';

class TripResponse {
  TripResponse({required this.result});

  final TripResult result;

  factory TripResponse.fromJson(Map<String, dynamic> json) {
    return TripResponse(
      result: TripResult.fromJson(json['result'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'result': result.toJson(),
      };
}

class TripResult {
  TripResult({
    required this.id,
    required this.clientId,
    required this.driverId,
    required this.startDate,
    required this.endDate,
    required this.tripType,
    required this.currentLocationName,
    required this.destinationName,
    required this.duration,
    required this.isStarted,
    required this.currentLocation,
    required this.destination,
    required this.isAccepted,
    required this.note,
    required this.distance,
    required this.tripTimeDate,
    required this.tripTime,
    required this.tripFare,
    required this.paidAmount,
    required this.clientPhoneNumber,
    required this.isDelved,
    required this.isCanceled,
    required this.cancelReason,
    required this.driverName,
    required this.clientName,
    required this.PreAcceptPath,
    required this.creationTime,
    required this.isConfirmed,
    required this.isActive,
    required this.isPaid,
    required this.clientRate,
    required this.driverRate,
    required this.isClientRated,
    required this.isDriverRated,
    required this.carCategoryId,
    required this.carType,
    required this.coupons,
    required this.couponsId,
    required this.preAcceptDistance,
    required this.driver,
  });

  final int id;
  final int clientId;
  int driverId;
  final DateTime? startDate;
  final DateTime? endDate;
  final int tripType;
  final String currentLocationName;
  final String destinationName;
  final String duration;
  bool isStarted;
  final LocationModel currentLocation;
  final LocationModel destination;
  bool isAccepted;
  final String note;
  final double distance;
  final DateTime? tripTimeDate;
  final String tripTime;
  final double tripFare;
  final double paidAmount;
  final String clientPhoneNumber;
  bool isDelved;
  bool isCanceled;
  final String cancelReason;
  String driverName;
  final String clientName;
  final String PreAcceptPath;
  final DateTime? creationTime;
  bool isConfirmed;
  bool isActive;
  bool isPaid;
  final double clientRate;
  double driverRate;
  bool isClientRated;
  bool isDriverRated;
  final int carCategoryId;

  final CarType carType;
  final Coupons coupons;
  final int couponsId;
  final int preAcceptDistance;
  final Driver driver;

  factory TripResult.fromJson(Map<String, dynamic> json) {
    return TripResult(
      id: json['id'] ?? 0,
      clientId: json['clientId'] ?? 0,
      driverId: json['driverId'] ?? 0,
      startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
      endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
      tripType: json['tripType'] ?? 0,
      currentLocationName: json['currentLocation_name'] ?? '',
      destinationName: json['distnation_name'] ?? '',
      duration: json['duration'] ?? '',
      isStarted: json['isStarted'] ?? false,
      currentLocation: LocationModel.fromJson(json['currentLocation'] ?? {}),
      destination: LocationModel.fromJson(json['distnation'] ?? {}),
      isAccepted: json['isAccepted'] ?? false,
      note: json['note'] ?? '',
      distance: json['distance'] ?? 0,
      tripTimeDate:
          json['tripTimeDate'] == null ? null : DateTime.parse(json['tripTimeDate']),
      tripTime: json['tripTime'] ?? '',
      tripFare: json['tripFare'] ?? 0,
      paidAmount: json['paidAmount'] ?? 0,
      clientPhoneNumber: json['client_PhoneNumber'] ?? '',
      isDelved: json['isDilverd'] ?? false,
      isCanceled: json['isCanceled'] ?? false,
      cancelReason: json['cancelReasone'] ?? '',
      driverName: json['driverName'] ?? '',
      clientName: json['clietName'] ?? '',
      PreAcceptPath: json['PreAcceptPath'] ?? '',
      creationTime:
          json['creationTime'] == null ? null : DateTime.parse(json['creationTime']),
      isConfirmed: json['isConfirmed'] ?? false,
      isActive: json['isActive'] ?? false,
      isPaid: json['isPaid'] ?? false,
      clientRate: json['clientRate'] ?? 0,
      driverRate: json['driverRate'] ?? 0,
      isClientRated: json['isClientRated'] ?? false,
      isDriverRated: json['isDriverRated'] ?? false,
      carCategoryId: json['carCategoryId'] ?? 0,
      carType: CarType.fromJson(json['carType'] ?? {}),
      coupons: json['coupons'] == null
          ? Coupons.fromJson({})
          : Coupons.fromJson(json['coupons']),
      couponsId: json['couponsId'] ?? 0,
      preAcceptDistance: json['preAcceptDistance'] ?? 0,
      driver: Driver.fromJson(json["driver"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'clientId': clientId,
        'driverId': driverId,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'tripType': tripType,
        'currentLocation_name': currentLocationName,
        'distnation_name': destinationName,
        'duration': duration,
        'isStarted': isStarted,
        'currentLocation': currentLocation.toJson(),
        'distnation': destination.toJson(),
        'isAccepted': isAccepted,
        'note': note,
        'distance': distance,
        'tripTimeDate': tripTimeDate?.toIso8601String(),
        'tripTime': tripTime,
        'tripFare': tripFare,
        'paidAmount': paidAmount,
        'client_PhoneNumber': clientPhoneNumber,
        'isDilverd': isDelved,
        'isCanceled': isCanceled,
        'cancelReasone': cancelReason,
        'driverName': driverName,
        'clietName': clientName,
        'PreAcceptPath': PreAcceptPath,
        'creationTime': creationTime?.toIso8601String(),
        'isConfirmed': isConfirmed,
        'isActive': isActive,
        'isPaid': isPaid,
        'clientRate': clientRate,
        'driverRate': driverRate,
        'isClientRated': isClientRated,
        'isDriverRated': isDriverRated,
        'carCategoryId': carCategoryId,
        'carType': carType.toJson(),
        'coupons': coupons.toJson(),
        'couponsId': couponsId,
        'preAcceptDistance': preAcceptDistance,
        "driver": driver.toJson(),
      };
}

class Coupons {
  Coupons({
    required this.id,
    required this.couponName,
    required this.couponCode,
    required this.discountValue,
    required this.isActive,
    required this.expireDate,
  });

  final num id;
  final String couponName;
  final String couponCode;
  final num discountValue;
  final bool isActive;
  final DateTime? expireDate;

  factory Coupons.fromJson(Map<String, dynamic> json) {
    return Coupons(
      id: json['id'] ?? 0,
      couponName: json['couponName'] ?? '',
      couponCode: json['couponCode'] ?? '',
      discountValue: json['discountValue'] ?? 0,
      isActive: json['isActive'] ?? false,
      expireDate: json['expireDate'] == null ? null : DateTime.parse(json['expireDate']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'couponName': couponName,
        'couponCode': couponCode,
        'discountValue': discountValue,
        'isActive': isActive,
        'expireDate': expireDate?.toIso8601String(),
      };
}
