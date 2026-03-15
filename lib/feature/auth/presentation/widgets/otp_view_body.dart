import 'dart:async';

import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/reset_password_entity.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/reset_password/verify_otp_entity.dart';
import 'package:agri_guide_app/feature/auth/presentation/manger/reset_password/reset_password_cubit.dart';
import 'package:agri_guide_app/feature/auth/presentation/view/new_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class OtpViewBody extends StatefulWidget {
  const OtpViewBody({super.key, required this.email});
  final String email;
  

  @override
  State<OtpViewBody> createState() => _OtpViewBodyState();
}

  


class _OtpViewBodyState extends State<OtpViewBody> {
  final _otpController =TextEditingController();
  int _seconds = 120;
  bool _canResend = false;
  late StreamSubscription _timer;
 @override
  void dispose() {
    _otpController.dispose();
    _timer.cancel();
    super.dispose(); 
  }
   void _showSnack(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), backgroundColor: color),
    );
  }
  void _startTime(){
   setState(() {
      _seconds=120;
    _canResend=false;
    
   });
 _timer=  Stream.periodic(Duration(seconds: 1)).listen((_){
    if(_seconds >0){
      setState(() {
       _seconds--;
      });
    }
    else{
      setState(() {
        
        _canResend=true;
        _timer.cancel();
      });
    }
   });
  }
    String get _timerText {
    final mins = (_seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (_seconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFFF2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) {
                if(state is VerifyOtpSuccess){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => NewPasswordView(email: widget.email),
            ),
          );
        }
        if(state is VerifyOtpFailure){
          _showSnack(state.errmessage, Colors.red);
        }
        if(state is ResetPasswordSuccess){
          _startTime();
          _showSnack("Code resent successfully", Colors.green);
        }
                
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    // Header
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.mark_email_read,
                        color: Colors.green,
                        size: 40,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Title
                    const Text(
                      'Verification',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Description
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Enter the 6-digit code sent to\n',
                          ),
                          TextSpan(
                            text: widget.email,
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Pin Input
                    Pinput(
                      controller:_otpController,
                      length: 6,
                      keyboardType: TextInputType.number,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      errorPinTheme: errorPinTheme,
                      onCompleted: (pin) {
                        context.read<ResetPasswordCubit>().verifyOtp(
                          entity:VerifyOtpEntity(email: widget.email
                              , otpCode: pin) );
                      },
                      useNativeKeyboard: true,
                      closeKeyboardWhenCompleted: true,
                      autofocus: true,
                      enableInteractiveSelection: true,
                      
                    ),

                    const SizedBox(height: 40),

                    // Timer Text
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        children: [
                          const TextSpan(text: 'Code expires in '),
                          TextSpan(
                            text:_timerText ,
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Resend Code
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive code? ",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        GestureDetector(
                          onTap: _canResend?(){
                            context.read<ResetPasswordCubit>().resetPassword(
                              entity: ResetPasswordEntity(email: widget.email)); }:null,
                          child: const Text(
                            'Resend',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Change Email
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Change Email',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Themes
final defaultPinTheme = PinTheme(
  width: 56,
  height: 64,
  textStyle: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  ),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.grey.shade300, width: 1.5),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: Colors.green, width: 2.5),
  borderRadius: BorderRadius.circular(16),
  boxShadow: [
    BoxShadow(
      color: Colors.green.withOpacity(0.15),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ],
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: Colors.green.withOpacity(0.1),
    border: Border.all(color: Colors.green, width: 2),
  ),
);

final errorPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(16),
  boxShadow: [
    BoxShadow(
      color: Colors.red.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ],
);
