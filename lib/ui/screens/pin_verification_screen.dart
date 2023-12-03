import 'package:flutter/material.dart';
import 'package:task_manager_rafat/ui/screens/login_screen.dart';
import 'package:task_manager_rafat/ui/screens/set_password_screen.dart';
import 'package:task_manager_rafat/ui/widgets/body_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16,),
                  const Text('A 6 digit verification pin will send to your email address',
                    style: TextStyle(fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),),
                  const SizedBox(
                    height: 24,
                  ),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      activeColor: Colors.green,
                      selectedColor: Colors.white,
                      inactiveFillColor: Colors.white,


                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.white,
                    enableActiveFill: true,
                    onCompleted: (v) {

                    },
                    onChanged: (value) {
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SetPasswordScreen(),));
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45)),
                    child: const Text('Verify'),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have account ?",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
