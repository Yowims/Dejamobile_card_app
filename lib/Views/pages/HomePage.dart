import 'package:flutter/material.dart';
import 'package:dejamobile_card_app/Controllers/AuthController.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final auth = new AuthController();
  String emailVal, mdpVal;
  Map<String, dynamic> formData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connexion"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // EMAIL
            TextFormField(
              validator: (value) {
                if (value.isEmpty) return 'Le champ ne doit pas être vide.';
                if (auth.isNotEmail(value))
                  return 'la valeur rentrée n\'est pas un email valide.';
                emailVal = value;
                return null;
              },
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            // MOT DE PASSE
            TextFormField(
              validator: (mdp) {
                if (mdp.isEmpty) return 'Le champ ne doit pas être vide.';
                mdpVal = mdp;
                return null;
              },
              decoration: InputDecoration(
                hintText: "Mot de passe",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate())
                  formData = {"email": emailVal, "password": mdpVal};
                auth.login(context, formData);
              },
              child: Text("Valider"),
            )
          ],
        ),
      ),
    );
  }
}
