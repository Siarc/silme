// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nonwoven.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nonwovan _$NonwovanFromJson(Map<String, dynamic> json) => Nonwovan(
      bagType: json['bagType'] as String,
      fabricPrice: (json['fabricPrice'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      gsm: (json['gsm'] as num).toDouble(),
      gusset: (json['gusset'] as num).toDouble(),
      printColor: json['printColor'] as String,
      gussetPrint: json['gussetPrint'] as bool,
      zipper: json['zipper'] as bool,
      quanntity: json['quanntity'] as int,
      additioonalCost: (json['additioonalCost'] as num).toDouble(),
      deliveryType: json['deliveryType'] as String,
      homeDeliveryCost: (json['homeDeliveryCost'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
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
