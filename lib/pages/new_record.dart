import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forsis/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:radio_group_v2/radio_group_v2.dart';

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
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text("Unidad de Entrada o Salida:"),
              RadioEntradaSalida(),
              SizedBox(height: 10),
              Text("Tipo de Unidad:"),
              RadioTipoUnidad(),
              SizedBox(height: 10),
              UnidadForsis(),
            ],
          ),
        ),
      ),
    );
  }
}

//Radios Entrada o Salida
enum TipoRegistro { entrada, salida }

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
                });
              },
            ),
          ),
        )
      ],
    );
  }
}

//Radios Unidades
enum TipoUnidad { forsis, externa }

class RadioTipoUnidad extends StatefulWidget {
  const RadioTipoUnidad({super.key});

  @override
  State<RadioTipoUnidad> createState() => _RadioTipoUnidadState();
}

class _RadioTipoUnidadState extends State<RadioTipoUnidad> {
  TipoUnidad? _tipoUnidad = TipoUnidad.forsis;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: const Text('Forsis'),
            leading: Radio<TipoUnidad>(
              value: TipoUnidad.forsis,
              groupValue: _tipoUnidad,
              onChanged: (TipoUnidad? value) {
                setState(() {
                  _tipoUnidad = value;
                });
                setState(() {});
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text('Externa'),
            leading: Radio<TipoUnidad>(
              value: TipoUnidad.externa,
              groupValue: _tipoUnidad,
              onChanged: (TipoUnidad? value) {
                setState(() {
                  _tipoUnidad = value;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: _tipoUnidad == TipoUnidad.externa
              ? const ListTile(
                  title: Text('Something goes here!'),
                )
              : Container(),
        ),
      ],
    );
  }
}

//scaffold unidad Forsis
class UnidadForsis extends StatefulWidget {
  const UnidadForsis({super.key});
  @override
  UnidadForsisState createState() => UnidadForsisState();
}

class UnidadForsisState extends State<UnidadForsis> {
  bool _isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
            visible: _isVisible,
            child: Column(
              children: [
                const Text("test1"),
              ],
            ))
      ],
    );
  }
}

//scaffold unidad Externa
