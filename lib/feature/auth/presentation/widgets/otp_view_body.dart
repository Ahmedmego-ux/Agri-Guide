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
  final _otpController = TextEditingController();
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

  void _startTime() {
    setState(() {
      _seconds = 120;
      _canResend = false;
    });

    _timer = Stream.periodic(const Duration(seconds: 1)).listen((_) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        setState(() {
          _canResend = true;
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
    super.initState();
    _startTime();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) {
                if (state is VerifyOtpSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewPasswordView(email: widget.email),
                    ),
                  );
                }
                if (state is VerifyOtpFailure) {
                  _showSnack(state.errmessage, theme.colorScheme.error);
                }
                if (state is ResetPasswordSuccess) {
                  _startTime();
                  _showSnack("Code resent successfully", theme.colorScheme.primary);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    // Icon Circle
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.mark_email_read,
                        size: 40,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Title
                    Text(
                      'Verification',
                      style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 12),

                    // Description
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                        children: [
                          const TextSpan(text: 'Enter the 6-digit code sent to\n'),
                          TextSpan(
                            text: widget.email,
                            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),

                    // OTP Input
                    Pinput(
                      controller: _otpController,
                      length: 6,
                      keyboardType: TextInputType.number,
                      defaultPinTheme: defaultPinTheme(context),
                      focusedPinTheme: focusedPinTheme(context),
                      submittedPinTheme: submittedPinTheme(context),
                      errorPinTheme: errorPinTheme(context),
                      onCompleted: (pin) {
                        context.read<ResetPasswordCubit>().verifyOtp(
                              entity: VerifyOtpEntity(email: widget.email, otpCode: pin),
                            );
                      },
                      useNativeKeyboard: true,
                      closeKeyboardWhenCompleted: true,
                      autofocus: true,
                      enableInteractiveSelection: true,
                    ),

                    const SizedBox(height: 40),

                    // Timer
                    RichText(
                      text: TextSpan(
                        style: theme.textTheme.bodySmall,
                        children: [
                          const TextSpan(text: 'Code expires in '),
                          TextSpan(
                            text: _timerText,
                            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Resend Code
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Didn't receive code? ", style: theme.textTheme.bodyMedium),
                        GestureDetector(
                          onTap: _canResend
                              ? () {
                                  context.read<ResetPasswordCubit>().resetPassword(
                                        entity: ResetPasswordEntity(email: widget.email),
                                      );
                                }
                              : null,
                          child: Text(
                            'Resend',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Change Email
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Change Email',
                        style: theme.textTheme.bodySmall,
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

/// ──────────────── Pinput Themes ────────────────

PinTheme defaultPinTheme(BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  return PinTheme(
    width: 56,
    height: 64,
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: cs.onSurface,
    ),
    decoration: BoxDecoration(
      color: cs.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: cs.outline, width: 1.5),
    ),
  );
}

PinTheme focusedPinTheme(BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  return defaultPinTheme(context).copyDecorationWith(
    border: Border.all(color: cs.primary, width: 2.5),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: cs.primary.withOpacity(0.15),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );
}

PinTheme submittedPinTheme(BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  return defaultPinTheme(context).copyDecorationWith(
    color: cs.primary.withOpacity(0.1),
    border: Border.all(color: cs.primary, width: 2),
  );
}

PinTheme errorPinTheme(BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  return defaultPinTheme(context).copyDecorationWith(
    border: Border.all(color: cs.error, width: 2),
    boxShadow: [
      BoxShadow(
        color: cs.error.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );
}