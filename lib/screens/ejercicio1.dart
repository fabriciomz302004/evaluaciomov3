import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pantalla1 extends StatelessWidget {
  const Pantalla1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Pantalla1 "),),
       body: SingleChildScrollView(
         padding: EdgeInsets.all(16),
         child: formulario(context),
       ),
    );
  }
}

Widget formulario(context){
  TextEditingController volumen = TextEditingController();
  TextEditingController tiempo = TextEditingController();
  TextEditingController factor = TextEditingController();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TextField(
        controller: volumen,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Volumen (mL)"),
          hintText: "Ej: 500",
        ),
      ),

      SizedBox(height: 12),

      TextField(
        controller: tiempo,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Tiempo (horas)"),
          hintText: "Ej: 4",
        ),
      ),

      SizedBox(height: 12),

      TextField(
        controller: factor,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Factor de goteo (gotas/mL)"),
          hintText: "Ej: 20",
        ),
      ),

      SizedBox(height: 16),

      FilledButton.icon(
        onPressed: ()=>calcular(volumen, tiempo, factor, context),
        icon: Icon(Icons.opacity),
        label: Text("Calcular gotas/min"),
      ),
    ],
  );

}

void calcular(TextEditingController volumenC, TextEditingController tiempoC, TextEditingController factorC, context) {
  String vText = volumenC.text.trim().replaceAll(',', '.');
  String tText = tiempoC.text.trim().replaceAll(',', '.');
  String fText = factorC.text.trim().replaceAll(',', '.');

  double? volumen = double.tryParse(vText);
  double? tiempo = double.tryParse(tText);
  double? factor = double.tryParse(fText);

  if (tiempo == null || tiempo == 0) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Error"),
        content: Text("Error: el tiempo debe ser mayor a 0."),
      );
    });
    return;
  }

  if (volumen == null || factor == null) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Error"),
        content: Text("Por favor ingrese valores numéricos válidos."),
      );
    });
    return;
  }

  double gotasPorMin = (volumen * factor) / (tiempo * 60);

  showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text("Resultado"),
      content: Text("Gotas/min = ${gotasPorMin.toStringAsFixed(2)}"),
    );
  });

}