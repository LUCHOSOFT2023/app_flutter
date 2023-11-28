// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'dart:convert';
import 'package:http/http.dart' as http; //el as se utiliza para asignar alias

import 'package:flutter/material.dart';
import 'package:luchosoft_api/menu.dart';

class registrar extends StatefulWidget {
  const registrar({super.key});

  @override
  State<registrar> createState() => _registrarState();
}

class _registrarState extends State<registrar> {
  TextEditingController id_categoria = TextEditingController();
  TextEditingController nombre_categoriaInsumo = TextEditingController();

  Future<void> senData(int? id_categoria, String nombre_categoriaInsumo) async {
    final apiUrl = Uri.parse('https://luchosoftapi.onrender.com/api/insumos');

    // ignore: unused_local_variable
    final response = await http.post(apiUrl,
        body: jsonEncode({
          'id_categoriaInsumo': id_categoria,
          'nombre_categoriaInsumo': nombre_categoriaInsumo
        }),
        headers: {
          'Content-Type': 'application/json',
        });
  }

  final GlobalKey<FormState> insumos = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de insumos'),
        backgroundColor: const Color.fromARGB(255, 177, 4, 4),
      ),
      body: Center(
        child: Card(
          color: const Color.fromARGB(157, 189, 186, 186),
          margin: const EdgeInsets.all(40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 70),
                  child: Form(
                    key: insumos,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: id_categoria,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.key,
                              color: Color.fromARGB(213, 255, 0, 0),
                            ),
                            labelText: 'Id',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: nombre_categoriaInsumo,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.hdr_auto,
                              color: Color.fromARGB(213, 255, 0, 0),
                            ),
                            labelText: 'Nombre Categoría',
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(213, 255, 0, 0))),
                            onPressed: () {
                              if (id_categoria.text.isEmpty ||
                                  nombre_categoriaInsumo.text.isEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content:
                                            const Text('No se pudo registrar'),
                                        actions: [
                                          TextButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Color.fromARGB(
                                                            213, 255, 0, 0))),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const registrar()));
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                senData(int.parse(id_categoria.text),
                                    nombre_categoriaInsumo.text);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Exito'),
                                        content: const Text('Registro exitoso'),
                                        actions: [
                                          TextButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Color.fromARGB(
                                                            213, 255, 0, 0))),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const menu()));
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    });
                              }
                            },
                            child: const Text('Registrar'))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
