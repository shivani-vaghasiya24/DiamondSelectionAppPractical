import 'package:hive/hive.dart';
part 'diamond_model.g.dart';

@HiveType(typeId: 0)
class Diamond {
  @HiveField(0)
  final String lotId;

  @HiveField(1)
  final double size;

  @HiveField(2)
  final double carat;

  @HiveField(3)
  final String lab;

  @HiveField(4)
  final String shape;

  @HiveField(5)
  final String color;

  @HiveField(6)
  final String clarity;

  @HiveField(7)
  final String cut;

  @HiveField(8)
  final String polish;

  @HiveField(9)
  final String symmetry;

  @HiveField(10)
  final String fluorescence;

  @HiveField(11)
  final double discount;

  @HiveField(12)
  final double perCaratRate;

  @HiveField(13)
  final String keyToSymbol;

  @HiveField(14)
  final String labComment;
  // final String lotId;
  // final double size;
  // final double carat;
  // final String lab;
  // final String shape;
  // final String color;
  // final String clarity;
  // final String cut;
  // final String polish;
  // final String symmetry;
  // final String fluorescence;
  // final double discount;
  // final double perCaratRate;
  // // final double finalAmount;
  // final String keyToSymbol;
  // final String labComment;

  Diamond({
    required this.lotId,
    required this.size,
    required this.carat,
    required this.lab,
    required this.shape,
    required this.color,
    required this.clarity,
    required this.cut,
    required this.polish,
    required this.symmetry,
    required this.fluorescence,
    required this.discount,
    required this.perCaratRate,
    // required this.finalAmount,
    required this.keyToSymbol,
    required this.labComment,
  });

  /// Calculate Final Amount dynamically
  double get finalAmount {
    return carat * perCaratRate;
    // return carat * perCaratRate * (1 + (discount / 100));
  }

  // Convert Map to Diamond model (Handles TextCellValue issues)
  factory Diamond.fromMap(Map<String, dynamic> map) {
    return Diamond(
      lotId: map['Lot ID']?.toString() ?? '',
      size: double.tryParse(map['Size']?.toString() ?? '0') ?? 0.0,
      carat: double.tryParse(map['Carat']?.toString() ?? '0') ?? 0.0,
      lab: map['Lab']?.toString() ?? '',
      shape: map['Shape']?.toString() ?? '',
      color: map['Color']?.toString() ?? '',
      clarity: map['Clarity']?.toString() ?? '',
      cut: map['Cut']?.toString() ?? '',
      polish: map['Polish']?.toString() ?? '',
      symmetry: map['Symmetry']?.toString() ?? '',
      fluorescence: map['Fluorescence']?.toString() ?? '',
      discount: double.tryParse(map['Discount']?.toString() ?? '0') ?? 0.0,
      perCaratRate:
          double.tryParse(map['Per Carat Rate']?.toString() ?? '0') ?? 0.0,
      // finalAmount:
      //     double.tryParse(map['Final Amount']?.toString() ?? '0') ?? 0.0,
      keyToSymbol: map['Key To Symbol']?.toString() ?? '',
      labComment: map['Lab Comment']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Lot ID': lotId,
      'Size': size,
      'Carat': carat,
      'Lab': lab,
      'Shape': shape,
      'Color': color,
      'Clarity': clarity,
      'Cut': cut,
      'Polish': polish,
      'Symmetry': symmetry,
      'Fluorescence': fluorescence,
      'Discount': discount,
      'Per Carat Rate': perCaratRate,
      'Final Amount': finalAmount,
      'Key To Symbol': keyToSymbol,
      'Lab Comment': labComment,
    };
  }
}
