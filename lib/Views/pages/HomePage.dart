import 'package:dejamobile_card_app/Views/pages/RegisterPage.dart';
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
                    formData = {"email": emailVal, "password": mdpVal};
                  if (emailVal == null || mdpVal == null) return null;
                  auth.login(context, formData);
                },
                child: Text("Valider"),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pas encore inscrit? "),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      "Cliquez ici!",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
