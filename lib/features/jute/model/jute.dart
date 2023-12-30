// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'jute.g.dart';

/// Model for nonwovan Bag
@JsonSerializable()
class Jute {
  String bodyFabricPrice;
  String gussetFabricPrice;
  String usableBodyFabric;
  String usableGussetFabric;
  String height;
  String width;
  String handle;
  String gusset;
  String print;
  String accessories;
  String quantity;
  String profit;
  String zipper;
  String deliveryType;
  String homeDeliveryCost;
  String unitPrice;
  Jute({
    required this.bodyFabricPrice,
    required this.gussetFabricPrice,
    required this.usableBodyFabric,
    required this.usableGussetFabric,
    required this.height,
    required this.width,
    required this.handle,
    required this.gusset,
    required this.print,
    required this.accessories,
    required this.quantity,
    required this.profit,
    required this.zipper,
    required this.deliveryType,
    required this.homeDeliveryCost,
    required this.unitPrice,
  });

  Jute copyWith({
    String? bodyFabricPrice,
    String? gussetFabricPrice,
    String? usableBodyFabric,
    String? usableGussetFabric,
    String? height,
    String? width,
    String? handle,
    String? gusset,
    String? print,
    String? accessories,
    String? quantity,
    String? profit,
    String? zipper,
    String? deliveryType,
    String? homeDeliveryCost,
    String? unitPrice,
  }) {
    return Jute(
      bodyFabricPrice: bodyFabricPrice ?? this.bodyFabricPrice,
      gussetFabricPrice: gussetFabricPrice ?? this.gussetFabricPrice,
      usableBodyFabric: usableBodyFabric ?? this.usableBodyFabric,
      usableGussetFabric: usableGussetFabric ?? this.usableGussetFabric,
      height: height ?? this.height,
      width: width ?? this.width,
      handle: handle ?? this.handle,
      gusset: gusset ?? this.gusset,
      print: print ?? this.print,
      accessories: accessories ?? this.accessories,
      quantity: quantity ?? this.quantity,
      profit: profit ?? this.profit,
      zipper: zipper ?? this.zipper,
      deliveryType: deliveryType ?? this.deliveryType,
      homeDeliveryCost: homeDeliveryCost ?? this.homeDeliveryCost,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  factory Jute.fromJson(Map<String, dynamic> json) => _$JuteFromJson(json);

  Map<String, dynamic> toJson() => _$JuteToJson(this);
}
