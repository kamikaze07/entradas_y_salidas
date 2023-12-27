import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:forsis/pages/new_record.dart';
import 'package:forsis/pages/dashboard.dart';

final EconomicoController = TextEditingController();
final EmpleadoController = TextEditingController();
final ObservacionesController = TextEditingController();

class formUtilitarioForsis extends StatefulWidget {
  const formUtilitarioForsis({super.key});

  @override
  State<formUtilitarioForsis> createState() => formUtilitarioForsisState();
}

class formUtilitarioForsisState extends State<formUtilitarioForsis> {
  bool full = false;
  bool remolque2 = false;
  bool fullRefacc = false;
  bool checkboxRefaccion1 = false;
  bool checkboxRefaccion2 = false;
  bool checkboxRefaccion3 = false;
  bool checkboxRefaccion4 = false;

  void _showAlertDialog(BuildContext context, String text) {
    if (text == "Success") {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Registro Exitoso'),
          content: Text(text),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LauncherPage()));
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Error en el Registro'),
          content: Text(text),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () {},
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  Future newRecord() async {
    var TipoRegistro = TipoRegistro1.toString();
    var TipoUnidad1 = TipoUnidad.toString();
    var TipoUnidadInterna1 = TipoUnidadInterna.toString();
    var url = Uri.http(
        "192.168.1.209", '/entradasysalidas/nEntradaSalidaForsis.php', {
      'q': {'http'}
    });
    var response = await http.post(url, body: {
      "TipoRegistro": TipoRegistro1,
      "TipoUnidad": TipoUnidad,
      "TipoUnidadInterna": TipoUnidadInterna1,
      "Full": "No",
      "Economico": EconomicoController.text,
      "Empleado": EmpleadoController.text,
      "Remolque1": "No",
      "Remolque2": "No",
      "NRefacciones": "No",
      "Observaciones": ObservacionesController.text,
    });
    print(response.toString());
    var data = json.decode(response.body);
    if (data.toString() == "Success") {
      _showAlertDialog(context, data.toString());
    } else {
      _showAlertDialog(context, data.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: TextField(
              controller: EconomicoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Economico",
              )),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 250,
          child: TextField(
            controller: EmpleadoController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Empleado",
            ),
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: <Widget>[
            TextField(
              controller: ObservacionesController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Observaciones",
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
            ElevatedButton(
                onPressed: newRecord, child: const Text("Registrar")),
          ],
        ),
      ],
    );
  }
}
