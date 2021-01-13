import 'package:dejamobile_card_app/Controllers/AuthController.dart';
import 'package:dejamobile_card_app/Models/User.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final auth = new AuthController();
    String emailVal, mdpVal, nameVal;
    Map<String, dynamic> formData;

    return Scaffold(
      appBar: AppBar(
        title: Text("Inscription"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image.asset("assets/dejamobile.png"),
              // EMAIL
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    validator: (value) {
                      value = value.trim();
                      if (value.isEmpty)
                        return 'Le champ ne doit pas être vide.';
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
                ),
              ),
              SizedBox(
                height: 80,
              ),
              // NOM & PRENOM
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    validator: (name) {
                      if (name.isEmpty)
                        return 'Le champ ne doit pas être vide.';
                      nameVal = name;
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Nom Prénom",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              // MOT DE PASSE
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    obscureText: true,
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
                ),
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate())
                    formData = {
                      "email": emailVal,
                      "name": nameVal,
                      "password": mdpVal
                    };
                  User newUser = User.fromJson(formData);
                  auth.register(context, newUser);
                },
                child: Text("Valider"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
