// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'jute.g.dart';

/// Model for nonwovan Bag
@JsonSerializable()
class Jute {
  String fabricPrice;
  String height;
  String width;
  String gsm;
  String gusset;
  String printColor;
  String gussetPrint;
  String zipper;
  String quanntity;
  String additioonalCost;
  String deliveryType;
  String homeDeliveryCost;
  String profit;
  String unitPrice;
  Jute({
    required this.fabricPrice,
    required this.height,
    required this.width,
    required this.gsm,
    required this.gusset,
    required this.printColor,
    required this.gussetPrint,
    required this.zipper,
    required this.quanntity,
    required this.additioonalCost,
    required this.deliveryType,
    required this.homeDeliveryCost,
    required this.profit,
    required this.unitPrice,
  });

  Jute copyWith({
    String? fabricPrice,
    String? height,
    String? width,
    String? gsm,
    String? gusset,
    String? printColor,
    String? gussetPrint,
    String? zipper,
    String? quanntity,
    String? additioonalCost,
    String? deliveryType,
    String? homeDeliveryCost,
    String? profit,
    String? unitPrice,
  }) {
    return Jute(
      fabricPrice: fabricPrice ?? this.fabricPrice,
      height: height ?? this.height,
      width: width ?? this.width,
      gsm: gsm ?? this.gsm,
      gusset: gusset ?? this.gusset,
      printColor: printColor ?? this.printColor,
      gussetPrint: gussetPrint ?? this.gussetPrint,
      zipper: zipper ?? this.zipper,
      quanntity: quanntity ?? this.quanntity,
      additioonalCost: additioonalCost ?? this.additioonalCost,
      deliveryType: deliveryType ?? this.deliveryType,
      homeDeliveryCost: homeDeliveryCost ?? this.homeDeliveryCost,
      profit: profit ?? this.profit,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  factory Jute.fromJson(Map<String, dynamic> json) => _$JuteFromJson(json);

  Map<String, dynamic> toJson() => _$JuteToJson(this);
}
