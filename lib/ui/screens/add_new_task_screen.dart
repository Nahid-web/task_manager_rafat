import 'package:flutter/material.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_caller.dart';
import 'package:task_manager_rafat/data/data.network_caller/network_response.dart';
import 'package:task_manager_rafat/ui/screens/new_tasks_screen.dart';
import 'package:task_manager_rafat/ui/widgets/body_background.dart';
import 'package:task_manager_rafat/ui/widgets/profile_summary_tile.dart';
import 'package:task_manager_rafat/ui/widgets/snack_message.dart';

import '../../data/utility/urls.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  bool _isProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryTile(),
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
                            'Add New Task',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _subjectTEController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'You must add subject';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: 'Subject'),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            maxLines: 5,
                            controller: _descriptionTEController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Description filed cannot be empty';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: 'Description'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: _isProgress == false,
                            replacement: const Center(child: CircularProgressIndicator()),
                            child: ElevatedButton(
                              onPressed: (){
                                addNewTask;
                              },
                              child:
                                  const Icon(Icons.arrow_circle_right_outlined),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addNewTask() async {
    if (_formKey.currentState!.validate()) {
      _isProgress = true;
      setState(() {

      });
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.addNewTask, body: {
        "title": _subjectTEController.text.trim(),
        "description": _descriptionTEController.text.trim(),
        "status": "New"
      });
      _isProgress = false;
      setState(() {

      });

      if (response.isSuccess) {
        const NewTasksScreen();
        _subjectTEController.clear();
        _descriptionTEController.clear();
        if(mounted){
          snackMessage(context, 'Add new Task Successful');
        }
      }
      else {
        if(mounted){
          snackMessage(context, 'Add New task failed');
        }
      }
    }
  }
  
  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
