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
  final economicoController = TextEditingController();
  final remolque1Controller = TextEditingController();
  final remolque2Controller = TextEditingController();
  final observacionesController = TextEditingController();
  final contenedoresController = TextEditingController();
  final operadorController = TextEditingController();
  String tipoRemolque1 = tipoRemolque.first;
  bool full = false;
  bool remolque2 = false;
  bool fullRefacc = false;
  bool checkboxRefaccion1 = false;
  bool checkboxRefaccion2 = false;
  bool checkboxRefaccion3 = false;
  bool checkboxRefaccion4 = false;
  bool contenedoresVisible = false;
  var economicoInputStatus = Colors.grey;
  var remolque1InputStatus = Colors.grey;
  var remolque2InputStatus = Colors.grey;
  var dropdwnremolque1InputStatus = Colors.grey;
  var dropdwnremolque2InputStatus = Colors.grey;
  var contenedoresInputStatus = Colors.grey;
  var operadorInputStatus = Colors.grey;

  @override
  void dispose() {
    economicoController.dispose();
    remolque1Controller.dispose();
    remolque2Controller.dispose();
    observacionesController.dispose();
    contenedoresController.dispose();
    operadorController.dispose();
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
    var nContenedores = "";
    var full1;
    if (full) {
      full1 = "FULL";
    } else {
      full1 = "SENCILLO";
    }
    var Remolque2;
    if (remolque2Controller.text == "") {
      Remolque2 = "No";
    } else {
      Remolque2 = remolque2Controller.text;
    }
    if (contenedoresController.text == "") {
      nContenedores = "No";
    } else {
      nContenedores = contenedoresController.text;
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
        "forsis.ddns.net", '/entradasysalidas/nEntradaSalidaForsis.php', {
      'q': {'http'}
    });
    var response = await http.post(url, body: {
      "TipoRegistro": TipoRegistro1,
      "TipoUnidad": TipoUnidad,
      "TipoUnidadInterna": TipoUnidadInterna1,
      "Full": full1,
      "Economico": economicoController.text,
      "Empleado": operadorController.text,
      "Remolque1": remolque1Controller.text,
      "Remolque2": Remolque2,
      "TipoRemolque1": tipoRemolque1,
      "Contenedores": nContenedores,
      "NRefacciones": NRefacciones,
      "Observaciones": observacionesController.text,
    });
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
              });
            },
          ),
        ),
        SizedBox(
          width: 250,
          child: TextField(
            controller: economicoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Economico*",
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  economicoController.clear();
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: economicoInputStatus),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 250,
          child: TextField(
            controller: operadorController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Operador*",
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  operadorController.clear();
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: operadorInputStatus),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: remolque1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Remolque 1*",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      remolque1Controller.clear();
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
                  controller: remolque2Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Remolque 2*",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        remolque2Controller.clear();
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
        const SizedBox(
          height: 15,
          child: Text("Tipo Remolque*"),
        ),
        const SizedBox(height: 10),
        DropdownMenu<String>(
            initialSelection: tipoRemolque.first,
            onSelected: (String? value) {
              setState(() {
                tipoRemolque1 = value!;
                if (value == 'Porta de 20"' ||
                    value == 'Porta de 40"' ||
                    value == 'Porta de 53"') {
                  contenedoresVisible = true;
                } else {
                  contenedoresVisible = false;
                }
              });
            },
            dropdownMenuEntries:
                tipoRemolque.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
            inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: dropdwnremolque1InputStatus),
            ))),
        const SizedBox(height: 10),
        Visibility(
          visible: contenedoresVisible,
          child: TextField(
            controller: contenedoresController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Contenedores o Isotanques*",
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  contenedoresController.clear();
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: contenedoresInputStatus),
              ),
            ),
          ),
        ),
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
              controller: observacionesController,
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
                  if (economicoController.text == "") {
                    setState(() {
                      economicoInputStatus = Colors.red;
                      err++;
                    });
                  } else {
                    setState(() {
                      economicoInputStatus = Colors.grey;
                    });
                  }
                  if (operadorController.text == "") {
                    setState(() {
                      operadorInputStatus = Colors.red;
                      err++;
                    });
                  } else {
                    setState(() {
                      operadorInputStatus = Colors.grey;
                    });
                  }
                  if (remolque1Controller.text == "") {
                    setState(() {
                      remolque1InputStatus = Colors.red;
                      err++;
                    });
                  } else {
                    setState(() {
                      remolque1InputStatus = Colors.grey;
                    });
                  }
                  if (remolque2Controller.text == "") {
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
                  if (tipoRemolque1 == 'Porta de 20"' ||
                      tipoRemolque1 == 'Porta de 40"' ||
                      tipoRemolque1 == 'Porta de 53"') {
                    if (contenedoresController.text == "") {
                      contenedoresInputStatus = Colors.red;
                      err++;
                    } else {
                      contenedoresInputStatus = Colors.grey;
                    }
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
                  if (economicoController.text == "") {
                    setState(() {
                      economicoInputStatus = Colors.red;
                      err++;
                    });
                  } else {
                    setState(() {
                      economicoInputStatus = Colors.grey;
                    });
                  }
                  if (operadorController.text == "") {
                    setState(() {
                      operadorInputStatus = Colors.red;
                      err++;
                    });
                  } else {
                    setState(() {
                      operadorInputStatus = Colors.grey;
                    });
                  }
                  if (remolque1Controller.text == "") {
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
                  if (tipoRemolque1 == 'Porta de 20"' ||
                      tipoRemolque1 == 'Porta de 40"' ||
                      tipoRemolque1 == 'Porta de 53"') {
                    if (contenedoresController.text == "") {
                      contenedoresInputStatus = Colors.red;
                      err++;
                    } else {
                      contenedoresInputStatus = Colors.grey;
                    }
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
