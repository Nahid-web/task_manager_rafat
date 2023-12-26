import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_rafat/ui/controller/auth_controller.dart';
import 'package:task_manager_rafat/ui/screens/edit_profile_screen.dart';
import 'package:task_manager_rafat/ui/screens/login_screen.dart';

class ProfileSummaryTile extends StatefulWidget {
  const ProfileSummaryTile({super.key, this.enableOnTap = true});

  final bool enableOnTap;

  @override
  State<ProfileSummaryTile> createState() => _ProfileSummaryTileState();
}

class _ProfileSummaryTileState extends State<ProfileSummaryTile> {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthController>(
      builder: (authController) {
        // Uint8List imageBytes = const Base64Decoder().convert(authController.user?.photo ?? '');
        return ListTile(
          onTap: () {
            if (widget.enableOnTap) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            }
          },
          tileColor: Colors.green,
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          // leading: CircleAvatar(
          //   radius: 20,
            // child: authController.user?.photo == null ? const Icon(Icons.person) :
            // ClipOval(child: Image.memory(imageBytes)),
          // ),
          title: Text(
            fullName(authController),
            style: const  TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${authController.user?.email}',
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: () async {
              await Get.find<AuthController>().clearAuthData();
              Get.offAll(const LoginScreen());
            },
            icon: const Icon(Icons.logout),
          ),
        );
      }
    );
  }
  fullName(AuthController authController){
    return '${authController.user?.firstName} ${authController.user?.lastName}';
  }
}
