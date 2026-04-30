// lib/screens/recommendation_screen.dart
import 'package:flutter/material.dart';

class RecommendationScreen extends StatelessWidget {
  final int heartRate;
  final String recommendation;
  final int ageRange;
  final int gender;
  final List<int> conditions;
  final int symptoms;
  final int medications;

  const RecommendationScreen({
    super.key,
    required this.heartRate,
    required this.recommendation,
    required this.ageRange,
    required this.gender,
    required this.conditions,
    required this.symptoms,
    required this.medications,
  });

  String _getStatusText() {
    if (heartRate < 60) return 'Bradicardia - Ritmo lento';
    if (heartRate > 100) return 'Taquicardia - Ritmo rápido';
    return 'Normal - Ritmo saludable';
  }

  Color _getStatusColor() {
    if (heartRate < 60) return Colors.orange;
    if (heartRate > 100) return Colors.red;
    return Colors.green;
  }

  IconData _getStatusIcon() {
    if (heartRate < 60) return Icons.speed;
    if (heartRate > 100) return Icons.flash_on;
    return Icons.health_and_safety;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Recomendación', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.red.shade400, Colors.red.shade700]),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                      child: Icon(_getStatusIcon(), size: 48, color: Colors.white),
                    ),
                    Text('$heartRate', style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.white)),
                    const Text('latidos por minuto', style: TextStyle(fontSize: 14, color: Colors.white70)),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(color: _getStatusColor().withOpacity(0.3), borderRadius: BorderRadius.circular(20)),
                      child: Text(_getStatusText(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(children: [Icon(Icons.medical_services, color: Colors.red, size: 28), SizedBox(width: 12), Text('Análisis personalizado', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red))]),
                    const Divider(height: 28),
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
                      child: const Row(children: [Icon(Icons.info_outline, color: Colors.blue, size: 20), SizedBox(width: 8), Expanded(child: Text('Esta recomendación se basa en tu frecuencia cardíaca actual y los datos demográficos que proporcionaste.', style: TextStyle(fontSize: 12, color: Colors.black54)))]),
                    ),
                    Text(recommendation, style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.black87)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Volver', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: BorderSide(color: Colors.red.shade300), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}