// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luchosoft_api/registrar.dart';

class Listar extends StatefulWidget {
  const Listar({super.key});

  @override
  State<Listar> createState() => _ListarState();
}

class _ListarState extends State<Listar> {
  List<dynamic> data = []; //almacenamos los datos obtenidos de la api
  List<dynamic> filteredData = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getInsumos();
    // Agrega un listener para detectar cambios en el campo de búsqueda
    searchController.addListener(() {
      _filtrarDatos();
    });
  }

  Future<void> getInsumos() async {
    final response = await http
        .get(Uri.parse('https://luchosoftapi.onrender.com/api/insumos'));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body);
      setState(() {
        data = decodedData['insumo'] ?? [];
        filteredData = data;
      });
    } else {
      AlertDialog(
        title: const Text('Error no se ha podido conectar con la API'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ok'))
        ],
      );
      // ignore: avoid_print
      print('error la api no cargaaa mmw ${response.statusCode}');
    }
  }

  // Método para filtrar la lista según el término de búsqueda
  void _filtrarDatos() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredData = data
          .where((item) => item['nombre_categoriaInsumo']
              .toString()
              .toLowerCase()
              .contains(query))
          .toList();
    });
  }

  Future<void> _guardarCambios(int id, String nombre) async {
    final apiUrl = Uri.parse(
        'https://luchosoftapi.onrender.com/api/insumos?id_categoriaInsumo=$id');

    // ignore: unused_local_variable
    final response = await http.put(apiUrl,
        body: jsonEncode(
            {'nombre_categoriaInsumo': nombre, 'id_categoriaInsumo': id}),
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      setState(() {
        getInsumos();
      });
    } else {
      // ignore: avoid_print
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<void> eliminar(int id) async {
    final apiUrl = Uri.parse(
        'https://luchosoftapi.onrender.com/api/insumos?id_categoriaInsumo=$id');

    // ignore: unused_local_variable
    final response = await http.delete(apiUrl);
    if (response.statusCode == 200) {
      setState(() {
        getInsumos();
      });
    } else {
      // ignore: avoid_print
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nombre_Categoria = TextEditingController();
    final id_controller = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Insumos registrados'),
          backgroundColor: const Color.fromARGB(255, 177, 4, 4),
          actions: [
            // Agrega un campo de búsqueda en la barra de aplicación
            Container(
              margin: const EdgeInsets.only(left: 100),
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ),
            // Agrega un campo de búsqueda en la barra de aplicación
            Expanded(
              child: TextField(
                style:
                    const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                controller: searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        body: filteredData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      title:
                          Text(filteredData[index]['nombre_categoriaInsumo']),
                      subtitle: Text(_getEstadoText(
                          filteredData[index]['estado_categoriaInsumo'])),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Color.fromARGB(255, 255, 200, 100),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Editar'),
                                      content: Container(
                                        padding: const EdgeInsets.all(5),
                                        height: 150,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    right: 50),
                                                child: const Text('ID:')),
                                            TextField(
                                              controller: id_controller,
                                              enabled: false,
                                              decoration: InputDecoration(
                                                  labelText: filteredData[index]
                                                          ['id_categoriaInsumo']
                                                      .toString(),
                                                  border:
                                                      const OutlineInputBorder(),
                                                  hintText: "Nombre"),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextField(
                                              controller: nombre_Categoria,
                                              decoration: InputDecoration(
                                                  labelText: filteredData[index]
                                                      [
                                                      'nombre_categoriaInsumo'],
                                                  border:
                                                      const OutlineInputBorder(),
                                                  hintText: "Nombre"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              int id = filteredData[index]
                                                  ['id_categoriaInsumo'];
                                              _guardarCambios(
                                                  id, nombre_Categoria.text);

                                              Navigator.pop(context);
                                            },
                                            child: const Text('Guardar')),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 255, 0, 0),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Borrar'),
                                      content: const Text(
                                          'Esta seguro de eliminar?'),
                                      actions: [
                                        TextButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color.fromARGB(
                                                          213, 255, 0, 0))),
                                          onPressed: () {
                                            AlertDialog(
                                              title: const Text(
                                                  'Eliminado correctamente'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('ok'))
                                              ],
                                            );
                                            int id = filteredData[index]
                                                ['id_categoriaInsumo'];
                                            eliminar(id);
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Borrar',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancelar',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const registrar()));
          },
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          child: const Icon(Icons.add),
        ));
  }
}

String _getEstadoText(bool estado) {
  return estado ? 'Activo' : 'Inactivo';
}
