// lib/screens/recommendation_screen.dart
// VERSIÓN REDISEÑADA - ESTÉTICA MODERNA Y ORDENADA

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
    if (heartRate < 60) return 'Bradicardia';
    if (heartRate > 100) return 'Taquicardia';
    return 'Normal';
  }

  String _getStatusDescription() {
    if (heartRate < 60) {
      return 'Tu corazón late más lento de lo habitual. Puede ser normal si eres deportista, pero si tienes síntomas como mareos o fatiga, consulta a tu médico.';
    } else if (heartRate > 100) {
      return 'Tu corazón late más rápido de lo habitual. Esto puede deberse a estrés, cafeína, deshidratación o fiebre. Si persiste, busca atención médica.';
    } else {
      return '¡Excelente! Tu frecuencia cardíaca está dentro del rango saludable. Mantén tus buenos hábitos.';
    }
  }

  Color _getStatusColor() {
    if (heartRate < 60) return Colors.orange;
    if (heartRate > 100) return Colors.red;
    return Colors.green;
  }

  List<Map<String, dynamic>> _parseSections() {
    String clean = recommendation.replaceAll('**', '').replaceAll('*', '');
    List<Map<String, dynamic>> sections = [];
    
    if (clean.contains('ANÁLISIS PERSONALIZADO')) {
      sections.add({
        'icon': Icons.analytics,
        'title': 'Análisis personalizado',
        'color': Colors.purple,
        'content': _extractSection(clean, 'ANÁLISIS PERSONALIZADO', 'TU RITMO'),
      });
    }
    
    if (clean.contains('TU RITMO ES NORMAL') || clean.contains('RITMO LENTO') || clean.contains('RITMO RÁPIDO')) {
      String content = '';
      if (clean.contains('TU RITMO ES NORMAL')) {
        content = _extractSection(clean, 'TU RITMO ES NORMAL', 'FACTORES DE RIESGO');
      } else if (clean.contains('RITMO LENTO')) {
        content = _extractSection(clean, 'RITMO LENTO', 'FACTORES DE RIESGO');
      } else if (clean.contains('RITMO RÁPIDO')) {
        content = _extractSection(clean, 'RITMO RÁPIDO', 'FACTORES DE RIESGO');
      }
      sections.add({
        'icon': Icons.favorite,
        'title': 'Ritmo cardíaco',
        'color': Colors.red,
        'content': content,
      });
    }
    
    if (clean.contains('FACTORES DE RIESGO')) {
      sections.add({
        'icon': Icons.warning,
        'title': 'Factores de riesgo',
        'color': Colors.orange,
        'content': _extractSection(clean, 'FACTORES DE RIESGO', 'CONSIDERACIÓN DE MEDICAMENTOS'),
      });
    }
    
    if (clean.contains('CONSIDERACIÓN DE MEDICAMENTOS')) {
      sections.add({
        'icon': Icons.medical_services,
        'title': 'Medicamentos',
        'color': Colors.blue,
        'content': _extractSection(clean, 'CONSIDERACIÓN DE MEDICAMENTOS', 'RECOMENDACIONES PRÁCTICAS'),
      });
    }
    
    if (clean.contains('RECOMENDACIONES PRÁCTICAS')) {
      sections.add({
        'icon': Icons.checklist,
        'title': 'Recomendaciones prácticas',
        'color': Colors.green,
        'content': _extractSection(clean, 'RECOMENDACIONES PRÁCTICAS', 'CUÁNDO CONSULTAR'),
      });
    }
    
    if (clean.contains('CUÁNDO CONSULTAR')) {
      sections.add({
        'icon': Icons.local_hospital,
        'title': 'Cuándo consultar al médico',
        'color': Colors.teal,
        'content': _extractSection(clean, 'CUÁNDO CONSULTAR', 'CONSEJOS PARA MEJORAR'),
      });
    }
    
    if (clean.contains('CONSEJOS PARA MEJORAR')) {
      sections.add({
        'icon': Icons.fitness_center,
        'title': 'Consejos para mejorar',
        'color': Colors.indigo,
        'content': _extractSection(clean, 'CONSEJOS PARA MEJORAR', 'Recuerda'),
      });
    }
    
    return sections;
  }

  String _extractSection(String text, String start, String end) {
    int startIndex = text.indexOf(start);
    if (startIndex == -1) return '';
    startIndex += start.length;
    int endIndex = text.indexOf(end, startIndex);
    if (endIndex == -1) {
      return text.substring(startIndex).trim();
    }
    return text.substring(startIndex, endIndex).trim();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final sections = _parseSections();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Recomendación',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarjeta principal de frecuencia cardíaca
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade500, Colors.red.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$heartRate',
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'latidos por minuto',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor().withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getStatusText(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, size: 18, color: Colors.white70),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _getStatusDescription(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Secciones dinámicas
            ...sections.map((section) => _buildSectionCard(section)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(Map<String, dynamic> section) {
    String content = section['content'] ?? '';
    
    // Formatear bullet points
    List<String> lines = content.split('\n');
    List<Widget> formattedContent = [];
    
    for (String line in lines) {
      if (line.trim().isEmpty) continue;
      
      if (line.trim().startsWith('•')) {
        formattedContent.add(
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•',
                  style: TextStyle(
                    color: section['color'],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    line.replaceFirst('•', '').trim(),
                    style: const TextStyle(fontSize: 14, height: 1.4, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (line.trim().startsWith('1.') || 
                 line.trim().startsWith('2.') || 
                 line.trim().startsWith('3.') || 
                 line.trim().startsWith('4.')) {
        formattedContent.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  line.substring(0, 2),
                  style: TextStyle(
                    color: section['color'],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    line.substring(2).trim(),
                    style: const TextStyle(fontSize: 14, height: 1.4, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (line.contains('✅') || line.contains('⚠️') || line.contains('💚') || line.contains('💛') || line.contains('❤️') || line.contains('🧡')) {
        formattedContent.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              line,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        );
      } else {
        formattedContent.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              line,
              style: const TextStyle(fontSize: 14, height: 1.4, color: Colors.black87),
            ),
          ),
        );
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header de la sección
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: section['color'].withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: section['color'],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    section['icon'],
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    section['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: section['color'],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Contenido de la sección
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: formattedContent,
            ),
          ),
        ],
      ),
    );
  }
}