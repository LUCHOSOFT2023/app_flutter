import 'package:flutter/material.dart';
import 'package:luchosoft_api/menu.dart';

class Usuario {
  final String nombre;
  final String contrasena;

  Usuario(this.nombre, this.contrasena);
}

// ignore: must_be_immutable
class login extends StatelessWidget {
  login({super.key});

  List<Usuario> login1 = [Usuario('Maria', '123m')];

  final GlobalKey<FormState> formUsuario = GlobalKey<FormState>();
  final usuario = TextEditingController();
  final contra = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Donde Lucho'),
          backgroundColor: const Color.fromARGB(255, 199, 0, 0),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Form(
              key: formUsuario,
              child: Column(
                children: [
                  TextFormField(
                    controller: usuario,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Usuario',
                        hintText: 'Usuario',
                        helperText: 'Usuario'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: contra,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Contraseña',
                        hintText: 'Contraseña',
                        helperText: 'Contraseña'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 165, 0, 5)),
                      ),
                      onPressed: () {
                        String nombre = (usuario.text);
                        String pasword = (contra.text);
                        if (nombre == '' || pasword == '') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'Usuario y/o constraseña incorrecta'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Aceptar'))
                                  ],
                                );
                              });
                        } else if (nombre != 'Maria' || pasword != '123m') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'Usuario y/o constraseña incorrecta'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Aceptar'))
                                  ],
                                );
                              });
                        } else {
                          bool validar(String usuario, String contra) {
                            Usuario encontrado =
                                login1.lastWhere((u) => u.nombre == usuario);
                            // ignore: unnecessary_null_comparison
                            return encontrado.nombre != null &&
                                encontrado.contrasena == contra;
                          }

                          if (validar(usuario.text, contra.text)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const menu()));
                          }
                        }
                        //   showDialog(context: context,  builder: (context){
                        //     return AlertDialog(
                        //       title: const Text('Error'),
                        //       content: const Text('Usuario y/o constraseña incorrecta'),
                        //       actions: [
                        //         TextButton(onPressed:
                        //         (){
                        //           Navigator.pop(context);
                        //         }, child: const Text('Aceptar'))
                        //       ],
                        //     );
                        //   });
                        // }
                      },
                      child: const Text('Entrar'))
                ],
              ),
            ),
          ),
        ));
  }
}
