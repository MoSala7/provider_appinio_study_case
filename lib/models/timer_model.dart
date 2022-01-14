// ignore_for_file: non_constant_identifier_names

class TimerModel {
  late String product;
  late String init;
  late List<Dataseries> dataseries;

  TimerModel({
    required this.product,
    required this.init,
    required this.dataseries,
  });

  factory TimerModel.fromJson(dynamic json) {
    return TimerModel(
      product: json["product"] as String,
      init: json["init"] as String,
      dataseries: (json['dataseries'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((item) => Dataseries.fromJson(item))
          .toList(),
    );
  }
}

class Dataseries {
  late int timepoint;
  late int cloudcover;
  late int seeing;
  late int transparency;
  late int lifted_index;
  late int rh2m;
  late dynamic wind10m;
  late int temp2m;
  late String prec_type;

  Dataseries({
    required this.timepoint,
    required this.cloudcover,
    required this.seeing,
    required this.transparency,
    required this.lifted_index,
    required this.rh2m,
    required this.wind10m,
    required this.temp2m,
    required this.prec_type,
  });

  factory Dataseries.fromJson(dynamic json) {
    return Dataseries(
      timepoint: json["timepoint"] as int,
      cloudcover: json["cloudcover"] as int,
      seeing: json["seeing"] as int,
      transparency: json["transparency"] as int,
      lifted_index: json["lifted_index"] as int,
      rh2m: json["rh2m"] as int,
      wind10m: json['wind10m'],
      temp2m: json["temp2m"] as int,
      prec_type: json["prec_type"] as String,
    );
  }
}

class Wind10m {
  late String direction;
  late int speed;

  Wind10m({
    required this.direction,
    required this.speed,
  });

  factory Wind10m.fromJson(dynamic json) {
    return Wind10m(
      direction: json["direction"] as String,
      speed: json["speed"] as int,
    );
  }
}
