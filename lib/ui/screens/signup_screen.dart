import 'package:flutter/material.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_caller.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_response.dart';
import 'package:task_manager_rafat/data/utility/urls.dart';
import 'package:task_manager_rafat/ui/screens/login_screen.dart';
import 'package:task_manager_rafat/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_rafat/ui/widgets/body_background.dart';
import 'package:task_manager_rafat/ui/widgets/snack_message.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  Map<String, dynamic> registrationForm = {};

  bool _signUpProgress = false;

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
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    // email field
                    TextFormField(
                      controller: _emailTEController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter your valid email';
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

                    //FirstName field
                    TextFormField(
                      controller: _firstNameTEController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter your First Name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    //LastName field
                    TextFormField(
                      controller: _lastNameTEController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter your Last Name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    //Mobile filed
                    TextFormField(
                      controller: _mobileTEController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter your mobile number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    //Password Field
                    TextFormField(
                      controller: _passwordTEController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your valid password';
                        }
                        if (value.length < 5) {
                          return 'password must be higher than 5 character';
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
                      visible: _signUpProgress == false,
                      replacement: const CircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 45)),
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
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
                            Navigator.pop(context);
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
      ),
    );
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      _signUpProgress = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.registration,
        body: {
          "email": _emailTEController.text.trim(),
          "firstName": _firstNameTEController.text.trim(),
          "lastName": _lastNameTEController.text.trim(),
          "mobile": _mobileTEController.text.trim(),
          "password": _passwordTEController.text,
        },
      );
      _signUpProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        _clearTextField();

        if (mounted) {
          snackMessage(context, 'Account has been created ! please login');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      } else {
        if (mounted) {
          snackMessage(
              context, 'Somethings happened wrong ! please try again. ');
        }
      }
    }
  }

  void _clearTextField() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
