import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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
   Uint8List imageBytes = const Base64Decoder().convert(AuthController.user!.photo ?? '');
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
      leading: CircleAvatar(
        radius: 20,
        child: AuthController.user?.photo == null ? const Icon(Icons.person) :
        ClipOval(child: Image.memory(imageBytes)),
      ),
      title: Text(
        fullName,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        '${AuthController.user?.email}',
        style: TextStyle(fontSize: 10, color: Colors.white),
      ),
      trailing: IconButton(
        onPressed: () async {
          await AuthController.clearAuthData();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false);
          }
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }
  get fullName{
    return '${AuthController.user?.firstName} ${AuthController.user?.lastName}';
  }
}
