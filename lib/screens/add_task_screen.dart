import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? existingTask;
  const AddTaskScreen({super.key, this.existingTask});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  String selectedCategory = 'Personal';
  DateTime? selectedDate;

  final List<String> categories = [
    'Personal',
    'Work',
    'Shopping',
    'Health',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingTask != null) {
      titleController.text = widget.existingTask!.title;
      selectedCategory = widget.existingTask!.category;
      selectedDate = widget.existingTask!.dueDate;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingTask != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'Add Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => selectedCategory = val);
              },
            ),

            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: pickDate,
              icon: const Icon(Icons.calendar_today),
              label: Text(
                selectedDate == null
                    ? 'Pick Due Date (Optional)'
                    : 'Due: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.trim().isEmpty) return;

                  final provider = Provider.of<TaskProvider>(
                    context,
                    listen: false,
                  );

                  if (isEditing) {
                    provider.editTask(
                      widget.existingTask!.id,
                      Task(
                        id: widget.existingTask!.id,
                        title: titleController.text.trim(),
                        category: selectedCategory,
                        dueDate: selectedDate,
                        isCompleted: widget.existingTask!.isCompleted,
                      ),
                    );
                  } else {
                    provider.addTask(
                      Task(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: titleController.text.trim(),
                        category: selectedCategory,
                        dueDate: selectedDate,
                      ),
                    );
                  }

                  Navigator.pop(context);
                },
                child: Text(
                  isEditing ? 'Update Task' : 'Save Task',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
