import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:forsis/pages/new_record.dart';
import 'package:forsis/pages/dashboard.dart';

class formTractoInterno extends StatefulWidget {
  const formTractoInterno({super.key});

  @override
  State<formTractoInterno> createState() => formTractoInternoState();
}

const List<String> tipoRemolque = <String>[
  'Selecciona el Tipo de Remolque',
  'Porta de 20"',
  'Porta de 40"',
  'Porta de 53"',
  'Pipa',
  'Gondola',
  'Tolva',
  'Fractank',
];

class formTractoInternoState extends State<formTractoInterno> {
  final EconomicoController = TextEditingController();
  final Remolque1Controller = TextEditingController();
  final Remolque2Controller = TextEditingController();
  final ObservacionesController = TextEditingController();
  String tipoRemolque1 = tipoRemolque.first;
  String tipoRemolque2 = tipoRemolque.first;
  bool full = false;
  bool remolque2 = false;
  bool fullRefacc = false;
  bool checkboxRefaccion1 = false;
  bool checkboxRefaccion2 = false;
  bool checkboxRefaccion3 = false;
  bool checkboxRefaccion4 = false;
  bool textTipoRemolque2 = false;
  bool dropdownTipoRemolque2 = false;
  var economicoInputStatus = Colors.grey;
  var remolque1InputStatus = Colors.grey;
  var remolque2InputStatus = Colors.grey;
  var dropdwnremolque1InputStatus = Colors.grey;
  var dropdwnremolque2InputStatus = Colors.grey;

  @override
  void dispose() {
    EconomicoController.dispose();
    Remolque1Controller.dispose();
    Remolque2Controller.dispose();
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
    var _tipoRemolque2;
    if (tipoRemolque2 == tipoRemolque.first) {
      _tipoRemolque2 = "No";
    } else {
      _tipoRemolque2 = tipoRemolque2;
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
      "Empleado": "No",
      "Remolque1": Remolque1Controller.text,
      "Remolque2": Remolque2,
      "TipoRemolque1": tipoRemolque1,
      "TipoRemolque2": _tipoRemolque2,
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

  void clearText(TextEditingController textEditingController) {
    textEditingController.clear();
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
                textTipoRemolque2 = value;
                dropdownTipoRemolque2 = value;
              });
            },
          ),
        ),
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
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: Remolque1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Remolque 1*",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      Remolque1Controller.clear();
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: remolque1InputStatus),
                  ),
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Remolque 2*",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        Remolque2Controller.clear();
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: remolque2InputStatus),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(
              height: 15,
              child: Text("Tipo Remolque 1*"),
            ),
            const SizedBox(width: 80),
            Visibility(
              visible: textTipoRemolque2,
              child: const SizedBox(
                height: 15,
                child: Text("Tipo Remolque 2*"),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
                child: DropdownMenu<String>(
                    width: 150,
                    initialSelection: tipoRemolque.first,
                    onSelected: (String? value) {
                      setState(() {
                        tipoRemolque1 = value!;
                      });
                    },
                    dropdownMenuEntries: tipoRemolque
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                    inputDecorationTheme: InputDecorationTheme(
                        enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: dropdwnremolque1InputStatus),
                    )))),
            Visibility(
              visible: dropdownTipoRemolque2,
              child: Expanded(
                  child: DropdownMenu<String>(
                      width: 150,
                      initialSelection: tipoRemolque.first,
                      onSelected: (String? value) {
                        setState(() {
                          tipoRemolque2 = value!;
                        });
                      },
                      dropdownMenuEntries: tipoRemolque
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                      inputDecorationTheme: InputDecorationTheme(
                          enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: dropdwnremolque2InputStatus),
                      )))),
            )
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
            const SizedBox(height: 30),
            CupertinoButton.filled(
              onPressed: () {
                var err = 0;
                if (full) {
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
                  if (Remolque1Controller.text == "") {
                    setState(() {
                      remolque1InputStatus = Colors.red;
                      err++;
                    });
                  } else {
                    setState(() {
                      remolque1InputStatus = Colors.grey;
                    });
                  }
                  if (Remolque2Controller.text == "") {
                    setState(() {
                      remolque2InputStatus = Colors.red;
                      err++;
                    });
                  } else {
                    setState(() {
                      remolque2InputStatus = Colors.grey;
                    });
                  }
                  if (tipoRemolque1 == tipoRemolque.first) {
                    setState(() {
                      dropdwnremolque1InputStatus = Colors.red;
                      err++;
                    });
                  } else {
                    setState(() {
                      dropdwnremolque1InputStatus = Colors.grey;
                    });
                  }
                  if (tipoRemolque2 == tipoRemolque.first) {
                    setState(() {
                      dropdwnremolque2InputStatus = Colors.red;
                      err++;
                    });
                  } else {
                    setState(() {
                      dropdwnremolque2InputStatus = Colors.grey;
                    });
                  }
                  if (err > 0) {
                    _showAlertDialog(context, "Ingresa todos los campos");
                  } else {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: const Text('Nuevo Registro'),
                        content:
                            Text('¿Registrar nueva ' + TipoRegistro1 + '?'),
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
                } else {
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
                  if (Remolque1Controller.text == "") {
                    setState(() {
                      remolque1InputStatus = Colors.red;
                      err++;
                    });
                  } else {
                    setState(() {
                      remolque1InputStatus = Colors.grey;
                    });
                  }
                  if (tipoRemolque1 == tipoRemolque.first) {
                    setState(() {
                      dropdwnremolque1InputStatus = Colors.red;
                      err++;
                    });
                  } else {
                    setState(() {
                      dropdwnremolque1InputStatus = Colors.grey;
                    });
                  }
                  if (err > 0) {
                    _showAlertDialog(context, "Ingresa todos los campos");
                  } else {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: const Text('Nuevo Registro'),
                        content:
                            Text('¿Registrar nueva ' + TipoRegistro1 + '?'),
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
