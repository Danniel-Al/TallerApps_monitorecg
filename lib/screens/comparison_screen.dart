// lib/screens/comparison_screen.dart
// PANTALLA DE COMPARACIÓN DETALLADA

import 'package:flutter/material.dart';
import '../services/comparison_service.dart';

class ComparisonScreen extends StatelessWidget {
  final DetailedComparison comparison;
  final int heartRate;
  final int ageRange;
  final int gender;

  const ComparisonScreen({
    super.key,
    required this.comparison,
    required this.heartRate,
    required this.ageRange,
    required this.gender,
  });

  Color _getStatusColor() {
    switch (comparison.statusColor) {
      case 'verde': return Colors.green;
      case 'naranja': return Colors.orange;
      case 'rojo': return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Comparación por edad', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isSmallScreen ? 20 : 30),
          child: Column(
            children: [
              // Tarjeta principal
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red.shade50, Colors.red.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.people, size: 48, color: Colors.red),
                    const SizedBox(height: 12),
                    Text(
                      'Tu ritmo: ${comparison.heartRate} lpm',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        comparison.status,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Rango por edad
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📊 Comparación con tu grupo etario',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Divider(height: 24),
                    _buildInfoRow('Tu sexo', comparison.gender),
                    _buildInfoRow('Rango etario', '${comparison.ageGroup} años (${comparison.description})'),
                    _buildInfoRow('Rango normal esperado', '${comparison.minNormal} - ${comparison.maxNormal} lpm'),
                    _buildInfoRow('Rango ideal', '${comparison.idealMin} - ${comparison.idealMax} lpm'),
                    _buildInfoRow('Tu posición', comparison.percentile),
                    const SizedBox(height: 16),
                    
                    // Barra de rango visual
                    Column(
                      children: [
                        const Text('Ubicación en el rango:', style: TextStyle(fontSize: 12, color: Colors.black54)),
                        const SizedBox(height: 8),
                        Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade300,
                          ),
                          child: Stack(
                            children: [
                              // Rango normal
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: (comparison.minNormal / 100) * MediaQuery.of(context).size.width,
                                ),
                                width: ((comparison.maxNormal - comparison.minNormal) / 100) * MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Colors.green, Colors.green],
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              // Marcador del usuario
                              Positioned(
                                left: (comparison.heartRate.clamp(0, 100) / 100) * MediaQuery.of(context).size.width - 15,
                                child: Column(
                                  children: [
                                    const Icon(Icons.arrow_drop_down, color: Colors.red, size: 24),
                                    const Text('TÚ', style: TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('0', style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                            Text('${comparison.minNormal}', style: TextStyle(fontSize: 10, color: Colors.green.shade600)),
                            Text('${comparison.maxNormal}', style: TextStyle(fontSize: 10, color: Colors.green.shade600)),
                            Text('100', style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Recomendación detallada
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _getStatusColor().withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.medical_services, color: _getStatusColor()),
                        const SizedBox(width: 8),
                        const Text(
                          'Interpretación y recomendaciones',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Text(
                      comparison.recommendation,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Nota aclaratoria
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Los rangos son referenciales. Factores como actividad física, medicamentos y emociones pueden influir en tu medición.',
                        style: TextStyle(fontSize: 11, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Botones
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: BorderSide(color: Colors.red.shade300),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Volver'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                      icon: const Icon(Icons.favorite),
                      label: const Text('Nueva medición'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(color: Colors.black54, fontSize: 13)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}