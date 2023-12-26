import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_caller.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_response.dart';
import 'package:task_manager_rafat/data/models/user_model.dart';
import 'package:task_manager_rafat/ui/controller/auth_controller.dart';
import 'package:task_manager_rafat/ui/screens/new_tasks_screen.dart';
import 'package:task_manager_rafat/ui/widgets/body_background.dart';
import 'package:task_manager_rafat/ui/widgets/profile_summary_tile.dart';
import 'package:task_manager_rafat/ui/widgets/snack_message.dart';

import '../../data/utility/urls.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  AuthController authController = Get.find<AuthController>();

  XFile? photo ;

  Future<void> updateProfile() async {
    Map<String , dynamic> inputDate = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };
    String? photoBase64;
    if(_passwordTEController.text.isNotEmpty){
      inputDate['password'] = _passwordTEController.text;
    }
    if(photo != null){
     List<int> imageBytes = await photo!.readAsBytes();
     photoBase64 = base64Encode(imageBytes);
     inputDate['photo'] = photoBase64;
    }
    NetworkResponse response = await NetworkCaller().postRequest(Urls.updateProfile,
        body: inputDate);
    if(response.isSuccess){
      authController.updateUserInformation(UserModel(
        email: _emailTEController.text.trim(),
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        mobile: _mobileTEController.text.trim(),
        photo: photoBase64 ?? authController.user?.photo,
      ));
      if(mounted){
        snackMessage(context, 'Update Profile successful');
      }
    }
    else {
      if(mounted){
        snackMessage(context, 'Update Profile failed');

      }
    }
  }

  @override
  void initState() {
    super.initState();
    _emailTEController.text = authController.user?.email ?? '';
    _firstNameTEController.text = authController.user?.firstName ?? '';
    _lastNameTEController.text = authController.user?.lastName ?? '';
    _mobileTEController.text = authController.user?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const ProfileSummaryTile(
            enableOnTap: false,
          ),
          Expanded(
            child: BodyBackground(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Update Profile',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //photo field
                        photoPicker(),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _emailTEController,
                          validator: (value){
                            if(value!.trim().isEmpty){
                              return 'Email field cannot be empty';
                            }
                            return null ;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(hintText: 'Email'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _firstNameTEController,
                          validator: (value){
                            if(value!.trim().isEmpty){
                              return 'firstName cannot be empty';
                            }
                            return null ;
                          },
                          decoration:
                              const InputDecoration(hintText: 'First Name'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _lastNameTEController,
                          validator: (value) {
                            if(value!.trim().isEmpty){
                              return 'last name cannot be empty';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(hintText: 'Last Name'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _mobileTEController,
                          validator: (value){
                            if(value!.trim().isEmpty){
                              return 'Mobile number cannot be empty';
                            }
                            return null ;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: 'Mobile'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: 'Password(optional)'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              updateProfile();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NewTasksScreen(),
                                ),
                              );
                            },
                            child: const Icon(Icons.arrow_circle_right_outlined))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Container photoPicker() {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Photos'),
            ),
          ),
          Expanded(flex: 3, child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: InkWell(
              onTap: () async{
              final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 50);
              if(image != null){
                photo = image;
                setState(() {

                });
              }

              },
              child: Visibility(
                visible: photo == null,
                  replacement: Text(photo?.name ?? ''),
                  child: const Text('Pick a photo')),
            ),
          )),
        ],
      ),
    );
  }
}
