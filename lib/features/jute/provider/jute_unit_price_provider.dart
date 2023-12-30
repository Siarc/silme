import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silme/features/jute/provider/jute_bag_provider.dart';
import 'package:silme/features/jute/provider/jute_delivery_type_provider.dart';
import 'package:silme/features/jute/provider/jute_zipper_provider.dart';
import 'package:silme/utils/local_keys.dart';

part 'jute_unit_price_provider.g.dart';

@riverpod
class JuteUnitPrice extends _$JuteUnitPrice {
  @override
  Future<String> build() async {
    final juteBag = ref.watch(juteBagProvider);
    final allowZipper = ref.watch(juteZipperProvider);
    final deliveryType = ref.watch(juteDeliveryTypeProvider);

    final bodyFabricPrice = double.tryParse(juteBag.bodyFabricPrice) ?? 0;
    final gussetFabricPrice = double.tryParse(juteBag.gussetFabricPrice) ?? 0;
    final usableBodyFabric = double.tryParse(juteBag.usableBodyFabric) ?? 0;
    final usableGussetFabric = double.tryParse(juteBag.usableGussetFabric) ?? 0;
    final height = double.tryParse(juteBag.height) ?? 0;
    final width = double.tryParse(juteBag.width) ?? 0;
    final handle = double.tryParse(juteBag.handle) ?? 0;
    final gusset = double.tryParse(juteBag.gusset) ?? 0;
    final jutePrint = double.tryParse(juteBag.print) ?? 0;
    final accessories = double.tryParse(juteBag.accessories) ?? 0;
    final quantity = double.tryParse(juteBag.quantity) ?? 0;
    final profit = double.tryParse(juteBag.profit) ?? 0;
    final homeDeliveryCost = double.tryParse(juteBag.homeDeliveryCost) ?? 0;
    const sampleCost = 1;
    const runner = 2.5;
    var cmCostAddition = 0;
    var zipperPricePerInch = 0.15;
    var deliveryCost = 0.0;

    if (deliveryType == 1) {
      deliveryCost = homeDeliveryCost / quantity;
    }
    if (allowZipper == 1) {
      zipperPricePerInch = 0.15;
    }
    print('Rony2 -> start');
    final bodyFabricPricePerInch = bodyFabricPrice / (usableBodyFabric * 36);
    print('Rony2 -> bodyFabricPricePerInch: $bodyFabricPricePerInch');

    final gussetFabricPricePerInch =
        gussetFabricPrice / (usableGussetFabric * 36);
    print('Rony2 -> gussetFabricPricePerInch: $gussetFabricPricePerInch');

    final jutebagBodyConsumption =
        (height + 1.5) * width * 2 + ((height + 1.5) * width * 2) * (5 / 100);
    print('Rony2 -> jutebagBodyConsumption: $jutebagBodyConsumption');

    final juteBagGussetConsumption = ((height + 1.5) * 2 + width) * gusset +
        (((height + 1.5) * 2 + width) * gusset) * (5 / 100);
    print('Rony2 -> juteBagGussetConsumption: $juteBagGussetConsumption');

    final zipperFabricConsumption =
        width * (gusset + 1) + (width * (gusset + 1)) * (5 / 100);
    print('Rony2 -> zipperFabricConsumption: $zipperFabricConsumption');

    final zipperConsumption = width + 3;
    print('Rony2 -> zipperConsumption: $zipperConsumption');

    final runnerZipperCost = (zipperConsumption * zipperPricePerInch) + runner;
    print('Rony2 -> runnerZipperCost: $runnerZipperCost');

    final bagFabricCost = (jutebagBodyConsumption + zipperFabricConsumption) *
            bodyFabricPricePerInch +
        juteBagGussetConsumption * gussetFabricPricePerInch;

    print('Rony2 -> bagFabricCost: $bagFabricCost');
    if (runnerZipperCost > 0) {
      cmCostAddition = 5;
    }
    print('Rony2 -> cmCostAddition: $cmCostAddition');
    final cmCost = 20 + cmCostAddition;
    print('Rony2 -> cmCost: $cmCost');

    final wastage = bagFabricCost * (1 / 100);
    print('Rony2 -> wastage: $wastage');
    final bagPrice = bagFabricCost +
        handle +
        cmCost +
        runnerZipperCost +
        sampleCost +
        jutePrint +
        accessories +
        wastage +
        profit +
        deliveryCost;
    print('Rony2 -> bagPrice: $bagPrice');
    print('Rony2 -> end');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      LocalKeys.juteModelState,
      jsonEncode(juteBag.toJson()),
    );

    return bagPrice.toStringAsFixed(4);
  }
}
