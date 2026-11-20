import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'resume_parser_service.dart';
import 'resume_service.dart';

class ResumeUploadPage extends StatefulWidget {
  const ResumeUploadPage({super.key});

  @override
  State<ResumeUploadPage> createState() =>
      _ResumeUploadPageState();
}

class _ResumeUploadPageState extends State<ResumeUploadPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final educationController = TextEditingController();
  final skillsController = TextEditingController();
  final experienceController = TextEditingController();

  bool loading = false;

  String? selectedFileName;
  Uint8List? selectedBytes;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    educationController.dispose();
    skillsController.dispose();
    experienceController.dispose();
    super.dispose();
  }

  // PICK RESUME PDF
  Future<void> pickResume() async {
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (file == null) return;

      setState(() {
        loading = true;
      });

      final Uint8List bytes = await file.readAsBytes();

      final details =
          await ResumeParserService.parsePdf(bytes);

      if (!mounted) return;

      setState(() {
        selectedFileName = file.name;
        selectedBytes = bytes;

        nameController.text = details['name'] ?? '';
        emailController.text = details['email'] ?? '';
        phoneController.text = details['phone'] ?? '';
        educationController.text =
            details['education'] ?? '';
        skillsController.text = details['skills'] ?? '';
        experienceController.text =
            details['experience'] ?? '';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Resume information extracted!'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  // SAVE RESUME
  Future<void> saveResume() async {
    if (selectedBytes == null || selectedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your Resume first.'),
        ),
      );
      return;
    }

    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name and Email are required.'),
        ),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final details = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'education': educationController.text.trim(),
        'skills': skillsController.text.trim(),
        'experience': experienceController.text.trim(),
      };

      await ResumeService.uploadResume(
        bytes: selectedBytes!,
        fileName: selectedFileName!,
        details: details,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Resume saved successfully!'),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save failed: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  // TEXT FIELD
  Widget buildField(
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Auto Fill'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upload Your Resume',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Upload your PDF resume. '
              'We will automatically extract your details.',
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.picture_as_pdf,
                    size: 55,
                    color: Colors.red,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    selectedFileName ?? 'No Resume Selected',
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton.icon(
                    onPressed: loading ? null : pickResume,
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Choose Resume PDF'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            buildField('Full Name', nameController),
            buildField('Email Address', emailController),
            buildField('Mobile Number', phoneController),

            const SizedBox(height: 10),

            const Text(
              'Professional Information',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            buildField('Education', educationController),
            buildField('Skills', skillsController),
            buildField('Experience', experienceController),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: loading ? null : saveResume,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Save Resume & Profile',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}