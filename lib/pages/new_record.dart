import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forsis/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:forsis/components/formTractoInterno.dart';
import 'package:forsis/components/formUtilitarioForsis.dart';

class NewRecord extends StatelessWidget {
  const NewRecord({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appTheme.colorScheme.secondary,
        title: const Text('Nuevo Registro'),
      ),
      resizeToAvoidBottomInset: false,
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: const [
            SizedBox(height: 20),
            Text("Unidad de Entrada o Salida:"),
            RadioEntradaSalida(),
            SizedBox(height: 10),
            Text("Tipo de Unidad:"),
            SizedBox(height: 10),
            DropdownTipoUnidad(),
          ],
        ),
      ),
    );
  }
}

//Radios Entrada o Salida
enum TipoRegistro { entrada, salida }

var TipoRegistro1 = "Entrada";
var TipoUnidad;
var TipoUnidadInterna;

class RadioEntradaSalida extends StatefulWidget {
  const RadioEntradaSalida({super.key});

  @override
  State<RadioEntradaSalida> createState() => _RadioEntradaSalidaState();
}

class _RadioEntradaSalidaState extends State<RadioEntradaSalida> {
  TipoRegistro? _character = TipoRegistro.entrada;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: const Text('Entrada'),
            leading: Radio<TipoRegistro>(
              value: TipoRegistro.entrada,
              groupValue: _character,
              onChanged: (TipoRegistro? value) {
                setState(() {
                  _character = value;
                  TipoRegistro1 = "Entrada";
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text('Salida'),
            leading: Radio<TipoRegistro>(
              value: TipoRegistro.salida,
              groupValue: _character,
              onChanged: (TipoRegistro? value) {
                setState(() {
                  _character = value;
                  TipoRegistro1 = "Salida";
                });
              },
            ),
          ),
        )
      ],
    );
  }
}

//Select TipoUnidad
const List<String> tipoUnidad = <String>[
  'Selecciona el Tipo de Unidad',
  'Forsis',
  'Externa'
];

const List<String> tipoUnidadInterna = <String>[
  'Selecciona el Tipo de Unidad',
  'Tracto',
  'Utilitario'
];

class DropdownTipoUnidad extends StatefulWidget {
  const DropdownTipoUnidad({super.key});

  @override
  State<DropdownTipoUnidad> createState() => _DropdownTipoUnidadState();
}

class _DropdownTipoUnidadState extends State<DropdownTipoUnidad> {
  String dropdownValue = tipoUnidad.first;
  String dropdownTipoUnidadInterna = tipoUnidadInterna.first;
  bool forsisVisible = false;
  bool externaVisible = false;
  bool tractoInternoVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownMenu<String>(
          width: 250,
          initialSelection: tipoUnidad.first,
          onSelected: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
              TipoUnidad = value;
              if (value != tipoUnidad.first) {
                switch (value) {
                  case "Forsis":
                    setState(() {
                      forsisVisible = true;
                      externaVisible = false;
                    });
                    break;
                  case "Externa":
                    setState(() {
                      forsisVisible = false;
                      externaVisible = true;
                    });
                    break;
                }
              } else {
                setState(() {
                  forsisVisible = false;
                  externaVisible = false;
                });
              }
            });
          },
          dropdownMenuEntries:
              tipoUnidad.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: forsisVisible,
          //Tipo de unidad Interna de Forsis
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Unidad interna de Forsis"),
                SizedBox(height: 10),
                DropdownMenu<String>(
                  width: 250,
                  initialSelection: tipoUnidadInterna.first,
                  onSelected: (String? value) {
                    setState(() {
                      dropdownTipoUnidadInterna = value!;
                    });
                    if (value == "Tracto") {
                      setState(() {
                        tractoInternoVisible = true;
                        externaVisible = false; //
                        TipoUnidadInterna = "Tracto";
                      });
                    } else {
                      tractoInternoVisible = false;
                      externaVisible = true;
                      TipoUnidadInterna = "Utilitario";
                    }
                  },
                  dropdownMenuEntries: tipoUnidadInterna
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: tractoInternoVisible,
                  child: formTractoInterno(),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: externaVisible,
          //Tipo de unidad Externa a Forsis
          child: formUtilitarioForsis(),
        ),
      ],
    );
  }
}
