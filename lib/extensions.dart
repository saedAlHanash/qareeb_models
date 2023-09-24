import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qareeb_models/points/data/model/trip_point.dart';
import 'package:qareeb_models/redeems/data/response/redeems_response.dart';
import 'package:qareeb_models/shared_trip/data/response/shared_trip.dart';
import 'package:qareeb_models/trip_path/data/models/trip_path.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

import 'favorite_place/data/response/add_favorite_place_response.dart';
import 'global.dart';


extension Redeems on RedeemsResult {
  /// كم مرة يحق للسائق التبديل
  double get _oilCount =>
      ((km / systemParameters.oil) - (totals.oil / systemParameters.oil));

  /// كم مرة يحق للسائق التبديل
  double get _goldCount =>
      ((km / systemParameters.gold) - (totals.gold / systemParameters.gold));

  /// كم مرة يحق للسائق التبديل
  double get _tiresCount =>
      ((km / systemParameters.tire) - (totals.tire / systemParameters.tire));

  // كم مرة يحق لكن عدد صحيح
  int get oilCount => (_oilCount).floor();

  int get goldCount => (_goldCount).floor();

  int get tiresCount => (_tiresCount).floor();

  // كم مرة قام بالتبديل
  int get oilOldCount => (totals.oil / systemParameters.oil).floor();

  int get goldOldCount => (totals.gold / systemParameters.gold).floor();

  int get tiresOldCount => (totals.tire / systemParameters.tire).floor();

  double get oilPCount => double.parse((_oilCount * 100).toStringAsFixed(2));

  double get goldPCount => double.parse((_goldCount * 100).toStringAsFixed(2));

  double get tiresPCount => double.parse((_tiresCount * 100).toStringAsFixed(2));
}


extension PolylineExt on List<List<num>> {
  List<LatLng> unpackPolyline() =>
      map((p) => LatLng(p[0].toDouble(), p[1].toDouble())).toList();
}

extension SplitByLength on String {
  List<String> splitByLength1(int length, {bool ignoreEmpty = false}) {
    List<String> pieces = [];

    for (int i = 0; i < this.length; i += length) {
      int offset = i + length;
      var piece = substring(i, offset >= this.length ? this.length : offset);

      if (ignoreEmpty) {
        piece = piece.replaceAll(RegExp(r'\s+'), '');
      }

      pieces.add(piece);
    }
    return pieces;
  }

  bool get canSendToSearch {
    if (isEmpty) false;

    return split(' ').last.length > 2;
  }

  String get formatPrice => '${oCcy.format(this)}';

  String get removeSpace => replaceAll(' ', '');

  int get numberOnly {
    try {
      return int.parse(this);
    } on Exception {
      return 0;
    }
  }

  double get getCost {
    RegExp regExp = RegExp(r"(\d+\.\d+)");
    String? match = regExp.stringMatch(this);
    double number = double.parse(match ?? '0');
    return number;
  }

  String get removeDuplicates {
    List<String> words = split(' ');
    Set<String> uniqueWords = Set<String>.from(words);
    List<String> uniqueList = uniqueWords.toList();
    String output = uniqueList.join(' ');
    return output;
  }

}

extension StringHelper on String? {
  bool get isBlank {
    return this?.trim().isEmpty ?? true;
  }
}


final oCcy = NumberFormat("#,##0.00", "en_US");

extension MaxInt on num {
  int get maxInt => 2147483647;

  String get formatPrice => '${oCcy.format(this)}';

  int get myRound {
    if (toInt() < this) return toInt() + 1;
    return toInt();
  }
}

extension EnumSpinner on List<Enum> {
  List<SpinnerItem> spinnerItems({Enum? selected}) {
    return map((e) => SpinnerItem(
        name: e.arabicName,
        id: e.index,
        item: e,
        isSelected: e == selected)).toList();
  }
}

extension StateName on SharedTripStatus {
  String sharedTripName() {
    switch (this) {
      case SharedTripStatus.pending:
        return 'ابدأ الرحلة';

      case SharedTripStatus.started:
        return 'إنهاء الرحلة';

      case SharedTripStatus.closed:
        return '(رجوع)تم إنهاء الرحلة';

      case SharedTripStatus.canceled:
        return 'الرحلة ملغية';
    }
  }
}

extension NavTripHelper on NavTrip {
  double get maxBottomSheet {
    switch (this) {
      case NavTrip.waiting:
        return 0.1;

      case NavTrip.acceptor:
        return 0.4;

      case NavTrip.start:
        return 0.24;

      case NavTrip.end:
      case NavTrip.have:
        break;
    }
    return 0.5;
  }

  double get minBottomSheet {
    switch (this) {
      case NavTrip.waiting:
        return 0.1;

      case NavTrip.acceptor:
        return 0.2;

      case NavTrip.start:
        return 0.1;

      case NavTrip.end:
      case NavTrip.have:
        break;
    }
    return 0.2;
  }

  double get initBottomSheet {
    switch (this) {
      case NavTrip.waiting:
        return 0.1;
      case NavTrip.acceptor:
        return 0.2;
      case NavTrip.start:
        return 0.1;
      case NavTrip.end:
      case NavTrip.have:
        break;
    }
    return 0.3;
  }
}

extension PathMap on TripPath {
  List<LatLng> getPoints() {
    final list = <LatLng>[];

    edges.forEachIndexed((i, e) {
      if (i == 0) {
        list.add(e.startPoint.getLatLng);
      }
      list.add(e.endPoint.getLatLng);
    });

    return list;
  }

  List<String> get getPointsName {
    final list = <String>[];

    edges.forEachIndexed((i, e) {
      if (i == 0) {
        list.add(e.startPoint.arName);
      }
      list.add(e.endPoint.arName);
    });

    return list;
  }

  List<TripPoint> get getTripPoints {
    final list = <TripPoint>[];

    edges.forEachIndexed((i, e) {
      if (i == 0) {
        list.add(e.startPoint);
      }
      list.add(e.endPoint);
    });

    return list;
  }

  LatLng? get startPoint => edges.firstOrNull?.startPoint.getLatLng;

  List<SpinnerItem> get getPointsSpinner {
    final list = <SpinnerItem>[];

    edges.forEachIndexed((i, e) {
      if (i == 0) {
        list.add(SpinnerItem(
          id: e.startPoint.id,
          name: e.startPoint.arName,
          item: e,
        ));
      }
      list.add(SpinnerItem(
        id: e.endPoint.id,
        name: e.endPoint.arName,
        item: e,
      ));
    });

    return list;
  }
}

extension NormalTripMap on TripResult {
  LatLng get startPoint => currentLocation.latLng;

  LatLng get endPoint => destination.latLng;

  String get dateTrip {
    if (startDate != null) {
      return startDate!.formatFullDate;
    } else if (endDate != null) {
      return endDate!.formatFullDate;
    }
    return 'لم تبدأ';
  }

  String get tripStateName {
    //غير موجودة أو منتهية
    if (isCanceled) return 'ملغية';

    //final
    if (isDelved) return 'مكتملة';
    //بدأت
    if (isStarted || isConfirmed) return 'جارية';

    //تم تأكيدها
    if (isConfirmed) return 'بحث عن سائق';

    return 'حالة غير معروفة';
  }

  NavTrip? get tripStateEnum {
    //غير موجودة أو منتهية
    if (isCanceled) return null;

    //final
    if (isDelved) return NavTrip.end;
    //بدأت
    if (isStarted || isConfirmed) return NavTrip.start;

    //تم تأكيدها
    if (isConfirmed) return NavTrip.waiting;

    return NavTrip.have;
  }

  String get getDuration {
    return ' ${duration.numberOnly ~/ 60} دقيقة';
  }
}

extension SharedRequestMap on SharedTrip {
  int nou(LatLng point) {
    for (var e in sharedRequests) {
      if (e.status == SharedRequestStatus.pending) return 0;
      if (e.pickupPoint.getLatLng.hashCode == point.hashCode) return e.seatNumber;
    }
    return 0;
  }

  bool get isStart => startDate != null;

  bool get isEnd => endDate != null;

  String get dateTrip {
    if (isStart) {
      return startDate!.formatFullDate;
    } else if (isEnd) {
      return 'منتهية:  ${endDate!.formatFullDate}';
    }
    return schedulingDate?.formatFullDate ?? '';
  }

  List<SpinnerItem> availableRequest() {
    var s = <SpinnerItem>[];
    var a = seatNumber - sharedRequests.length;
    for (var i = 1; i <= a; i++) {
      s.add(SpinnerItem(id: i, name: i.toString()));
    }
    return s;
  }
}

extension SharedRequestHelper on SharedRequest {
  String get cost => '$amount spy';
}

extension CubitStateHelper on CubitStatuses {
  bool get isLoading => this == CubitStatuses.loading;

  bool get isDone => this == CubitStatuses.done;
}

extension TripPointHelper on TripPoint {
  LatLng get getLatLng => LatLng(lat, lng);
}

extension FirstItem<E> on Iterable<E> {
  E? firstItem() {
    if (isEmpty) {
      return null;
    } else {
      return first;
    }
  }

  E? lastItem() {
    if (isEmpty) {
      return null;
    } else {
      return last;
    }
  }
}

extension GetDateTimesBetween on DateTime {
  List<DateTime> getDateTimesBetween({
    required DateTime end,
    required Duration period,
  }) {
    var dateTimes = <DateTime>[];
    var current = add(period);
    while (current.isBefore(end)) {
      if (dateTimes.length > 24) {
        break;
      }
      dateTimes.add(current);
      current = current.add(period);
    }
    return dateTimes;
  }
}

extension DateUtcHelper on DateTime {
  int get hashDate => (day * 61) + (month * 83) + (year * 23);

  DateTime get getUtc => DateTime.utc(year, month, day);

  String get formatDate => DateFormat.yMd().format(this);

  String get formatTime {
    var t = DateFormat('h:mm a').format(this);

    return t.replaceAll('PM', 'م').replaceAll('AM', 'ص');
  }

  String get formatDateTime => '$formatDate $formatTime';

  String get formatFullDate => '$formatDayName  $formatDate  $formatTime';

  String get formatDayName {
    initializeDateFormatting();
    return DateFormat('EEEE', 'ar_SA').format(this);
  }

  DateTime addFromNow({int? year, int? month, int? day}) {
    return DateTime(
        this.year + (year ?? 0), this.month + (month ?? 0), this.day + (day ?? 0));
  }

  DateTime initialFromDateTime({required DateTime date, required TimeOfDay time}) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  String get formatDateAther => DateFormat('yyyy/MM/dd HH:MM').format(this);
}

extension ScrollMax on ScrollController {
  bool get isMax => position.maxScrollExtent == offset;

  bool get isMin => offset == 0;
}

extension FavoritePlaceResultHelper on FavoritePlaceResult {
  LatLng get latLng => LatLng(lat, lng);
}

extension RealName on Enum {
  String get upperFirst => name.replaceRange(0, 1, name.substring(0, 1).toUpperCase());

  String get arabicName {
    if (this is WeekDays) {
      switch (this) {
        case WeekDays.sunday:
          return 'أحد';
        case WeekDays.monday:
          return 'إثنين';
        case WeekDays.tuesday:
          return 'ثلاثاء';
        case WeekDays.wednesday:
          return 'أربعاء';
        case WeekDays.thursday:
          return 'خميس';
        case WeekDays.friday:
          return 'جمعة';
        case WeekDays.saturday:
          return 'سبت';
      }
    }

    if (this is NavTrip) {
      switch (this) {
        case NavTrip.waiting:
          return 'جاري البحث عن سائق';
        case NavTrip.acceptor:
          return 'جارية';
        case NavTrip.start:
          return 'بدأت بالفعل';
        case NavTrip.end:
          return 'منتهية';
      }
    }

    if (this is MemberSubscriptionState) {
      switch (this) {
        case MemberSubscriptionState.notSubscribe:
          return 'غير مشترك';
        case MemberSubscriptionState.active:
          return 'الاشتراك فعال';
        case MemberSubscriptionState.expired:
          return 'اشتراك منتهي الصلاحية';
      }
    }

    if (this is Gender) {
      switch (this) {
        case Gender.mail:
          return 'ذكر';
        case Gender.female:
          return 'انثي';
      }
    }

    if (this is RedeemType) {
      switch (this) {
        case RedeemType.gold:
          return 'المليون';
        case RedeemType.oil:
          return 'زيت';
        case RedeemType.tire:
          return 'إطارات';
      }
    }

    if (this is TransferType) {
      switch (this) {
        case TransferType.sharedPay:
          return 'تحويل لرحلة تشاركية';
        case TransferType.tripPay:
          return 'تحويل لرحلة عادية';
        case TransferType.payoff:
          return 'دفعة من السائق للشركة';
        case TransferType.debit:
          return 'دفعة من الشركة للسائق';
        case TransferType.award:
          return 'مكافئة';
      }
    }

    if (this is SummaryPayToEnum) {
      switch (this) {
        case SummaryPayToEnum.requiredFromDriver:
          return 'السائق يجب أن يدفع للشركة';
        case SummaryPayToEnum.requiredFromCompany:
          return 'الشركة يجب انت تدفع للسائق';
        case SummaryPayToEnum.equal:
          return 'الرصيد متكافئ';
      }
    }

    if (this is UserType) {
      switch (this) {
        case UserType.client:
          return 'زبون';
        case UserType.driver:
          return 'سائق';
        case UserType.admin:
          return 'مدير نظام';
        case UserType.institutionAdmin:
          return 'مدير مؤسسة';
      }
    }

    if (this is InstitutionType) {
      switch (this) {
        case InstitutionType.school:
          return 'مدرسة';
        case InstitutionType.college:
          return 'جامعة';
        case InstitutionType.transportation:
          return 'نقل';
      }
    }

    if (this is BusTripType) {
      switch (this) {
        case BusTripType.go:
          return 'ذهاب';
        case BusTripType.back:
          return 'إياب';
      }
    }

    if (this is TransferPayType) {
      switch (this) {
        case TransferPayType.driverToCompany:
          return 'من السائق للشركة';
        case TransferPayType.companyToDriver:
          return 'من الشركة للسائق';
      }
    }

    if (this is SharedRequestStatus) {
      switch (this) {
        case SharedRequestStatus.pending:
          return 'لم تبدأ';
        case SharedRequestStatus.accepted:
          return 'تم قبولها';
        case SharedRequestStatus.payed:
          return 'تم الدفع';
        case SharedRequestStatus.pickedup:
          return 'تم الركوب';
        case SharedRequestStatus.dropped:
          return 'تم النزول';
        case SharedRequestStatus.closed:
          return 'مكتملة';
      }
    }

    if (this is SharedTripStatus) {
      switch (this) {
        case SharedTripStatus.pending:
          return 'في الانتظار';
        case SharedTripStatus.started:
          return 'جارية';
        case SharedTripStatus.closed:
          return 'منتهية';
        case SharedTripStatus.canceled:
          return 'ملغية';
      }
    }
    if (this is InstitutionType) {
      switch (this) {
        case InstitutionType.school:
          return '';
        case InstitutionType.college:
          return '';
        case InstitutionType.transportation:
          return '';
      }
    }

    return name;
  }

  bool get isTripActive {
    switch (this) {
      case NavTrip.waiting:
        return true;
      case NavTrip.acceptor:
        return true;
      case NavTrip.start:
        return true;
      case NavTrip.end:
        return false;
    }
    return false;
  }
}
