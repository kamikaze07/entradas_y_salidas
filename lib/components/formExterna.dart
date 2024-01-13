import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:forsis/pages/new_record.dart';
import 'package:forsis/pages/dashboard.dart';

class formExterna extends StatefulWidget {
  const formExterna({super.key});

  @override
  State<formExterna> createState() => formExternaState();
}

class formExternaState extends State<formExterna> {
  final placasController = TextEditingController();
  final visitanteController = TextEditingController();
  final ObservacionesController = TextEditingController();
  bool full = false;
  bool remolque2 = false;
  bool fullRefacc = false;
  bool checkboxRefaccion1 = false;
  bool checkboxRefaccion2 = false;
  bool checkboxRefaccion3 = false;
  bool checkboxRefaccion4 = false;
  var placasInputStatus = Colors.grey;
  var visitanteInputStatus = Colors.grey;

  @override
  void dispose() {
    placasController.dispose();
    visitanteController.dispose();
    ObservacionesController.dispose();
    super.dispose();
  }

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
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/dashboard', (Route<dynamic> route) => false);
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
              onPressed: () {
                Navigator.pop(context);
              },
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
      "TipoUnidadInterna": "Externa",
      "Full": "No",
      "Economico": "N° de Placas: " + placasController.text,
      "Empleado": "Visitiante o Proveedor: " + visitanteController.text,
      "Remolque1": "No",
      "Remolque2": "No",
      "TipoRemolque1": "No",
      "Contenedores": "No",
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
              controller: placasController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Placas*",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    placasController.clear();
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: placasInputStatus),
                ),
              )),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 250,
          child: TextField(
            controller: visitanteController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Nombre del Visitante o Proveedor*",
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  visitanteController.clear();
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: visitanteInputStatus),
              ),
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
            const SizedBox(height: 30),
            CupertinoButton.filled(
              onPressed: () {
                var err = 0;
                if (placasController.text == "") {
                  setState(() {
                    placasInputStatus = Colors.red;
                    err++;
                  });
                } else {
                  setState(() {
                    placasInputStatus = Colors.grey;
                  });
                }
                if (visitanteController.text == "") {
                  setState(() {
                    visitanteInputStatus = Colors.red;
                    err++;
                  });
                } else {
                  setState(() {
                    visitanteInputStatus = Colors.grey;
                  });
                }
                if (err > 0) {
                  _showAlertDialog(context, "Ingresa todos los campos");
                } else {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text('Nuevo Registro'),
                      content: Text('¿Registrar nueva ' + TipoRegistro1 + '?'),
                      actions: <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          /// This parameter indicates this action is the default,
                          /// and turns the action's text to bold text.
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        ),
                        CupertinoDialogAction(
                          /// This parameter indicates the action would perform
                          /// a destructive action such as deletion, and turns
                          /// the action's text color to red.
                          isDestructiveAction: true,
                          onPressed: () {
                            newRecord();
                          },
                          child: const Text('Si'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ],
    );
  }
}
