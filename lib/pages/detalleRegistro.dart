import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forsis/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class detalleRegistro extends StatelessWidget {
  String Id_Entrada;
  detalleRegistro(this.Id_Entrada, {super.key});

  String get getID {
    return Id_Entrada;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appTheme.colorScheme.secondary,
        title: const Text('Entradas Y Salidas'),
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  var entradasYSalidas = [];

  getEntradasYSalidas() async {
    var url =
        Uri.http("192.168.1.209", '/entradasysalidas/getEntradasYSalidas.php', {
      'q': {'http'}
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        entradasYSalidas = jsonDecode(response.body);
      });
      for (var i = 0; i < entradasYSalidas.length; i++) {
        if (entradasYSalidas[i]['TipoUnidad'] == "Forsis") {
          entradasYSalidas[i]['Logo'] = "lib/images/logo_forsis.png";
        } else {
          entradasYSalidas[i]['Logo'] = "lib/images/externaLogo.png";
        }
      }
      return entradasYSalidas;
    }
  }

  @override
  void initState() {
    super.initState();
    getEntradasYSalidas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
          ],
        ),
      )),
    );
  }
}
