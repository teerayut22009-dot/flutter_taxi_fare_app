import 'package:flutter/material.dart';
import '../utils/fare_calculator.dart';

class TaxiFareUi extends StatefulWidget {
  const TaxiFareUi({super.key});

  @override
  State<TaxiFareUi> createState() => _TaxiFareUiState();
}

class _TaxiFareUiState extends State<TaxiFareUi> {
  final _distanceController = TextEditingController();
  final _trafficController = TextEditingController();

  double _fare = 0;
  String? _error;

  @override
  void dispose() {
    _distanceController.dispose();
    _trafficController.dispose();
    super.dispose();
  }

  void _calculate() {
    FocusScope.of(context).unfocus();
    final distanceText = _distanceController.text.trim();
    final trafficText = _trafficController.text.trim();

    if (distanceText.isEmpty || trafficText.isEmpty) {
      setState(() {
        _fare = 0;
        _error = 'กรุณากรอกข้อมูลให้ครบถ้วน';
      });
      return;
    }

    final distance = double.tryParse(distanceText);
    final minutes = int.tryParse(trafficText);
    if (distance == null || minutes == null) {
      setState(() {
        _fare = 0;
        _error = 'กรุณากรอกตัวเลขให้ถูกต้อง';
      });
      return;
    }
    if (!distance.isFinite || distance <= 0 || minutes < 0) {
      setState(() {
        _fare = 0;
        _error = 'ระยะทางต้องมากกว่า 0 และเวลารถติดห้ามติดลบ';
      });
      return;
    }

    setState(() {
      _fare = FareCalculator.calculate(distance, minutes);
      _error = null;
    });
  }

  void _clear() {
    FocusScope.of(context).unfocus();
    _distanceController.clear();
    _trafficController.clear();
    setState(() {
      _fare = 0;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxi Fare'),
        toolbarHeight: 52,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/taxi_location.png',
                      width: 190,
                      height: 220,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'คำนวณค่าโดยสารแท็กซี่',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF181818),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'ระยะทาง (กิโลเมตร) ',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 7),
                  _field(
                    _distanceController,
                    'กรุณากรอกระยะทาง',
                    const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'เวลารถติด (นาที) ',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 7),
                  _field(
                    _trafficController,
                    'กรุณากรอกเวลารถติด',
                    TextInputType.number,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFFFFBC00),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: const Text('คำนวณค่าโดยสาร', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _clear,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF9A9A9A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: const Text('ยกเลิก', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 23),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFECB4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text('ค่าโดยสารแท็กซี่', style: TextStyle(fontSize: 13)),
                        const SizedBox(height: 6),
                        Text(
                          _fare.toStringAsFixed(2),
                          key: const Key('fareResult'),
                          style: const TextStyle(
                            color: Color(0xFFFF3E36),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text('บาท', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _error == null
          ? null
          : Material(
              color: const Color(0xFFFF3F39),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.yellow, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _error!,
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _field(TextEditingController controller, String hint, TextInputType keyboard) {
    return SizedBox(
      height: 52,
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        onChanged: (_) {
          if (_error != null) setState(() => _error = null);
        },
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF777177), fontSize: 12),
          filled: false,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          border: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFB7B1BA))),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFB7B1BA))),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFBC00), width: 1.5)),
        ),
      ),
    );
  }
}
