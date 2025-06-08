import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ShakeDetector extends StatefulWidget {
  @override
  _ShakeDetectorState createState() => _ShakeDetectorState();
}

class _ShakeDetectorState extends State<ShakeDetector> {
  double _lastX = 0, _lastY = 0, _lastZ = 0;
  int _shakeCount = 0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (_isShake(event.x, event.y, event.z)) {
        _shakeCount++;
        print('Shake detected! Count: $_shakeCount');
        // Add your logout or refresh logic here
        // For example, call your logout function:
        // await AuthService().logout();
        // Or refresh data:
        // await _loadProfile();
      }
      _lastX = event.x;
      _lastY = event.y;
      _lastZ = event.z;
    });
  }

  bool _isShake(double x, double y, double z) {
    double threshold = 10.0; // Adjust as needed
    return (x - _lastX).abs() > threshold ||
           (y - _lastY).abs() > threshold ||
           (z - _lastZ).abs() > threshold;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shake Detector')),
      body: Center(
        child: Text('Shake to logout or refresh!'),
      ),
    );
  }
}
