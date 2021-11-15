
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectbnk/blocs/signup/signup_bloc.dart';
import 'package:projectbnk/blocs/signup/signup_bloc.dart';
import 'package:projectbnk/configs/colors.dart';
import 'package:projectbnk/network/apis.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupBloc(SignupInitState(), Api()))
      ],
      child: BodySignup(),
    );
  }
}
class BodySignup extends StatefulWidget {
  const BodySignup({Key? key}) : super(key: key);

  @override
  _BodySignupState createState() => _BodySignupState();
}

class _BodySignupState extends State<BodySignup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  List<String> items = ['Doctor', 'Security', 'Pumper', 'Trade', 'Singer', 'Policer',
    'Chemical Technology', 'Information Technology','MC', 'Travel', 'Nurse', 'Teacher',
    'Accountant', 'Engineer', 'Dramatist', 'Tour guide', 'Artist'] ;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  SignupBloc? signupBloc;

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
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 35, 0, 6),
                  child: Text("Welcome back !",
                      style: TextStyle(fontSize: 22, color: Color(0xff333333))),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: name,
                  onChanged: (String? value)  {
                    _formkey.currentState!.validate();
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
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    hintText: "Name",
                    labelText: "Name",
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color(0xffCED0D2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: email,
                  onChanged: (String? value)  {
                    _formkey.currentState!.validate();
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter';
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
                  onChanged: (value) {
                    _formkey.currentState!.validate();
                  },
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
                    hintText: "Password",
                    labelText: "Password",
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
                const SizedBox(height: 20,),
                TextFormField(
                  controller: phoneNumber,
                  onChanged: (String? value)  {
                    _formkey.currentState!.validate();
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
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    hintText: "Name",
                    labelText: "Name",
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color(0xffCED0D2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Container(
                    width: size.width * 0.9,
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownSearch(
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      items: items,
                      label: "Job",
                      selectedItem: items.first,
                      onChanged: print,
                    ),
                  ),
                ),

                Container(
                  constraints: BoxConstraints.loose(
                    const Size(double.infinity, 35),
                  ),
                  alignment: AlignmentDirectional.centerEnd,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.03,),
                SizedBox(
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: ElevatedButton(
                      child: const Text(
                        "Signup",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          return signupBloc!.add(SignupButtonPressed(
                              email: email.text, password: password.text, name: name.text));
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
