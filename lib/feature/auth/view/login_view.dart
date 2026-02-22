
import 'package:agri_guide_app/core/constans/app_strings.dart';
import 'package:agri_guide_app/core/network/api_errors.dart';
import 'package:agri_guide_app/feature/auth/data/auth_repo.dart';
import 'package:agri_guide_app/feature/auth/view/signup_view.dart';
import 'package:agri_guide_app/feature/auth/widgets/auth_header.dart';
import 'package:agri_guide_app/feature/auth/widgets/custom_textformfiled.dart';
import 'package:agri_guide_app/feature/auth/widgets/custome_auth_buttom.dart';
import 'package:agri_guide_app/root.dart';
import 'package:flutter/material.dart';


import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isActive = false;
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController Passwordcontroller = TextEditingController();
  final TextEditingController locationcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AuthRepo authRepo = AuthRepo();
  bool _obscureText = true;

  Future<void> login() async {
    try {
      final user = await authRepo.login(
        emailcontroller.text.trim(),
        Passwordcontroller.text.trim(),
      );
      if (user != null) {
        ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('success login')));
        Navigator.push(context, MaterialPageRoute(builder: (_) => Root()));
      }
    } catch (e) {
      String errormessage = ' erorr login';
      if (e is ApiErrors) {
        errormessage = e.message;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errormessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: _formkey,
        child: Scaffold(
          backgroundColor: Color(0xffFFFFFFF2),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100,),
              
             AuthHeader(),
              

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(10),
                        Center(
                          child: Text(
                            'Login with your Email',
                            style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(199, 0, 0, 0),
                              fontFamily: fontFamily,
                            ),
                          ),
                        ),
                        Gap(60),
                        Custome_Textformfield(
                          hintText: 'Enter your E-mail',
                          prefixicon:  Icon(Icons.email),
                          controller: emailcontroller,
                          ispassword: false,
                        ),
                        Gap(40),
                        Custome_Textformfield(
                          hintText: 'Password',
                          prefixicon: Icon(Icons.lock),
                          suffixicon: IconButton(
                            onPressed: () {
                              setState(() {
                                if (_obscureText == true) {
                                  _obscureText = false;
                                } else {
                                  _obscureText = true;
                                }
                              });
                            },
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          controller: Passwordcontroller,
                          ispassword: _obscureText,
                        ),
                        Gap(40),
                        Custome_Textformfield(
                          
                          hintText: 'Location',
                          prefixicon: Icon(Icons.location_on),
                          controller: locationcontroller,
                          ispassword: false,
                        ),

                        Gap(60),
                        GestureDetector(
                          onTap: ()async {
                            await login();
                          },
                          child: Custome_auth_buttom.CustomeButtom(
                            progres: 'Log In',
                            color: Colors.green,
                            colortext: Colors.white,
                          ),
                        ),
                        Gap(30),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (_)=>SignupView()));
                            
                          },
                
                          child: Custome_auth_buttom.CustomeButtom(
                            progres: 'Go to creat Acount',
                            bordercolor: Colors.grey,
                            
                          ),
                        ),
                        Gap(30),
                       
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


