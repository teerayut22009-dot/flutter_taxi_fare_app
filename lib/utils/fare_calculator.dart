
class FareCalculator {
 static double calculate(double kilometers, int trafficMinutes) {
    if (!kilometers.isFinite || kilometers <= 0) {
      throw ArgumentError('ระยะทางต้องมากกว่า 0');
    }
    if (trafficMinutes < 0) {
      throw ArgumentError('เวลารถติดต้องไม่ติดลบ');
    }

    double total = 35;
    total += _rate(kilometers, 1, 10, 6.50);
    total += _rate(kilometers, 10, 20, 7.00);
    total += _rate(kilometers, 20, 40, 8.00);
    total += _rate(kilometers, 40, 60, 8.50);
    total += _rate(kilometers, 60, 80, 9.00);
    total += _rate(kilometers, 80, double.infinity, 10.50);
    total += trafficMinutes * 3.00;
    return total;
  }

  static double _rate(double km, double from, double to, double baht) {
    if (km <= from) return 0;
    final end = km < to ? km : to;
    return (end - from) * baht;
  }
}
