import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forsis/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:fluttericon/font_awesome5_icons.dart';

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
  var IconTipoUnidad;
  bool fullSencillo = true;
  bool tractoInfo = true;
  bool contenedores = false;
  bool remolque2Visible = false;
  bool contenedoresVisible = false;
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
      if (entradasYSalidas[0]['Full'] == "FULL") {
        remolque2Visible = true;
      }
      if (entradasYSalidas[0]['TipoUnidad1'] == "Tracto") {
        IconTipoUnidad = const Icon(
          FontAwesome5.truck,
          size: 50.0,
        );
      } else if (entradasYSalidas[0]['TipoUnidad1'] == "Utilitario") {
        IconTipoUnidad = const Icon(
          Icons.directions_car_filled_rounded,
          size: 50.0,
        );
        fullSencillo = false;
        tractoInfo = false;
      } else if (entradasYSalidas[0]['TipoUnidad'] == "Externa") {
        fullSencillo = false;
        tractoInfo = false;
      }
      if (entradasYSalidas[0]['TipoRemolque'] == 'Porta de 20"' ||
          entradasYSalidas[0]['TipoRemolque'] == 'Porta de 40"' ||
          entradasYSalidas[0]['TipoRemolque'] == 'Porta de 53"') {
        contenedoresVisible = true;
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
                            const Divider(
                              height: 20,
                              thickness: 3,
                            ),
                            Card(
                              color: Colors.white70,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: const Icon(
                                      Icons.account_circle_rounded,
                                      size: 50.0,
                                    ),
                                    title: const Text('Operador'),
                                    subtitle:
                                        Text(entradasYSalidas[0]['Empleado']),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 20,
                              thickness: 3,
                            ),
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
                                          leading: IconTipoUnidad,
                                          title: const Text('Tipo de Unidad:'),
                                          subtitle: Text(entradasYSalidas[0]
                                              ['TipoUnidad1']),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 20,
                              thickness: 3,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    color: Colors.white70,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          title: const Text('Economico:'),
                                          subtitle: Text(
                                              entradasYSalidas[0]['Economico']),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: fullSencillo,
                                  child: Expanded(
                                    child: Card(
                                      color: Colors.white70,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            title: const Text('Unidad en:'),
                                            subtitle: Text(
                                                entradasYSalidas[0]['Full']),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: tractoInfo,
                              child: Row(
                                children: [
                                  const Divider(
                                    height: 20,
                                    thickness: 3,
                                  ),
                                  Expanded(
                                    child: Card(
                                      color: Colors.white70,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            title: const Text('Remolque 1:'),
                                            subtitle: Text(entradasYSalidas[0]
                                                ['Remolque1']),
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
                                            title:
                                                const Text('Tipo de remolque:'),
                                            subtitle: Text(entradasYSalidas[0]
                                                ['TipoRemolque']),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: remolque2Visible,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Card(
                                      color: Colors.white70,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            title: const Text('Remolque 2:'),
                                            subtitle: Text(entradasYSalidas[0]
                                                ['Remolque2']),
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
                                            title:
                                                const Text('Tipo de remolque:'),
                                            subtitle: Text(entradasYSalidas[0]
                                                ['TipoRemolque']),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: contenedoresVisible,
                                  child: Expanded(
                                    child: Card(
                                      color: Colors.white70,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            title: const Text('Contenedores:'),
                                            subtitle: Text(entradasYSalidas[0]
                                                ['Contenedores']),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: tractoInfo,
                              child: Row(
                                children: [
                                  const Divider(
                                    height: 20,
                                    thickness: 3,
                                  ),
                                  Expanded(
                                    child: Card(
                                      color: Colors.white70,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            title: Text(entradasYSalidas[0]
                                                ['NRefacciones']),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              height: 20,
                              thickness: 3,
                            ),
                            Card(
                              color: Colors.white70,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    title: const Text('Observaciones'),
                                    subtitle: Text(
                                        entradasYSalidas[0]['Observaciones']),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
