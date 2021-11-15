import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectbnk/blocs/login/login_bloc.dart';
import 'package:projectbnk/configs/colors.dart';
import 'package:projectbnk/network/apis.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> LoginBloc(LoginInitState(), Api()))
      ],
      child:  const BodyLogin(),
    );
  }
}

class BodyLogin extends StatefulWidget {
  const BodyLogin({Key? key}) : super(key: key);

  @override
  _BodyLoginState createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  LoginBloc? loginBloc;

  Api? api;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        color: Colors.white,
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Image.asset(
                  'meo.jpg',
                  height: 100,
                  width: 180,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 35, 0, 6),
                  child: Text("Welcome back !",
                      style: TextStyle(fontSize: 22, color: Color(0xff333333))),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: email,
                  onChanged: (String? value)  {
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter';
                    } else if (!RegExp(
                        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+(.)+[a-zA-Z0-9-]*$')
                        .hasMatch(value)) {
                      return 'Please a valid Email';
                    }
                  },
                  onSaved: (String? value) {
                    email = value as TextEditingController;
                  },
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    hintText: "Email",
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color(0xffCED0D2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  onChanged: (value) {},
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter Password';
                    } else if (value!.length < 6) {
                      return 'password is too short ';
                    }
                    return null;
                  },
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Mật khẩu",
                    labelText: "Mật khẩu",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: kPrimaryColor,
                    ),
                      border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xffCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
                Container(
                  constraints: BoxConstraints.loose(
                    const Size(double.infinity, 35),
                  ),
                  alignment: AlignmentDirectional.centerEnd,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.075,),
                SizedBox(
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: ElevatedButton(
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          return loginBloc!.add(LoginButtonPressed(
                              email: email.text, password: password.text));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

