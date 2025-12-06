
import 'package:evaluacion/screens/ejercicio1.dart';
import 'package:evaluacion/screens/ejercicio2.dart';
import 'package:evaluacion/screens/ejercicio3.dart';
import 'package:flutter/material.dart';

void main(){
runApp(MiApp());


}
class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EVALUACIÓN"),
      actions: [IconButton(onPressed: ()=>(), icon:Icon(Icons.rocket_launch))],),
     body:botones(context),
    );
  }
}

 Widget botones(context){
return Column(children: [
  
  
   FilledButton(onPressed: ()=>irventana1(context), child: Text("desplegar informacion")),
   
     ElevatedButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Pantalla1(),)), child: Text("Pantalla 1")),
   
    ElevatedButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Pantalla2(),)), child: Text("Pantalla 2")),
  
    ElevatedButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Pantalla3(),)), child: Text("Pantalla 3")),



      Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAO2It2YkVZ48hJcc7hzflGqc4Hrq3tkGQuQ&s",
      width: 300,
      height: 500,
    
      ),
 
],);

 }

 void irventana1(context){
  mostrarInfoModal(context);
 }

 void mostrarInfoModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // ✅ Título Centrado: Se envuelve el Row en Center y se usa mainAxisSize.min
        title: Center( 
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.person, color: Colors.blue),
              SizedBox(width: 8),
              Text('Información del Estudiante'),
            ],
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nombre:Leandro Moreirs', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Docente:Ing.Julio Rosero'),
            Text('Carrera:Desarrollo de Software'),
            Text('Fecha: 06/12/2025'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar'),
          ),
        ],
      );
    },
  );
}

 void irVentana2(context){
 Navigator.push(context, MaterialPageRoute(builder: (context)=> Pantalla2(),));
 }

 void irVentana3(context){
 Navigator.push(context, MaterialPageRoute(builder: (context)=> Pantalla3(),));
 }
