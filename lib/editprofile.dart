import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux/data/helperprovider.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final Myprofilemodel? currentUserModel;

  const EditProfile({Key? key, this.currentUserModel}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _firstNameController;
  late TextEditingController _secondNameController;
  late TextEditingController _aboutMeController;
  late TextEditingController _skillController;
  late TextEditingController _qualificationController;
  late TextEditingController _experienceController;
  late TextEditingController _ageController;
  late TextEditingController _phonenumberController;
  late String _selectedGender;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.currentUserModel?.firstname ?? '');
    _secondNameController =
        TextEditingController(text: widget.currentUserModel?.secondname ?? '');
    _aboutMeController =
        TextEditingController(text: widget.currentUserModel?.aboutme ?? '');
    _phonenumberController =
        TextEditingController(text: widget.currentUserModel?.phoneNumber ?? '');
    _skillController =
        TextEditingController(text: widget.currentUserModel?.skill ?? '');
    _qualificationController =
        TextEditingController(text: widget.currentUserModel?.qualification ?? '');
    _experienceController =
        TextEditingController(text: widget.currentUserModel?.experience ?? '');
    _ageController = TextEditingController(
        text: widget.currentUserModel?.age.toString() ?? '');
    _selectedGender = widget.currentUserModel?.gender ?? 'Male';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _secondNameController.dispose();
    _aboutMeController.dispose();
    _skillController.dispose();
    _qualificationController.dispose();
    _experienceController.dispose();
    _ageController.dispose();
    _phonenumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final helper = Provider.of<HelperProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: widget.currentUserModel?.url != null
                        ? NetworkImage(widget.currentUserModel!.url)
                        : const AssetImage("assets/profile_placeholder.png")
                            as ImageProvider,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () async {
                        await helper.imagePicker().then((value) {
                          FirebaseFirestore.instance
                              .collection('Profile Info')
                              .doc(widget.currentUserModel!.id)
                              .update({
                            'url': helper.url,
                          });
                        });
                      },
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField(_firstNameController, 'First Name'),
            _buildTextField(_secondNameController, 'Second Name'),
            _buildTextField(_aboutMeController, 'About Me'),
            _buildTextField(_phonenumberController, 'Phone Number'),
            _buildTextField(_skillController, 'Skill'),
            _buildTextField(_qualificationController, 'Qualification'),
            _buildTextField(_experienceController, 'Experience'),
            _buildTextField(_ageController, 'Age', keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
              items: ['Male', 'Female', 'Other'].map((gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                  backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _saveChanges() async {
    final updatedProfile = Myprofilemodel(
      firstname: _firstNameController.text,
      secondname: _secondNameController.text,
      aboutme: _aboutMeController.text,
      skill: _skillController.text,
      qualification: _qualificationController.text,
      experience: _experienceController.text,
      age: int.parse(_ageController.text),
      gender: _selectedGender,
      email: widget.currentUserModel!.email,
      url: widget.currentUserModel!.url,
      rating: widget.currentUserModel!.rating,
      phoneNumber: _phonenumberController.text,
    ).data(widget.currentUserModel!.id);

    await FirebaseFirestore.instance
        .collection('Profile Info')
        .doc(widget.currentUserModel!.id)
        .update(updatedProfile)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Successfully updated")),
      );
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update: $error")),
      );
    });
  }
}
