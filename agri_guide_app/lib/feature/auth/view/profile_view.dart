import 'package:agri_guide_app/core/constans/app_colors.dart';
import 'package:agri_guide_app/feature/auth/widgets/custome_profile_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
          backgroundColor: maincolor,
        ),
        backgroundColor: maincolor,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                 
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: BoxBorder.all(
                          width: 5,
                          color: Colors.white
                        )
                      ),
                      child: Image.asset('assets/logo.svg',height: 129,width: 126,fit: BoxFit.fill,)),
                      Gap(30),
                      CustomeProfileTextField(labeltext: ' Name ', ),
                       Gap(25),
                      CustomeProfileTextField(labeltext: ' Email ',),
                       Gap(25),
                      CustomeProfileTextField(labeltext: ' Delivery address ',),
                       Gap(25),
                      CustomeProfileTextField(labeltext: ' Password ',ispassword: true,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 70,
                        ),
                      ),
                       ListTile(
                   contentPadding:  EdgeInsets.symmetric(vertical: 5),
                    tileColor:  Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(16)
                    ),
                    leading:Image.asset(
                          'assets/logo.svg',height: 30,
                          fit: BoxFit.contain,
                        ), 
                        title: Text(
                          'Debit card',
                          style: TextStyle(color: maincolor, fontSize: 20),
                        ),
                        subtitle: Text(
                          '3566 **** **** 0505',
                          style: TextStyle(color: maincolor),),
                       
                  ),
                
                Gap(30),
                  Row(
                    children: [
                      Container(
                        height: 70,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            
                            children: [
                              Text('Edit Profile', style: TextStyle(color: maincolor)),
                              Icon(Icons.edit)
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                
                
                       Container(
                        height: 70,
                        width: 180,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width:2.5,
                            color: Colors.white),
                          borderRadius: BorderRadius.circular(16),
                          color: maincolor
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            
                            children: [
                             Text('Log out',style:  TextStyle(color: Colors.white),) ,
                              Icon(Icons.logout,color: Colors.white,)
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                      
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

