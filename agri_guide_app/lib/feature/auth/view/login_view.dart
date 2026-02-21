import 'package:agri_guide_app/core/constans/app_colors.dart';
import 'package:agri_guide_app/core/constans/app_strings.dart';
import 'package:agri_guide_app/core/network/api_errors.dart';
import 'package:agri_guide_app/feature/auth/data/auth_repo.dart';
import 'package:agri_guide_app/feature/auth/widgets/custom_textformfiled.dart';
import 'package:agri_guide_app/feature/auth/widgets/custome_auth_buttom.dart';
import 'package:agri_guide_app/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
             Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35, // تحديد ارتفاع ثابت
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      maincolor.withOpacity(0.2),
                      BlendMode.lighten,
                    ),
                  ),
                ),
               child: Column(
                children: [
                  Gap(100),
                 Center(
                  child: CircleAvatar(
                    
                    radius: 50,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    child: SvgPicture.asset(
                      'assets/logo.svg',
                      color: Colors.white,
                      height: 45,
                    ),
                  ),
                ),
                Gap(15),
                Center(
                  child: Text(
                    'welcome Back To your planets',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
               Gap(60),
               ],),
             ),
              

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(64),
                    //   topRight: Radius.circular(64),
                    // ),
                    color:  const Color(0xffdffde9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(40),
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontFamily: fontFamily,
                            ),
                          ),
                          Gap(30),
                          Custome_Textformfield(
                            hintText: 'E-mail',
                            suffixicon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.email),
                            ),
                            controller: emailcontroller,
                            ispassword: false,
                          ),
                          Gap(40),
                          Custome_Textformfield(
                            hintText: 'Password',
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
                            onTap: () async {
                              await login();
                            },

                            child: Custome_auth_buttom.CustomeButtom(
                              progres: 'Go to creat Acount',
                            ),
                          ),
                          Gap(30),
                         
                        ],
                      ),
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
