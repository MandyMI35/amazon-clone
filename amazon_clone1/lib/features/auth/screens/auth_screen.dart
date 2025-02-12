import 'package:amazon_clone1/common/widgets/custom_button.dart';
import 'package:amazon_clone1/common/widgets/custom_textfield.dart';
import 'package:amazon_clone1/constants/global_variables.dart';
import 'package:amazon_clone1/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key}); //sed to pass the optional key property from the AuthScreen constructor to the StatefulWidget constructor.

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;         //enum type variable can hold any value that is defined in the enum
  final _signUpFormKey = GlobalKey<FormState>();  
  //global key - to access widget outside the widget tree
  //FormState - manages Form
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser(){
    authService.signUpUser(
      context: context, 
      email: _emailController.text, 
      password: _passwordController.text, 
      name: _nameController.text,
    );
  }

  void signInUser(){
    authService.signInUser(
      context: context, 
      email: _emailController.text, 
      password: _passwordController.text, 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            ListTile(
              tileColor: _auth == Auth.signup ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                'Create Account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup, //The value represented by this radio button.
                  groupValue: _auth, //The currently selected value for a group of radio buttons.
                                    // radio button is considered selected if its [value] matches the [groupValue]

                  onChanged: (Auth? val) { //fnxn accepts parameter val of type Auth which can be null(?)
                    setState(() {            //calls the build fnxn as state has changed
                      _auth = val!;          //it changes the auth -> val for the new state, ! is for null check; null not allowed
                    });
                  })
                  ),
            if (_auth == Auth.signup)
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        controller: _nameController, //manages the text input related here i.e name
                        hintText: 'Name',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: _passwordController,
                        hintText: 'Password',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(text: 'Sign Up', onTap: () {
                        if (_signUpFormKey.currentState!.validate()){
                          signUpUser();
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ListTile(
              tileColor: _auth == Auth.signin ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Sign-in',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    }
                  )
                ),
                if (_auth == Auth.signin)
                Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: _passwordController,
                        hintText: 'Password',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(text: 'Sign In', onTap: () {
                        if (_signInFormKey.currentState!.validate()){
                          signInUser();
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
