import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterProfessional extends StatefulWidget {
  const RegisterProfessional({Key? key}) : super(key: key);

  @override
  State<RegisterProfessional> createState() =>
      _RegisterProfessionalScreenState();
}

class _RegisterProfessionalScreenState extends State<RegisterProfessional> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void registerProfessional() async {

    bool validateFields() {
      if (nomController.text.isEmpty ||
          prenomController.text.isEmpty ||
          emailController.text.isEmpty ||
          companyController.text.isEmpty ||
          jobController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(
              content: Text('Veuillez remplir tous les champs.'),
            ))
            .closed
            .then((SnackBarClosedReason reason) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterProfessional()),
          );
        });
        return false;
      }
      return true;
    }

    if (!validateFields()) {
      return;
    }

    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(
              content: Text('Les deux mots de passe ne correspondent pas.'),
            ),
          )
          .closed
          .then((SnackBarClosedReason reason) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterProfessional()),
        );
      });

      return; // Arrêter l'exécution de la fonction
    }

    final url = Uri.parse(
        'https://3448-90-58-167-129.ngrok-free.app/registerProfessionnal');

    final body = jsonEncode({
      'name': nomController.text,
      'first_name': prenomController.text,
      'mail': emailController.text,
      'password': passwordController.text,
      'company_name': companyController.text,
      'job_name': jobController.text,
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      print('Inscription réussie');
    } else {
      final responseBody = utf8.decode(response.bodyBytes);
      final responseJson = jsonDecode(responseBody);
      print('Erreur lors de l\'inscription: ${responseJson['error']}');
    }
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    emailController.dispose();
    companyController.dispose();
    jobController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: RichText(
                    text: const TextSpan(
                        text: 'Inscription',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                        )),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 130,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border:
                                    Border.all(color: const Color(0xFFFBBC05)),
                                borderRadius: BorderRadius.circular(90),
                              ),
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/RegisterUsers');
                                },
                                child: const Text('Candidat'),
                              ),
                            ),
                            const Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 15.0)),
                            Container(
                              width: 130,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border:
                                    Border.all(color: const Color(0xFFFBBC05)),
                                borderRadius: BorderRadius.circular(90),
                              ),
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/RegisterSchool');
                                },
                                child: const Text('Centre / Ecole'),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 125,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: const Color(0xFFFBBC05)),
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: FilledButton.tonal(
                            onPressed: () {},
                            child: const Text('Professionnel'),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Form(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: nomController,
                                  decoration: const InputDecoration(
                                      hintText: 'Votre Nom',
                                      hintStyle: TextStyle(color: Colors.white),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 50.0),
                              Expanded(
                                child: TextFormField(
                                  controller: prenomController,
                                  decoration: const InputDecoration(
                                      hintText: 'Votre Prénom',
                                      hintStyle: TextStyle(color: Colors.white),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              hintText: 'Votre Mail',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: companyController,
                          decoration: const InputDecoration(
                              hintText: 'Le nom de l\'entreprise',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: jobController,
                          decoration: const InputDecoration(
                              hintText: 'Le nom de votre métier',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                              hintText: 'Mot de passe',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: confirmPasswordController,
                          decoration: const InputDecoration(
                              hintText: 'Confirmer le mot de passe',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Arrondir les coins
                            ),
                          ),
                          onPressed: () {
                            registerProfessional();
                            Navigator.of(context).pushNamed('/Auth');
                          },
                          child: Text(
                            'Incristpion'.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/Auth');
                          },
                          child: const Text(
                            'Avez-vous un compte ? Se connecter',
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
