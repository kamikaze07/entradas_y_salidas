import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:forsis/theme/theme.dart';
import 'package:http/http.dart' as http;

List<String> entries = <String>[];

Future _GetUsuarios() async {
  var url = Uri.http(
      "192.168.1.209", '/entradasysalidas/getusuarios.php', {'q': '{http}'});
  var response = await http.get(url);
  entries = (jsonDecode(response.body) as List<dynamic>).cast<String>();
}

class LauncherPage extends StatelessWidget {
  const LauncherPage({super.key});

  @override
  Widget build(BuildContext context) {
    var get = _GetUsuarios();
    print(get);
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appTheme.colorScheme.secondary,
        title: const Text('Entradas Y Salidas'),
      ),
      drawer: _MenuPrincipal(),
      body: _ListView(),
    );
  }
}

class _ListView extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 80,
            child: ListTile(
              title: const Text("Usuario"),
              subtitle: Text(entries[index]),
            ),
          );
        });
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
              Icons.lightbulb_outline,
              color: accentColor,
            ),
            title: const Text('Dark Mode'),
            trailing: Switch.adaptive(
                value: appTheme.darkTheme,
                activeColor: accentColor,
                onChanged: (value) => appTheme.darkTheme = value),
          ),
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
          )
        ],
      ),
    );
  }
}
