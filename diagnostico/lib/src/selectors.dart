import 'package:flutter/material.dart';
import 'package:diagnostico/src/api/api.dart';
import 'dart:convert';
import 'map.dart'; // Asegúrate de importar el archivo donde está definido MapScreen

class Selectors extends StatefulWidget {
  const Selectors({super.key});

  @override
  SelectorsState createState() => SelectorsState();
}

class SelectorsState extends State<Selectors> {
  String? selectedValue;
  List<String> options = [];

  @override
  void initState() {
    super.initState();
    fetchOptions();
  }

  void fetchOptions() async {
    String? response = await Api.getTypes();
    final Map<String, dynamic> data = json.decode(response);
    setState(() {
      options = (data['types'] as List)
          .map((item) => item['name'] as String)
          .toList();
    });
    }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    void searchOptions() {
      if (selectedValue != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapScreen(locationType: selectedValue!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecciona un tipo de localización')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: screenSize.height * 0.8,
          width: screenSize.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(40),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Búsqueda de lugares cercanos'),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: selectedValue,
                    hint: const Text('Selecciona una opción'),
                    isExpanded: true,
                    items: options.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: searchOptions,
                    child: const Text('Buscar en el Mapa'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}