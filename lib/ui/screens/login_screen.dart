import 'package:flutter/material.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_caller.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_response.dart';
import 'package:task_manager_rafat/data/utility/urls.dart';
import 'package:task_manager_rafat/ui/screens/forget_password_screen.dart';
import 'package:task_manager_rafat/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_rafat/ui/screens/signup_screen.dart';
import 'package:task_manager_rafat/ui/widgets/body_background.dart';
import 'package:task_manager_rafat/ui/widgets/snack_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool _isLogInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter valid email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter valid password';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                      visible: _isLogInProgress == false,
                      replacement: const CircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _logIn,
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgetPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forget Password ?',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have account ?",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
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
      ),
    );
  }

  Future<void> _logIn() async {
    if (_formKey.currentState!.validate()) {
      _isLogInProgress = true;
      if(mounted){
        setState(() {

        });
      }
      final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.logIn,
        body: {
            "email": _emailTEController.text,
            "password": _passwordTEController.text,
        },

      );
      _isLogInProgress = false;
      if(mounted){
        setState(() {

        });
      }
      if(response.isSuccess){
        if(mounted){
          _clearLogInField();
          snackMessage(context, 'Log in successful ');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainBottomNavScreen(),
            ),
          );
        }
      } else {
        if(mounted){
          snackMessage(context, 'Log In Failed . Check email and password' , true);
        }
      }


    }
  }

  void _clearLogInField(){
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
