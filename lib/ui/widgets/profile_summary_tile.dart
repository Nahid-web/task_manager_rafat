import 'package:flutter/material.dart';
import 'package:task_manager_rafat/ui/screens/edit_profile_screen.dart';

class ProfileSummaryTile extends StatelessWidget {
  const ProfileSummaryTile({
    super.key,
    this.enableOnTap = true
  });
  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if(enableOnTap){
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
        child: Icon(Icons.person),
      ),
      title: Text(
        'Nahid Amin',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'nahidamin@gmail.com',
        style: TextStyle(fontSize: 10, color: Colors.white),
      ),
      trailing: enableOnTap ? const Icon(Icons.arrow_forward) : const Text(''),
    );
  }
}
