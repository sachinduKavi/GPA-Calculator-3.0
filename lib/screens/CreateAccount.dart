import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Domain.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ignore: prefer_final_fields
  late String _name,
      _email,
      _password,
      _password02,
      _university,
      _degree,
      _mobile;

// Widget formText method that returns a widget
  Widget formName(String hintText) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      maxLength: 20,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please Enter Value";
        }
        return null;
      },
      onSaved: (text) {
        print(text);
        _name = text!;
      },
      decoration: InputDecoration(
          hintText: hintText, labelText: "Enter your $hintText"),
    );
  }

  Widget formEmail(String hintText) {
    return TextFormField(
      maxLength: 35,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please Enter Value";
        }
        return null;
      },
      onSaved: (text) {
        print(text);
        _email = text!;
      },
      decoration: InputDecoration(
          hintText: hintText, labelText: "Enter your $hintText"),
    );
  }

  Widget formMobile(String hintText) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.words,
      maxLength: 20,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please Enter Value";
        }
        return null;
      },
      onSaved: (text) {
        print(text);
        _mobile = text!;
      },
      decoration: InputDecoration(
          hintText: hintText, labelText: "Enter your $hintText"),
    );
  }

  Widget formUniversity(String hintText) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      maxLength: 30,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please Enter Value";
        }
        return null;
      },
      onSaved: (text) {
        print(text);
        _university = text!;
      },
      decoration: InputDecoration(
          hintText: hintText, labelText: "Enter your $hintText"),
    );
  }

  Widget formDegree(String hintText) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      maxLength: 30,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please Enter Value";
        }
        return null;
      },
      onSaved: (text) {
        print(text);
        _degree = text!;
      },
      decoration: InputDecoration(
          hintText: hintText, labelText: "Enter your $hintText"),
    );
  }

  Widget formPassword(String hintText) {
    return TextFormField(
      maxLength: 20,
      obscureText: true,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please Enter Value";
        }
        return null;
      },
      onSaved: (text) {
        print(text);
        _password = text!;
      },
      decoration: InputDecoration(
          hintText: hintText, labelText: "Enter your $hintText"),
    );
  }

  Widget formPassword02(String hintText) {
    return TextFormField(
      maxLength: 20,
      obscureText: true,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please Enter Value";
        }
        return null;
      },
      onSaved: (text) {
        print(text);
        _password02 = text!;
      },
      decoration: InputDecoration(
          hintText: hintText, labelText: "Enter your $hintText"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "CREATE NEW ACCOUNT",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      )),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: formName("User Name"),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: formEmail("Email"),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: formMobile("Mobile"),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: formPassword("Password"),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: formPassword02("Confirm Password"),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: formUniversity("University"),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: formDegree("Degree Program"),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print("Valid Form");
                            _formKey.currentState!.save();
                            postData();
                          } else {
                            print("Invalid Form");
                          }
                        },
                        child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(fontSize: 25),
                            ))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future postData() async {
    // Waiting circle
    if (_password == _password02) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          });
      // Posting values in the sever to store in the database
      try {
        var response = await http
            .post(Uri.parse('${Domain.mainDomain}users/addUserDetails'), body: {
          "userName": _name.trim(),
          "email": _email.trim().toLowerCase(),
          "password": _password.trim(),
          "university": _university.trim(),
          "degree": _degree.trim(),
          "mobile": _mobile.trim()
        });
        print(response);
        if (response.statusCode == 201) {
          print(response.body);
        } else {
          print("Error Occur");
        }
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("loginPage");
      } catch (exception) {
        print(exception);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                icon: const Icon(
                  Icons.wifi_tethering_error_sharp,
                  color: Colors.red,
                  size: 45,
                ),
                title: const Text(
                  "Sorry, can't connect to the server, please check your internet connection and try again.",
                  style: TextStyle(fontSize: 22, color: Colors.red),
                ),
                content: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed("loginPage");
                    },
                    child: Text("Ok")),
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              icon: Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 50,
              ),
              title: Text(
                "Password Mismatched",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            );
          });
    }
  }
}
