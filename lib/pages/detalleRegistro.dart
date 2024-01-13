import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forsis/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

var entradasYSalidas = [];
var ID;

class detalleRegistro extends StatelessWidget {
  String Id_Entrada;
  detalleRegistro(this.Id_Entrada, {super.key});

  @override
  Widget build(BuildContext context) {
    ID = Id_Entrada;
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
  var iDentrada = ID;
  var IconTipoRegistro;
  getEntradaYSalida(String iDEntrada) async {
    print(iDentrada);
    var url = Uri.http("192.168.1.209", '/entradasysalidas/getRegistro.php', {
      'q': {'http'}
    });
    var response = await http.post(url, body: {
      "Id_Registro": iDEntrada,
    });
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
      if (entradasYSalidas[0]['TipoRegistro'] == "Entrada") {
        IconTipoRegistro = const Icon(
          Icons.arrow_downward_outlined,
          size: 50.0,
        );
      } else {
        IconTipoRegistro = const Icon(
          Icons.arrow_upward_outlined,
          size: 50.0,
        );
      }
      return entradasYSalidas;
    }
  }

  @override
  void initState() {
    super.initState();
    getEntradaYSalida(iDentrada);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: ListView(
          children: [
            Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      //logo
                      Image.asset(
                        entradasYSalidas[0]['Logo'],
                        height: 100,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Card(
                                color: Colors.white70,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: IconTipoRegistro,
                                      title: const Text('Tipo de Registro'),
                                      subtitle: Text(
                                          entradasYSalidas[0]['TipoRegistro']),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Card(
                                      color: Colors.white70,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Image.asset(
                                              entradasYSalidas[0]['Logo'],
                                              height: 50,
                                            ),
                                            title: const Text('Unidad:'),
                                            subtitle: Text(entradasYSalidas[0]
                                                ['TipoUnidad']),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      color: Colors.white70,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Image.asset(
                                              entradasYSalidas[0]['Logo'],
                                              height: 50,
                                            ),
                                            title:
                                                const Text('Tipo de Unidad:'),
                                            subtitle: Text(entradasYSalidas[0]
                                                ['TipoUnidad1']),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
