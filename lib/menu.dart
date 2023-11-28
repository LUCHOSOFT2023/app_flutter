// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:luchosoft_api/listar.dart';
import 'package:luchosoft_api/login.dart';
import 'package:luchosoft_api/registrar.dart';

class menu extends StatelessWidget {
  const menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu'),
          backgroundColor: const Color.fromARGB(255, 177, 4, 4),
        ),
        body: const Column(
          children: [
            Center(
              child: Text(
                'Bienvenido a Donde Lucho',
                style: TextStyle(
                    fontSize: 35, color: Color.fromARGB(255, 218, 209, 92)),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(180, 138, 0, 0),
          child: ListView(
            children: [
              const SizedBox(
                  height: 80,
                  child: DrawerHeader(
                      decoration:
                          BoxDecoration(color: Color.fromARGB(213, 255, 0, 0)),
                      child: Text(
                        'OPCIONES',
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        textAlign: TextAlign.center,
                      ))),
              ListTile(
                leading: const Icon(
                  Icons.add_circle,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                title: const Text(
                  'Agregar Producto',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  final route =
                      MaterialPageRoute(builder: (context) => const registrar());
                  Navigator.push(context, route);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.assignment,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                title: const Text(
                  'Listar Productos',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  final route =
                      MaterialPageRoute(builder: (context) => const Listar());
                  Navigator.push(context, route);
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => login()));
          },
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          child: const Icon(Icons.login),
        ));
  }
}
