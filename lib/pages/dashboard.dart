import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:forsis/theme/theme.dart';
import 'package:forsis/pages/login_page.dart';
import 'package:forsis/pages/new_record.dart';

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

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: CupertinoButton.filled(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewRecord()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add_circle_outline), // icon
                      Text("Nuevo Registro"), // text
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage())),
            ),
          ),
        ],
      ),
    );
  }
}
