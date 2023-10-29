// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nonwoven.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nonwovan _$NonwovanFromJson(Map<String, dynamic> json) => Nonwovan(
      bagType: json['bagType'] as String,
      fabricPrice: json['fabricPrice'] as String,
      height: json['height'] as String,
      width: json['width'] as String,
      gsm: json['gsm'] as String,
      gusset: json['gusset'] as String,
      printColor: json['printColor'] as String,
      gussetPrint: json['gussetPrint'] as bool,
      zipper: json['zipper'] as bool,
      quanntity: json['quanntity'] as String,
      additioonalCost: json['additioonalCost'] as String,
      deliveryType: json['deliveryType'] as String,
      homeDeliveryCost: json['homeDeliveryCost'] as String,
      profit: json['profit'] as String,
      unitPrice: json['unitPrice'] as String,
    );

Map<String, dynamic> _$NonwovanToJson(Nonwovan instance) => <String, dynamic>{
      'bagType': instance.bagType,
      'fabricPrice': instance.fabricPrice,
      'height': instance.height,
      'width': instance.width,
      'gsm': instance.gsm,
      'gusset': instance.gusset,
      'printColor': instance.printColor,
      'gussetPrint': instance.gussetPrint,
      'zipper': instance.zipper,
      'quanntity': instance.quanntity,
      'additioonalCost': instance.additioonalCost,
      'deliveryType': instance.deliveryType,
      'homeDeliveryCost': instance.homeDeliveryCost,
      'profit': instance.profit,
      'unitPrice': instance.unitPrice,
    };
