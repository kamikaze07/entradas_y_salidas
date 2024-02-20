import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:forsis/pages/new_record.dart';
import 'package:forsis/pages/dashboard.dart';

class formUtilitarioForsis extends StatefulWidget {
  const formUtilitarioForsis({super.key});

  @override
  State<formUtilitarioForsis> createState() => formUtilitarioForsisState();
}

class formUtilitarioForsisState extends State<formUtilitarioForsis> {
  final EconomicoController = TextEditingController();
  final EmpleadoController = TextEditingController();
  final ObservacionesController = TextEditingController();

  bool full = false;
  bool remolque2 = false;
  bool fullRefacc = false;
  bool checkboxRefaccion1 = false;
  bool checkboxRefaccion2 = false;
  bool checkboxRefaccion3 = false;
  bool checkboxRefaccion4 = false;
  var economicoInputStatus = Colors.grey;
  var empleadoInputStatus = Colors.grey;

  @override
  void dispose() {
    EconomicoController.dispose();
    EmpleadoController.dispose();
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
        "forsis.ddns.net", '/entradasysalidas/nEntradaSalidaForsis.php', {
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
      "TipoRemolque1": "Np",
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
              controller: EconomicoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Economico*",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    EconomicoController.clear();
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: economicoInputStatus),
                ),
              )),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 250,
          child: TextField(
            controller: EmpleadoController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Empleado*",
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  EmpleadoController.clear();
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: empleadoInputStatus),
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
                if (EconomicoController.text == "") {
                  setState(() {
                    economicoInputStatus = Colors.red;
                    err++;
                  });
                } else {
                  setState(() {
                    economicoInputStatus = Colors.grey;
                  });
                }
                if (EmpleadoController.text == "") {
                  setState(() {
                    empleadoInputStatus = Colors.red;
                    err++;
                  });
                } else {
                  setState(() {
                    empleadoInputStatus = Colors.grey;
                  });
                }
                if (err > 0) {
                  _showAlertDialog(
                      context, "Ingresa todos los campos Requeridos*");
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
