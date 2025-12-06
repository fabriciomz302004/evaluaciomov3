import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pantalla2 extends StatelessWidget {
  const Pantalla2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Pantalla2 "),),
       body: SingleChildScrollView(
         padding: EdgeInsets.all(16),
         child: formulario(context),
       ),
    );
  }
}

Widget formulario(context){
  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();
  TextEditingController edad = TextEditingController();

  String genero = 'Hombre';
  String actividad = 'Sedentario';

  return StatefulBuilder(builder: (context, setState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Género"),
        DropdownButton<String>(
          value: genero,
          isExpanded: true,
          items: ['Hombre', 'Mujer'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => genero = v ?? 'Hombre'),
        ),

        SizedBox(height: 12),

        TextField(
          controller: peso,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Peso (kg)"),
            hintText: "Ej: 70",
          ),
        ),

        SizedBox(height: 12),

        TextField(
          controller: altura,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Altura (cm)"),
            hintText: "Ej: 175",
          ),
        ),

        SizedBox(height: 12),

        TextField(
          controller: edad,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Edad (años)"),
            hintText: "Ej: 30",
          ),
        ),

        SizedBox(height: 12),

        Text("Nivel de actividad"),
        DropdownButton<String>(
          value: actividad,
          isExpanded: true,
          items: [
            'Sedentario',
            'Ligero',
            'Moderado',
            'Activo',
            'Muy activo'
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => actividad = v ?? 'Sedentario'),
        ),

        SizedBox(height: 16),

        FilledButton.icon(
          onPressed: () => calcular(peso, altura, edad, genero, actividad, context),
          icon: Icon(Icons.local_fire_department),
          label: Text('Calcular calorías diarias'),
        ),
      ],
    );
  });

}

double _activityFactor(String actividad) {
  switch (actividad) {
    case 'Sedentario':
      return 1.2;
    case 'Ligero':
      return 1.375;
    case 'Moderado':
      return 1.55;
    case 'Activo':
      return 1.725;
    case 'Muy activo':
      return 1.9;
    default:
      return 1.2;
  }
}

void calcular(TextEditingController pesoC, TextEditingController alturaC, TextEditingController edadC, String genero, String actividad, context) {
  String pText = pesoC.text.trim().replaceAll(',', '.');
  String hText = alturaC.text.trim().replaceAll(',', '.');
  String eText = edadC.text.trim();

  double? peso = double.tryParse(pText);
  double? altura = double.tryParse(hText);
  int? edad = int.tryParse(eText);

  if (peso == null || altura == null || edad == null) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('Por favor ingrese valores numéricos válidos para peso, altura y edad.'),
      );
    });
    return;
  }

  // Mifflin-St Jeor
  double bmr;
  if (genero.toLowerCase().startsWith('h')) {
    bmr = 10 * peso + 6.25 * altura - 5 * edad + 5;
  } else {
    bmr = 10 * peso + 6.25 * altura - 5 * edad - 161;
  }

  double factor = _activityFactor(actividad);
  double calorias = bmr * factor;

  showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text('Resultado'),
      content: Text('Calorías diarias recomendadas: ${calorias.toStringAsFixed(0)} kcal'),
    );
  });

}