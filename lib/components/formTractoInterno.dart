import 'package:flutter/material.dart';

class formTractoInterno extends StatefulWidget {
  const formTractoInterno({super.key});

  @override
  State<formTractoInterno> createState() => formTractoInternoState();
}

class formTractoInternoState extends State<formTractoInterno> {
  bool full = false;
  bool remolque2 = false;

  bool checkboxValue1 = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SwitchListTile(
          tileColor: const Color.fromARGB(255, 255, 255, 255),
          activeColor: Colors.red,
          title: const Text('FULL'),
          value: full,
          onChanged: (bool? value) {
            setState(() {
              full = value!;
              remolque2 = value;
            });
          },
        ),
        const SizedBox(
          width: 250,
          child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Economico",
              )),
        ),
        const SizedBox(height: 10),
        const SizedBox(
          width: 250,
          child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Remolque 1",
              )),
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: remolque2,
          child: const SizedBox(
            width: 250,
            child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Remolque 2",
                )),
          ),
        ),
        const SizedBox(height: 10),
        const Text("Elementos"),
        const SizedBox(height: 10),
        Column(
          children: <Widget>[
            CheckboxListTile(
              value: checkboxValue1,
              onChanged: (bool? value) {
                setState(() {
                  checkboxValue1 = value!;
                });
              },
              title: const Text('Headline'),
            ),
            const Divider(height: 0),
          ],
        ),
      ],
    );
  }
}
