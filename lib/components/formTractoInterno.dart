import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forsis/pages/new_record.dart';

final EconomicoController = TextEditingController();
final Remolque1Controller = TextEditingController();
final Remolque2Controller = TextEditingController();

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

  void newRecord() {
    var TipoRegistro = TipoRegistro1.toString();
    var TipoUnidad1 = TipoUnidad.toString();
    var TipoUnidadInterna1 = TipoUnidadInterna.toString();
    var full1;
    if (full) {
      full1 = "FULL";
    } else {
      full1 = "SENCILLO";
    }

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Datos:'),
        content: Text(TipoRegistro +
            '\n' +
            TipoUnidad1 +
            '\n' +
            TipoUnidadInterna1 +
            '\n' +
            full1 +
            '\n' +
            EconomicoController.text +
            '\n' +
            Remolque1Controller.text),
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
            const TextField(
              decoration: InputDecoration(
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
