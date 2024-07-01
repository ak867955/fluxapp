import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flux/chatpage.dart';
import 'package:flux/model/addressmodel.dart';
import 'package:flux/model/collection.dart';
import 'package:flux/flux.dart';

class AddressVerification extends StatefulWidget {
  const AddressVerification({super.key});

  @override
  State<AddressVerification> createState() => _AddressVerificationState(); 
}

class _AddressVerificationState extends State<AddressVerification> {
  final housenameController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();
  String? selectedState;

  final List<String> districts = [
  'Alappuzha',
  'Ernakulam',
  'Idukki',
  'Kannur',
  'Kasaragod',
  'Kollam',
  'Kottayam',
  'Kozhikode',
  'Malappuram',
  'Palakkad',
  'Pathanamthitta',
  'Thiruvananthapuram',
  'Thrissur',
  'Wayanad',
  ];

  @override
  void dispose() {
    housenameController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text(
                "Get verified to access all features",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "Complete your address verification to unlock additional features and functionalities.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Account status",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "Unverified",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Enter your address information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: housenameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "House Name",
                  prefixIcon: Icon(Icons.home),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "City",
                  prefixIcon: Icon(Icons.location_city),
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedState,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "District",
                  prefixIcon: Icon(Icons.map),
                ),
                items: districts.map((String state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedState = newValue;
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: pincodeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Postal Code",
                  prefixIcon: Icon(Icons.local_post_office),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await Controller().addaddress(Addressmodel(
                        housename: housenameController.text,
                        city: cityController.text,
                        districts: selectedState!,
                        pincode: int.parse(pincodeController.text),
                      ));
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Success"),
                            content: Text("Successfully saved"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => bottomnavipage(initialIndex: 0)));
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Failed to save. Please try again."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text("Start Verification"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(8, 38, 76, 1),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
