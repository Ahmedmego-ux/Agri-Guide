import 'package:agri_guide_app/core/constans/app_colors.dart';
import 'package:agri_guide_app/core/constans/app_strings.dart';
import 'package:agri_guide_app/feature/auth/view/login_view.dart';
import 'package:agri_guide_app/feature/auth/widgets/auth_header.dart';
import 'package:agri_guide_app/feature/auth/widgets/custom_textformfiled.dart';
import 'package:agri_guide_app/feature/auth/widgets/custome_auth_buttom.dart';
import 'package:agri_guide_app/feature/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';



class SignupView extends StatefulWidget {
   SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
bool isActive=false;
final GlobalKey<FormState> _Formkey=GlobalKey<FormState>();
final TextEditingController namecontroller=TextEditingController();
final TextEditingController emailcontroller=TextEditingController();
final TextEditingController Passwordcontroller=TextEditingController();
final TextEditingController Passwordconfirmcontroller=TextEditingController();
bool _obscureText = true; 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: _Formkey,
        child: Scaffold(
          backgroundColor:Color(0xffFFFFFFF2),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
             
              children: [
                Gap(50),
                AuthHeader(),
            
              
               Gap(8),
               Center(child: Text('welcome Back To your Agri Guide',style: TextStyle(color: const Color.fromARGB(199, 0, 0, 0)),)),
               Gap(15),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Gap(5),
                     Text('Sign in',style: TextStyle(fontSize: 30,color:maincolor,fontFamily: fontFamily),),
                 Gap(20),
                 Custome_Textformfield(hintText:'Name',  controller: namecontroller,
                  ispassword: false,bordercolor: maincolor,),
                 Gap(15),
                              Custome_Textformfield(
                 hintText: 'E-mail', suffixicon: IconButton(onPressed: (){}, icon: Icon(Icons.email)), controller: emailcontroller, ispassword: false,bordercolor: maincolor,),
                              Gap(30),
                             Custome_Textformfield(hintText: 'Password', suffixicon:
                                   IconButton(onPressed: (){
                                     setState(() {
                                      if(_obscureText==true)
                                      {
                                       _obscureText=false;
               
                                      }else{_obscureText=true;}
                                      
                                     });
                                   }, icon: Icon(_obscureText?Icons.visibility_off:Icons.visibility)),
                                   controller: Passwordcontroller, ispassword: _obscureText,),
                              
                              Gap(60),
                              GestureDetector(
                 onTap: () {
                     if(_Formkey.currentState!.validate()){
                       ScaffoldMessenger(child: SnackBar(content: Text('succes')),);
                       Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeView()));
                     }
                   },
                 child: Custome_auth_buttom.CustomeButtom(progres: 'Sign In',color: Colors.grey,colortext: Colors.black,)),
                              Gap(30),
                              GestureDetector(
                 onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginView()));
                 },
                 
                 child: Custome_auth_buttom.CustomeButtom(progres: 'Go to Login',color: maincolor,colortext: Colors.white,
                     ),)
                   ],
                 ),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



