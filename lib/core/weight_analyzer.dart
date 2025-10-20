class WeightResult {
  final String status; // GAINED, LOST, NO CHANGE
  final double kilos;
  final double average;

  const WeightResult({
    required this.status,
    required this.kilos,
    required this.average,
  });
}

class WeightAnalyzer {
  static const int scalesCount = 10;

  static double average(List<double> values) {
    if (values.isEmpty) return 0;
    final sum = values.fold<double>(0, (a, b) => a + b);
    return sum / values.length;
  }

  static WeightResult analyze({
    required double lastWeight,
    required List<double> readings,
  }) {
    final avg = average(readings);
    final diff = avg - lastWeight;
    String status;
    if (diff > 0) {
      status = 'GAINED';
    } else if (diff < 0) {
      status = 'LOST';
    } else {
      status = 'NO CHANGE';
    }
    return WeightResult(status: status, kilos: diff.abs(), average: avg);
  }
}
