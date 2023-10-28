// ignore_for_file: public_member_api_docs, sort_constructors_first
/// Model for storing the local variable necessary for unit price calculation
class NonwovenUnitLocals {
  double heming;
  double handleFabric;
  double runner;
  double gussetPrint;
  double piping;
  double zipper;
  double fabricSqInch;
  NonwovenUnitLocals({
    required this.heming,
    required this.handleFabric,
    required this.runner,
    required this.gussetPrint,
    required this.piping,
    required this.zipper,
    required this.fabricSqInch,
  });

  NonwovenUnitLocals copyWith({
    double? heming,
    double? handleFabric,
    double? runner,
    double? gussetPrint,
    double? piping,
    double? zipper,
    double? fabricSqInch,
  }) {
    return NonwovenUnitLocals(
      heming: heming ?? this.heming,
      handleFabric: handleFabric ?? this.handleFabric,
      runner: runner ?? this.runner,
      gussetPrint: gussetPrint ?? this.gussetPrint,
      piping: piping ?? this.piping,
      zipper: zipper ?? this.zipper,
      fabricSqInch: fabricSqInch ?? this.fabricSqInch,
    );
  }
}
