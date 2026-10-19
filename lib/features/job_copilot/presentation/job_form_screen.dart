import 'package:flutter/material.dart';

class JobFormScreen extends StatefulWidget {
const JobFormScreen({super.key});

@override
State<JobFormScreen> createState() => _JobFormScreenState();
}

class _JobFormScreenState extends State<JobFormScreen> {
final _formKey = GlobalKey<FormState>();

final _jobController = TextEditingController();
final _companyController = TextEditingController();
final _descriptionController = TextEditingController();
final _skillsController = TextEditingController();
final _experienceController = TextEditingController();

String _language = 'English';

@override
void dispose() {
_jobController.dispose();
_companyController.dispose();
_descriptionController.dispose();
_skillsController.dispose();
_experienceController.dispose();
super.dispose();
}

Widget _field({
required String label,
required TextEditingController controller,
int maxLines = 1,
String? hint,
}) {
return Padding(
padding: const EdgeInsets.only(bottom: 16),
child: TextFormField(
controller: controller,
maxLines: maxLines,
decoration: InputDecoration(
labelText: label,
hintText: hint,
filled: true,
fillColor: Colors.white,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(14),
),
),
validator: (value) {
if (value == null || value.trim().isEmpty) {
return 'Please fill in this field';
}
if (label == 'Job description' &&
value.trim().length < 30) {
return 'Enter at least 30 characters';
}
if (label == 'Experience and achievements' &&
value.trim().length < 10) {
return 'Enter at least 10 characters';
}
return null;
},
),
);
}

void _reviewInformation() {
if (!_formKey.currentState!.validate()) return;

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ApplicationReviewScreen(
      job: _jobController.text.trim(),
      company: _companyController.text.trim(),
      description: _descriptionController.text.trim(),
      skills: _skillsController.text.trim(),
      experience: _experienceController.text.trim(),
      language: _language,
    ),
  ),
);

}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Your Job Details'),
),
body: SafeArea(
child: Form(
key: _formKey,
child: ListView(
padding: const EdgeInsets.all(20),
children: [
const Text(
'Let’s prepare your application',
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 8),
const Text(
'Tell us about the job and your experience.',
style: TextStyle(color: Colors.black54),
),
const SizedBox(height: 24),
_field(
label: 'Job title',
controller: _jobController,
hint: 'e.g. Flutter Developer',
),
_field(
label: 'Company name (optional)',
controller: _companyController,
hint: 'e.g. ABC Company',
),
_field(
label: 'Job description',
controller: _descriptionController,
maxLines: 5,
hint: 'Paste the job description here',
),
_field(
label: 'Your skills',
controller: _skillsController,
maxLines: 3,
hint: 'e.g. Flutter, teamwork, communication',
),
_field(
label: 'Experience and achievements',
controller: _experienceController,
maxLines: 4,
hint: 'Describe your experience',
),
const Text(
'Application language',
style: TextStyle(fontWeight: FontWeight.bold),
),
const SizedBox(height: 8),
DropdownButtonFormField<String>(
value: _language,
decoration: const InputDecoration(
border: OutlineInputBorder(),
filled: true,
fillColor: Colors.white,
),
items: const [
DropdownMenuItem(
value: 'English',
child: Text('English'),
),
DropdownMenuItem(
value: 'Arabic',
child: Text('العربية'),
),
],
onChanged: (value) {
if (value != null) {
setState(() => _language = value);
}
},
),
const SizedBox(height: 24),
FilledButton(
onPressed: _reviewInformation,
style: FilledButton.styleFrom(
padding: const EdgeInsets.all(16),
),
child: const Text('Review my information'),
),
],
),
),
),
);
}
}

class ApplicationReviewScreen extends StatelessWidget {
const ApplicationReviewScreen({
super.key,
required this.job,
required this.company,
required this.description,
required this.skills,
required this.experience,
required this.language,
});

final String job;
final String company;
final String description;
final String skills;
final String experience;
final String language;

Widget _detail(String title, String value) {
return Card(
color: Colors.white,
child: Padding(
padding: const EdgeInsets.all(16),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
title,
style: const TextStyle(
fontWeight: FontWeight.bold,
color: Color(0xFF5046E5),
),
),
const SizedBox(height: 8),
SelectableText(
value.isEmpty ? 'Not provided' : value,
),
],
),
),
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Review Information')),
body: ListView(
padding: const EdgeInsets.all(20),
children: [
const Text(
'Check your information',
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 16),
_detail('Job title', job),
_detail('Company', company),
_detail('Job description', description),
_detail('Skills', skills),
_detail('Experience', experience),
_detail('Application language', language),
const SizedBox(height: 16),
const Text(
'Your information is ready for the next step.',
textAlign: TextAlign.center,
),
const SizedBox(height: 16),
OutlinedButton(
onPressed: () => Navigator.pop(context),
child: const Text('Edit information'),
),
],
),
);
}
}