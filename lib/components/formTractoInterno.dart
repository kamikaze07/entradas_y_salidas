import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:forsis/pages/new_record.dart';
import 'package:forsis/pages/dashboard.dart';

final EconomicoController = TextEditingController();
final Remolque1Controller = TextEditingController();
final Remolque2Controller = TextEditingController();
final ObservacionesController = TextEditingController();

class formTractoInterno extends StatefulWidget {
  const formTractoInterno({super.key});

  @override
  State<formTractoInterno> createState() => formTractoInternoState();
}

class formTractoInternoState extends State<formTractoInterno> {
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
    var full1;
    if (full) {
      full1 = "FULL";
    } else {
      full1 = "SENCILLO";
    }
    var Remolque2;
    if (Remolque2Controller.text == "") {
      Remolque2 = "No";
    } else {
      Remolque2 = Remolque2Controller.text;
    }
    var list = [
      checkboxRefaccion1,
      checkboxRefaccion2,
      checkboxRefaccion3,
      checkboxRefaccion4
    ];
    var NRefacciones = "Numero de Refacciones = 0";
    var inc = 0;
    for (var i = 0; i < list.length; i++) {
      if (list[i]) {
        inc++;
        NRefacciones = "Numero de Refacciones = " + inc.toString();
      }
    }
    var url = Uri.http(
        "192.168.1.209", '/entradasysalidas/nEntradaSalidaForsis.php', {
      'q': {'http'}
    });
    var response = await http.post(url, body: {
      "TipoRegistro": TipoRegistro1,
      "TipoUnidad": TipoUnidad,
      "TipoUnidadInterna": TipoUnidadInterna1,
      "Full": full1,
      "Economico": EconomicoController.text,
      "Remolque1": Remolque1Controller.text,
      "Remolque2": Remolque2,
      "NRefacciones": NRefacciones,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: SwitchListTile(
            tileColor: const Color.fromARGB(255, 255, 255, 255),
            activeColor: Colors.red,
            title: const Text('FULL'),
            value: full,
            onChanged: (bool? value) {
              setState(() {
                full = value!;
                remolque2 = value;
                fullRefacc = value;
              });
            },
          ),
        ),
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
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: Remolque1Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Remolque 1",
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Visibility(
                visible: remolque2,
                child: TextField(
                  controller: Remolque2Controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Remolque 2",
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text("Elementos"),
        const SizedBox(height: 10),
        Column(
          children: <Widget>[
            CheckboxListTile(
              value: checkboxRefaccion1,
              onChanged: (bool? value) {
                setState(() {
                  checkboxRefaccion1 = value!;
                });
              },
              title: const Text('Refaccion 1'),
            ),
            const Divider(height: 0),
            CheckboxListTile(
              value: checkboxRefaccion2,
              onChanged: (bool? value) {
                setState(() {
                  checkboxRefaccion2 = value!;
                });
              },
              title: const Text('Refaccion 2'),
            ),
            const Divider(height: 0),
            Visibility(
                visible: fullRefacc,
                child: Column(
                  children: [
                    CheckboxListTile(
                      value: checkboxRefaccion3,
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxRefaccion3 = value!;
                        });
                      },
                      title: const Text('Refaccion 3'),
                    ),
                    const Divider(height: 0),
                    CheckboxListTile(
                      value: checkboxRefaccion4,
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxRefaccion4 = value!;
                        });
                      },
                      title: const Text('Refaccion 4'),
                    ),
                  ],
                )),
            const SizedBox(height: 10),
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
