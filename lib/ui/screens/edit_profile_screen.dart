import 'package:flutter/material.dart';
import 'package:task_manager_rafat/ui/screens/new_tasks_screen.dart';
import 'package:task_manager_rafat/ui/widgets/body_background.dart';
import 'package:task_manager_rafat/ui/widgets/profile_summary_tile.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(hintText: 'Email'),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'First Name'),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'Last Name'),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: 'Mobile'),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: 'Password'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
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
                          Expanded(flex: 3, child: Container()),
                        ],
                      ),
                    );
  }
}
