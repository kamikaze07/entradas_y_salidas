import 'dart:convert';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:forsis/theme/theme.dart';
import 'package:http/http.dart' as http;
import 'package:forsis/pages/detalleRegistro.dart';

final search = TextEditingController();

class LauncherPage extends StatelessWidget {
  const LauncherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appTheme.colorScheme.secondary,
        title: const Text('Entradas Y Salidas'),
      ),
      drawer: _MenuPrincipal(),
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

  _searchEntradasYSalidas(String search) async {
    var url = Uri.http(
        "192.168.1.209", '/entradasysalidas/searchEntradasYSalidas.php', {
      'q': {'http'}
    });
    var response = await http.post(url, body: {
      "search": search,
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
      return entradasYSalidas;
    }
  }

  Future refresh() async {
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
    }
  }

  String searchEntradasYSalidas(String search) {
    setState(() {
      entradasYSalidas.clear();
      _searchEntradasYSalidas(search);
    });
    return search;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: AnimSearchBar(
            width: 400,
            textController: search,
            onSuffixTap: () {
              setState(() {
                search.clear();
              });
            },
            helpText: "Buscar...",
            onSubmitted: searchEntradasYSalidas),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.builder(
              itemCount: entradasYSalidas.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return detalleRegistro(
                              entradasYSalidas[index]['Id_Entrada']);
                        }),
                      );
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    leading: Image.asset(entradasYSalidas[index]['Logo'],
                        height: 30),
                    title: Text(entradasYSalidas[index]['TipoRegistro'] +
                        " - " +
                        entradasYSalidas[index]['TipoUnidad1'] +
                        " " +
                        entradasYSalidas[index]['Economico']),
                    trailing: Text(entradasYSalidas[index]['Fecha'].toString()),
                  ),
                );
              }),
        ));
  }
}

class _MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final accentColor = appTheme.currentTheme.colorScheme.secondary;
    return Drawer(
      child: Column(
        children: [
          SafeArea(
            child: Image.asset(
              'lib/images/logo_forsis.png',
              height: 100,
            ),
          ),
          ListTile(
              leading: Icon(
                Icons.add,
                color: accentColor,
              ),
              title: const Text('Nuevo Registro'),
              onTap: () {
                Navigator.of(context).pushNamed('/new_record');
              }),
          SafeArea(
            top: false,
            left: false,
            right: false,
            bottom: true,
            child: ListTile(
              leading: Icon(
                Icons.add_to_home_screen,
                color: accentColor,
              ),
              title: const Text('Custom theme'),
              trailing: Switch.adaptive(
                  value: appTheme.customTheme,
                  activeColor: accentColor,
                  onChanged: (value) => appTheme.customTheme = value),
            ),
          ),
          SafeArea(
            child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: accentColor,
                ),
                title: const Text("Salir"),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/Login', (Route<dynamic> route) => false);
                }),
          ),
        ],
      ),
    );
  }
}
