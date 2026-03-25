
import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/view/chat_bot_view.dart';
import 'package:agri_guide_app/feature/home/presentation/view/home_view.dart';
import 'package:agri_guide_app/feature/home/presentation/widgets/action_card.dart';


import 'package:agri_guide_app/feature/home/presentation/widgets/home_header.dart';

import 'package:agri_guide_app/feature/home/presentation/widgets/info_item.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:agri_guide_app/feature/settings/presentation/view/settings_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, required this.loginEntity});
  final LoginEntity loginEntity;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int _currentIndex =0;

 
  
  @override
  Widget build(BuildContext context) {
    
  
  return  Scaffold(
      backgroundColor: Color(0xffFFFFFF),
body: SafeArea(
  child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              SizedBox(height: 16),
              HomeHeader(loginEntity:widget.loginEntity ,),
              SizedBox(height: 24),
              HomeActionCards(),
              SizedBox(height: 28),
              HomeRecentScans(),
              SizedBox(height: 28),
              HomeQuickTips(),
              SizedBox(height: 24),
            ],
          ),
        ),
),


      floatingActionButton: FloatingActionButton(
  onPressed: () => setState(() => _currentIndex = 2), 
  child: Icon(Icons.camera_alt),
  backgroundColor:_currentIndex==2? Colors.green:Colors.grey.shade300,
),
floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     bottomNavigationBar: BottomAppBar(
      height: 90,
shape: CircularNotchedRectangle(),
  notchMargin: 6,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [

      _buildNavItem(Icons.home, 'Home', 0, ()  {
        setState(() => _currentIndex = 0);
        _currentIndex!=0;
      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView())):null;
         
        },),



         _buildNavItem(Icons.chat, 'Chat',1, () async {setState(() => _currentIndex =1);
        _currentIndex!=0?
        await Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatBotView())):null;
         setState(() => _currentIndex = 0);
        },),
        SizedBox(width: 50),

         _buildNavItem(Icons.eco, 'Crops', 3, () async {setState(() => _currentIndex =3);
        _currentIndex!=0?
       await  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatBotView())):null;
          setState(() => _currentIndex = 0);
        },),

         _buildNavItem(Icons.settings, 'settings', 4, ()async  {setState(() => _currentIndex =4);
        _currentIndex!=0?
        await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => BlocProvider.value(
      value: context.read<ProfileCubit>(), 
      child: SettingsView(loginEntity: widget.loginEntity,),
    ),
  ),
):null;
          setState(() => _currentIndex = 0);
        },),

     
    ],
  ),
),
     
    );
  }
  
  Widget _buildNavItem(IconData icon, String label, int index,VoidCallback onPressed) {
    final isSelected = _currentIndex == index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
    
        IconButton(onPressed:onPressed , icon:  Icon(icon,
            color: isSelected ? Colors.green : Colors.grey,
            size: 26),),
       
        Text(label,
            style: TextStyle(
              fontSize:12,
              color: isSelected ? Colors.green : Colors.grey,
            )),
      ],
    );
  }



}





 
// ─── Action Cards ──────────────────────────────────────────────
class HomeActionCards extends StatelessWidget {
  const HomeActionCards({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ActionCard(
            icon: Icons.camera_alt_outlined,
            title: 'Scan Plant',
            subtitle: 'Analyze plant health',
            color: const Color(0xFF2E9E47),
            onTap: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ActionCard(
            icon: Icons.chat_bubble_outline,
            title: 'AI Chat',
            subtitle: 'Ask expert advice',
            color: const Color(0xFF2D5BE3),
            onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatBotView())),
          ),
        ),
      ],
    );
  }
}
 

 
// ─── Recent Scans ──────────────────────────────────────────────
class HomeRecentScans extends StatelessWidget {
  const HomeRecentScans({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Recent Scans',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        SizedBox(height: 12),
        InfoItem(
          icon: Icons.warning_amber_outlined,
          iconColor: Color(0xFFE6A817),
          iconBg: Color(0xFFFFF3DC),
          title: 'Tomato Plant',
          subtitle: 'Early Blight',
          time: '2 days ago',
        ),
        SizedBox(height: 10),
        InfoItem(
          icon: Icons.eco_outlined,
          iconColor: Color(0xFF2E9E47),
          iconBg: Color(0xFFE1F5E6),
          title: 'Rose Bush',
          subtitle: 'Healthy',
          time: '1 week ago',
        ),
      ],
    );
  }
}
 


class HomeQuickTips extends StatelessWidget {
  const HomeQuickTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Quick Tips',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        SizedBox(height: 12),
        InfoItem(                          
          icon: Icons.eco_outlined,
          iconColor: Color(0xFF2E9E47),
          iconBg: Color(0xFFE1F5E6),
          title: 'Spring Planting',
          subtitle: 'Best time to start your vegetable garden',
         
        ),
        SizedBox(height: 10),
        InfoItem(                        
          icon: Icons.trending_up,
          iconColor: Color(0xFF2D5BE3),
          iconBg: Color(0xFFE8EDFC),
          title: 'Crop Rotation',
          subtitle: 'Improve soil health naturally',
        ),
      ],
    );
  }
}
 




