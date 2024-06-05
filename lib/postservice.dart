import 'package:flutter/material.dart';
import 'package:flux/collection/collection.dart';
import 'package:flux/collection/servicemodel.dart';
import 'package:flutter/services.dart';

class PostService extends StatefulWidget {
  const PostService({super.key});

  @override
  State<PostService> createState() => _PostServiceState();
}
 
class _PostServiceState extends State<PostService> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  String selectedDuration = '1 Hour';
  String selectedCategory = 'Plumbing';
  
  final List<String> durations = [
    '1 Hour',
    '2 Hours',
    '4 Hours',
    'Less than 24 Hours',
  ];

  final List<String> categories = [
    "Plumbing",
    "Electrician",
    "Taxi",
    "Courier",
    "Food Delivery",
    "Cleaning",
  ];

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Service", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              _buildSectionTitle("Title"),
              _buildTextField("Enter Title",
                  maxLength: 50, controller: titleController),
              SizedBox(height: 20),
              _buildSectionTitle("Description"),
              _buildTextField("Enter Description",
                  maxLength: 200, controller: descriptionController),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPriceField(
                      label: "Price",
                      hintText: "Enter Your Price",
                      controller: priceController),
                  SizedBox(width: 5),
                  _buildDropdownField(
                      label: "Duration", items: durations, value: selectedDuration),
                ],
              ),
              SizedBox(height: 20),
              _buildDropdownField(
                  label: "Category", items: categories, value: selectedCategory),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.file_copy, color: Colors.white),
                  label: Text("Add Files"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(8, 38, 76, 1),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await Controller().postservice(Servicemodel(
                        title: titleController.text,
                        description: descriptionController.text,
                        price: double.parse(priceController.text),
                        duration: _getDurationInHours(selectedDuration),
                        category: selectedCategory));
                  },
                  child: Text("Post Service"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(8, 38, 76, 1),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Color.fromRGBO(8, 38, 76, 1)),
    );
  }

  Widget _buildTextField(String hintText,
      {int? maxLength, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: hintText,
          counterText: '',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildPriceField(
      {required String label,
      required String hintText,
      required TextEditingController controller}) {
    return SizedBox(
      width:  MediaQuery.of(context).size.width*.350 ,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          hintText: hintText,
          counterText: '',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      {required String label, required List<String> items, required String value}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: (newValue) {
          setState(() {
            if (label == "Duration") { 
              selectedDuration = newValue!;
            } else {
              selectedCategory = newValue!;
            }
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          hintText: label,
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  int _getDurationInHours(String duration) {
    switch (duration) {
      case '1 Hour':
        return 1;
      case '2 Hours':
        return 2;
      case '4 Hours':
        return 4;
      case 'Less than 24 Hours':
        return 24;
      default:
        return 0;
    }
  }
}
