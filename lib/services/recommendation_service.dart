// lib/services/recommendation_service.dart
// SERVICIO CON RECOMENDACIONES DETALLADAS

class RecommendationService {
  static String getDetailedRecommendation({
    required int heartRate,
    required int ageRange,
    required int gender,
    required int conditions,
    required int symptoms,
    required int medications,
  }) {
    String status = _getStatus(heartRate);
    String ageGroup = _getAgeGroup(ageRange);
    String genderText = _getGenderText(gender);
    
    String recommendation = '';
    
    recommendation += _getPersonalizedOpening(heartRate, status, ageGroup, genderText);
    recommendation += _getDetailedAnalysis(heartRate, status, ageRange);
    recommendation += _getRiskFactors(conditions, symptoms, heartRate);
    recommendation += _getMedicationConsideration(medications, heartRate);
    recommendation += _getPracticalAdvice(heartRate, status, conditions, symptoms);
    recommendation += _getWhenToSeeDoctor(heartRate, status, conditions, symptoms);
    recommendation += _getTipsToImprove(heartRate, status);
    
    return recommendation;
  }
  
  static String _getStatus(int heartRate) {
    if (heartRate < 60) return 'bradicardia';
    if (heartRate > 100) return 'taquicardia';
    return 'normal';
  }
  
  static String _getAgeGroup(int ageRange) {
    const groups = ['joven adulto (18-30 años)', 'adulto (31-45 años)', 'adulto maduro (46-60 años)', 'adulto mayor (61-75 años)', 'adulto mayor avanzado (>75 años)'];
    return groups[ageRange];
  }
  
  static String _getGenderText(int gender) {
    const genders = ['mujer', 'hombre', 'persona'];
    return genders[gender];
  }
  
  static String _getPersonalizedOpening(int hr, String status, String ageGroup, String gender) {
    return "📊 **ANÁLISIS PERSONALIZADO**\n\n"
        "Hola, como $gender en el rango de edad $ageGroup, tu frecuencia cardíaca actual es de $hr latidos por minuto (lpm).\n\n"
        "Basado en tu perfil fisiológico y los datos que compartiste, a continuación encontrarás un análisis detallado:\n\n";
  }
  
  static String _getDetailedAnalysis(int hr, String status, int ageRange) {
    int normalMax = ageRange >= 3 ? 95 : 100;
    
    if (status == 'normal') {
      return "**💚 TU RITMO ES NORMAL**\n\n"
          "Tu frecuencia cardíaca se encuentra dentro del rango saludable que es de 60-${normalMax} lpm para tu edad. "
          "Esto indica que tu corazón está funcionando de manera eficiente en reposo.\n\n"
          "Un ritmo cardíaco normal sugiere que tu sistema cardiovascular no está bajo estrés excesivo y "
          "que tu cuerpo está manejando bien las funciones básicas.\n\n";
    } else if (status == 'bradicardia') {
      return "**🧡 RITMO LENTO (BRADICARDIA)**\n\n"
          "Tu frecuencia cardíaca está por debajo de 60 lpm. Esto se conoce como bradicardia.\n\n"
          "**¿Es preocupante?** Depende:\n"
          "• Si eres deportista o tienes buena condición física, puede ser normal y hasta saludable.\n"
          "• Si no haces ejercicio regularmente, podría indicar que tu corazón no está bombeando con la fuerza adecuada.\n"
          "• La bradicardia puede causar mareos, fatiga o desmayos si es muy marcada.\n\n";
    } else {
      return "**❤️‍🔥 RITMO RÁPIDO (TAQUICARDIA)**\n\n"
          "Tu frecuencia cardíaca supera los ${normalMax} lpm, lo que se considera taquicardia.\n\n"
          "**Posibles causas temporales:**\n"
          "• Estrés o ansiedad\n"
          "• Cafeína o bebidas energéticas\n"
          "• Deshidratación\n"
          "• Fiebre o infección\n"
          "• Ejercicio reciente\n\n"
          "Si persiste en reposo, puede requerir atención médica.\n\n";
    }
  }
  
  static String _getRiskFactors(int conditions, int symptoms, int hr) {
    String risk = "**⚠️ FACTORES DE RIESGO CONSIDERADOS**\n\n";
    bool hasRisk = false;
    
    if (conditions == 1) {
      risk += "• **Hipertensión arterial**: Tienes antecedentes de presión alta. Esto aumenta el riesgo cardiovascular. "
              "Es fundamental mantener controlada tu presión con medicación y hábitos saludables.\n\n";
      hasRisk = true;
    } else if (conditions == 2) {
      risk += "• **Insuficiencia cardíaca**: Tu diagnóstico requiere seguimiento médico estrecho. "
              "Cualquier cambio en tu ritmo debe ser comunicado a tu cardiólogo.\n\n";
      hasRisk = true;
    } else if (conditions == 3) {
      risk += "• **Infarto previo**: Haber tenido un ataque cardíaco implica que tu corazón necesita cuidados especiales. "
              "Mantén tus medicamentos y controles regulares.\n\n";
      hasRisk = true;
    } else if (conditions == 4) {
      risk += "• **Arritmias diagnosticadas**: Ya tienes antecedentes de problemas de ritmo. "
              "Esta medición es especialmente importante para ti.\n\n";
      hasRisk = true;
    }
    
    if (symptoms == 1 && hr > 90) {
      risk += "• **Palpitaciones activas**: Reportaste palpitaciones y tu FC está elevada. "
              "Esto merece atención profesional, especialmente si las palpitaciones son frecuentes.\n\n";
      hasRisk = true;
    } else if (symptoms == 2) {
      risk += "• **Dolor en el pecho**: Este es un síntoma de alerta. "
              "El dolor torácico asociado a cambios en el ritmo cardíaco debe ser evaluado por un médico.\n\n";
      hasRisk = true;
    } else if (symptoms == 3 && hr < 60) {
      risk += "• **Mareos con ritmo lento**: La combinación de mareos y frecuencia cardíaca baja sugiere "
              "que tu cerebro podría no estar recibiendo suficiente flujo sanguíneo.\n\n";
      hasRisk = true;
    }
    
    if (!hasRisk) {
      risk += "✅ No se detectaron factores de riesgo adicionales en tu perfil. "
              "¡Sigue así con tus buenos hábitos!\n\n";
    }
    
    return risk;
  }
  
  static String _getMedicationConsideration(int medications, int hr) {
    if (medications == 0) return '';
    
    String medText = "**💊 CONSIDERACIÓN DE MEDICAMENTOS**\n\n";
    
    switch (medications) {
      case 1:
        medText += "Estás tomando betabloqueadores, medicamentos que reducen la frecuencia cardíaca. "
                  "Si tu ritmo está muy lento (por debajo de 55 lpm), consulta con tu médico si ajustar la dosis.\n\n";
        break;
      case 2:
        medText += "Los antidepresivos o ansiolíticos pueden afectar el ritmo cardíaco. "
                  "Algunos pueden alargar el intervalo QT del corazón. Mantén control médico periódico.\n\n";
        break;
      case 3:
        medText += "Los antiarrítmicos están diseñados específicamente para controlar tu ritmo. "
                  "Esta medicación requiere monitoreo regular. Comparte esta medición con tu cardiólogo.\n\n";
        break;
      case 4:
        medText += "Los diuréticos pueden afectar tus electrolitos (potasio, magnesio), lo que influye en el ritmo cardíaco. "
                  "Asegúrate de mantener una dieta balanceada y controles de laboratorio.\n\n";
        break;
      default:
        return '';
    }
    
    return medText;
  }
  
  static String _getPracticalAdvice(int hr, String status, int conditions, int symptoms) {
    String advice = "**📋 RECOMENDACIONES PRÁCTICAS**\n\n";
    
    if (status == 'normal' && conditions == 0 && symptoms == 0) {
      advice += "1. **Mantén tu estilo de vida saludable** - Sigue con ejercicio regular y alimentación balanceada.\n"
              "2. **Monitoreo periódico** - Realiza mediciones cada 15-30 días para seguir tu tendencia.\n"
              "3. **Hidrátate bien** - Bebe suficiente agua durante el día.\n"
              "4. **Duerme 7-8 horas** - El descanso adecuado mantiene el ritmo cardíaco estable.\n\n";
    } else if (status != 'normal') {
      advice += "1. **Toma 3 mediciones** - Realiza una medición matutina (antes del café) durante 3 días seguidos.\n"
              "2. **Evita estimulantes** - Reduce o elimina cafeína, té, alcohol y bebidas energéticas.\n"
              "3. **Practica respiración** - La respiración profunda (4 segundos inhalar, 4 exhalar) ayuda a regular el ritmo.\n"
              "4. **Mantén un registro** - Anota fecha, hora y cualquier síntoma asociado.\n\n";
    } else {
      advice += "1. **Control periódico** - Aunque estés normal, mantén seguimiento si tienes factores de riesgo.\n"
              "2. **Ejercicio moderado** - Caminar 30 minutos diarios fortalece tu corazón.\n"
              "3. **Dieta cardiosaludable** - Reduce grasas saturadas y aumenta frutas, verduras y pescado.\n\n";
    }
    
    return advice;
  }
  
  static String _getWhenToSeeDoctor(int hr, String status, int conditions, int symptoms) {
    String medical = "**🏥 CUÁNDO CONSULTAR AL MÉDICO**\n\n";
    
    if (status == 'normal' && conditions == 0 && symptoms == 0) {
      medical += "No hay urgencia médica según esta medición. Continúa con tus controles de rutina.\n\n";
    } else {
      medical += "**Consulta a un médico si presentas:**\n\n";
      
      if (status == 'bradicardia') {
        medical += "• Mareos o sensación de desmayo\n"
                  "• Fatiga extrema o debilidad\n"
                  "• Confusión o problemas de memoria\n";
      } else if (status == 'taquicardia') {
        medical += "• Palpitaciones que duran más de 5 minutos\n"
                  "• Dolor en el pecho o presión\n"
                  "• Falta de aire repentina\n"
                  "• Sensación de que vas a desmayarte\n";
      }
      
      if (symptoms == 2) {
        medical += "• **Dolor en el pecho** - Este síntoma siempre requiere evaluación médica\n";
      }
      
      medical += "\n**Busca atención de emergencia si:** Tu corazón late muy rápido y tienes dolor en el pecho, falta de aire severa o pérdida de conciencia.\n\n";
    }
    
    return medical;
  }
  
  static String _getTipsToImprove(int hr, String status) {
    String tips = "**💪 CONSEJOS PARA MEJORAR TU SALUD CARDIOVASCULAR**\n\n";
    
    tips += "• Realiza actividad física regular: 150 minutos de caminata a la semana\n"
            "• Mantén una dieta mediterránea rica en omega-3 (pescado, frutos secos)\n"
            "• Controla el estrés con meditación, yoga o pasatiempos relajantes\n"
            "• Evita el tabaco y limita el alcohol\n"
            "• Mantén un peso saludable\n"
            "• Duerme al menos 7 horas diarias\n\n"
            "---\n💙 **Recuerda**: Esta app es una herramienta de monitoreo, no reemplaza la opinión de un profesional de la salud.";
    
    return tips;
  }
}