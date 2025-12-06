import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pantalla3 extends StatelessWidget {
  const Pantalla3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Pantalla3 "),),
       body: SingleChildScrollView(
         padding: EdgeInsets.all(16),
         child: formulario(context),
       ),
    );
  }
}

Widget formulario(context){
  TextEditingController salarioBruto = TextEditingController();

  String pais = 'España';

  final Map<String, double> tasas = {
    'España': 0.21,
    'México': 0.30,
    'Argentina': 0.35,
    'Colombia': 0.19,
  };

  return StatefulBuilder(builder: (context, setState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: salarioBruto,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Salario bruto'),
            hintText: 'Ej: 2500.50',
          ),
        ),

        SizedBox(height: 12),

        Text('País'),
        DropdownButton<String>(
          value: pais,
          isExpanded: true,
          items: tasas.keys.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => pais = v ?? 'España'),
        ),

        SizedBox(height: 16),

        FilledButton.icon(
          onPressed: () => calcular(salarioBruto, pais, tasas, context),
          icon: Icon(Icons.payments),
          label: Text('Calcular salario neto'),
        ),
      ],
    );
  });

}

void calcular(TextEditingController brutoC, String pais, Map<String, double> tasas, context) {
  String brutoText = brutoC.text.trim().replaceAll(',', '.');
  double? bruto = double.tryParse(brutoText);

  if (bruto == null) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('Por favor ingrese un salario bruto válido.'),
      );
    });
    return;
  }

  if (!tasas.containsKey(pais)) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('Opción no válida.'),
      );
    });
    return;
  }

  double tasa = tasas[pais]!;
  double montoImpuesto = bruto * tasa;
  double neto = bruto - montoImpuesto;

  showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text('Resultado'),
      content: Text('Salario neto: ${neto.toStringAsFixed(2)}\nImpuesto descontado: ${montoImpuesto.toStringAsFixed(2)}'),
    );
  });

}