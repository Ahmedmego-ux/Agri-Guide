class SoilEstimator {
  static Map<String, dynamic> estimate({
    required double temperature,
    required double soilMoisture,
    required double rainChance,
  }) {

    int n =
        ((soilMoisture * 1.5) + (rainChance * 0.5)).round();

    int p =
        ((temperature * 1.2) + 20).round();

    int k =
        ((soilMoisture * 0.8) + (temperature * 0.6)).round();

    double ph = 6.5;

    return {
      "N": n.clamp(0, 140),
      "P": p.clamp(0, 140),
      "K": k.clamp(0, 140),
      "ph": ph,
    };
  }
}