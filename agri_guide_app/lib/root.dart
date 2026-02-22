import 'package:agri_guide_app/core/constans/app_colors.dart';
import 'package:agri_guide_app/feature/auth/view/profile_view.dart';
import 'package:agri_guide_app/feature/onboard/widgets/onboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
 late List<Widget> screans;
  int indexcurrent =0;
 late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screans=[
       
        


          
    ];
    _pageController=PageController(initialPage: indexcurrent);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller:_pageController ,
        physics: NeverScrollableScrollPhysics(),
        itemCount: screans.length,
         itemBuilder: (BuildContext context, int index) { 
          
          return screans[index];

         },
         
        
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: maincolor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        ),
        child: BottomNavigationBar(
       
          onTap: (value) {
            
            setState(() {
              indexcurrent=value;
            });
            _pageController.jumpToPage(value);
          },
          iconSize: 30,
          currentIndex: indexcurrent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade600,
          type: BottomNavigationBarType.fixed,
        
        backgroundColor: Colors.transparent,
        items: [
         BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart),label: 'prouduct'),
           BottomNavigationBarItem(icon: Icon(Icons.history),label: 'History'),
            BottomNavigationBarItem(icon: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileView()));
            }, icon: Icon(Icons.person)),label: 'profile'),
        ],
      )
      )
      );
    
  }
}