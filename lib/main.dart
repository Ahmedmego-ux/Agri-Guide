import 'package:agri_guide_app/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main()async {
  await Supabase.initialize(
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl6bHZjd3Juc2pvY3RmdndjbXRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzIxOTY3NzIsImV4cCI6MjA4Nzc3Mjc3Mn0.IIkdRViqGRFf07sF2uYACmJLOYcneSg-MPEktHZCViQ',
    url: 'https://yzlvcwrnsjoctfvwcmtr.supabase.co');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     
      home: SplashView(),
      
    );
  }
}


