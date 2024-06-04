import 'package:flutter/material.dart';
import 'package:flux/collection/collection.dart';
import 'package:flux/collection/contestmodel.dart';

class pcont extends StatefulWidget {
  const pcont({super.key});

  @override
  State<pcont> createState() => _pcontState();
}

class _pcontState extends State<pcont> {
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final budgetcontroller = TextEditingController();

  String selectedSkill = 'Graphic design';
  String selectedDays = '1 Days';

  List<String> skills = [
    'Graphic design',
    'Branding',
    'Illustration',
    'Logo Design'
  ];

  List<String> days = [
    '1 Days',
    '3 Days',
    '5 Days',
    '7 Days',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Contest", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              _buildSectionTitle("Title"),
              _buildTextField(titlecontroller, "Enter Title", maxLength: 10),
              SizedBox(height: 10),
              _buildSectionTitle("Description"),
              _buildTextField(descriptioncontroller, "Enter Description", maxLength: 200),
              SizedBox(height: 10),
              _buildSectionTitle("Budget"),
              _buildTextField(budgetcontroller, "Enter Your Budget", maxLength: 10, keyboardType: TextInputType.number),
              SizedBox(height: 10),
              _buildGuidelines(),
              SizedBox(height: 10),
              _buildDropdownSection("Skill Required", selectedSkill, skills, (newValue) {
                setState(() {
                  selectedSkill = newValue!;
                });
              }),
              SizedBox(height: 10),
              _buildDropdownSection("Set Deadline", selectedDays, days, (newValue) {
                setState(() {
                  selectedDays = newValue!;
                });
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await Controller().postcontest(Contestmodel(
                    title: titlecontroller.text,
                    description: descriptioncontroller.text,
                    budget: double.parse(budgetcontroller.text),
                    skill: selectedSkill,
                    deadline: selectedDays,
                  ));
                },
                child: Text("Post Your Contest"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {int? maxLength, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          counterText: '',
        ),
      ),
    );
  }

  Widget _buildGuidelines() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Guidelines", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            _buildGuidelineText("Be specific about the skills required for the job"),
            _buildGuidelineText("Use a clear and concise title"),
            _buildGuidelineText("Provide as many details as possible"),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(text),
    );
  }

  Widget _buildDropdownSection(String title, String selectedItem, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedItem,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
