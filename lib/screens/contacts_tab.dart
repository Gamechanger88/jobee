import 'dart:math';
import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';
import '../components/contacts_card.dart';

class ContactsTab extends material.StatefulWidget {
  final material.ThemeMode themeMode;

  const ContactsTab({super.key, this.themeMode = material.ThemeMode.light});

  @override
  ContactsTabState createState() => ContactsTabState();
}

class ContactsTabState extends material.State<ContactsTab> {
  List<Map<String, dynamic>> _contacts = [];
  String? _errorMessage;
  bool _isLoading = true;
  final material.ValueNotifier<int> _selectedShift =
      material.ValueNotifier<int>(3);
  final material.ValueNotifier<int> _selectedDistance =
      material.ValueNotifier<int>(0);
  final material.ValueNotifier<int> _selectedConsultation =
      material.ValueNotifier<int>(1);

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    print('Starting to load contacts');
    try {
      List<Map<String, dynamic>> allProfiles = [
        {
          "id": "1000001",
          "name": "Sarita Kale",
          "saved_name": "Sarita Nurse Papa",
          "gender": "Female",
          "location": "Rohini",
          "city": "Delhi",
          "images": [
            "assets/images/female_asian_car.png",
            "assets/images/female_white.png",
            "assets/images/female_asian_office.png",
          ],
          "role": "Staff Nurse",
          "experience": 10,
          "qualifications": "M.Sc. Nursing",
          "ranking": 1,
        },
        {
          "id": "1000002",
          "name": "Priya Sharma",
          "saved_name": "Priya Nurse Max",
          "gender": "Female",
          "location": "Saket",
          "city": "Delhi",
          "images": [
            "assets/images/female_white2.png",
            "assets/images/female_asian_traveller.png",
            "assets/images/female_white3.png",
          ],
          "role": "Staff Nurse",
          "experience": 8,
          "qualifications": "B.Sc. Nursing",
          "ranking": 3,
        },
        {
          "id": "1000003",
          "name": "Vikram Singh",
          "saved_name": "Vikram Nurse AIIMS",
          "gender": "Male",
          "location": "Vasant Kunj",
          "city": "Delhi",
          "images": [
            "assets/images/male_indian.png",
            "assets/images/male_india1.png",
            "assets/images/male_white.png",
          ],
          "role": "Staff Nurse",
          "experience": 7,
          "qualifications": "B.Sc. Nursing",
          "ranking": 5,
        },
        {
          "id": "2000001",
          "name": "Angad Singh",
          "saved_name": "Angad Sing Attendant carehealth",
          "gender": "Male",
          "location": "Sushant Lok",
          "city": "Gurgaon",
          "images": [
            "assets/images/male_white2.png",
            "assets/images/male_white_student.png",
            "assets/images/male_indian.png",
          ],
          "role": "Attendant",
          "experience": 6,
          "qualifications": "High School",
          "ranking": 2,
        },
        {
          "id": "2000002",
          "name": "Salman Sheikh",
          "saved_name": "Sonu Nurse Papa",
          "gender": "Male",
          "location": "Dwarka",
          "city": "Delhi",
          "images": [
            "assets/images/male_indian2.png",
            "assets/images/male_white_blazer.png",
            "assets/images/male_white_mall.png",
          ],
          "role": "Attendant",
          "experience": 5,
          "qualifications": "High School",
          "ranking": 4,
        },
        {
          "id": "2000003",
          "name": "Meena Kumari",
          "saved_name": "Meena Attendant HomeCare",
          "gender": "Female",
          "location": "Noida Sector 18",
          "city": "Noida",
          "images": [
            "assets/images/female_asian_car.png",
            "assets/images/female_white.png",
            "assets/images/female_asian_office.png",
          ],
          "role": "Attendant",
          "experience": 4,
          "qualifications": "High School",
          "ranking": 6,
        },
        {
          "id": "3000001",
          "name": "Anjali Gupta",
          "saved_name": "Anjali Physio Medanta",
          "gender": "Female",
          "location": "Sector 62",
          "city": "Noida",
          "images": [
            "assets/images/female_white2.png",
            "assets/images/female_asian_traveller.png",
            "assets/images/female_white3.png",
          ],
          "role": "Physiotherapist",
          "experience": 9,
          "qualifications": "MPT",
          "ranking": 3,
        },
        {
          "id": "3000002",
          "name": "Rahul Verma",
          "saved_name": "Rahul Physio Apollo",
          "gender": "Male",
          "location": "Ballabgarh",
          "city": "Faridabad",
          "images": [
            "assets/images/male_indian.png",
            "assets/images/male_india1.png",
            "assets/images/male_white.png",
          ],
          "role": "Physiotherapist",
          "experience": 7,
          "qualifications": "BPT",
          "ranking": 5,
        },
        {
          "id": "4000001",
          "name": "Raman Joshi",
          "saved_name": "Dr Raman Joshi Neuro Fortis VK",
          "gender": "Male",
          "location": "Vasant Vihar",
          "city": "Delhi",
          "images": [
            "assets/images/male_white2.png",
            "assets/images/male_white_student.png",
            "assets/images/male_indian.png",
          ],
          "role": "Doctor",
          "experience": 12,
          "qualifications": "MD Neurology",
          "ranking": 1,
        },
        {
          "id": "4000002",
          "name": "Akash Singh",
          "saved_name": "Dr Akash Singh Fortis",
          "gender": "Male",
          "location": "Greater Kailash",
          "city": "Delhi",
          "images": [
            "assets/images/male_indian2.png",
            "assets/images/male_white_blazer.png",
            "assets/images/male_white_mall.png",
          ],
          "role": "Doctor",
          "experience": 10,
          "qualifications": "MD Cardiology",
          "ranking": 2,
        },
      ];

      print('Total profiles loaded: ${allProfiles.length}');
      for (var profile in allProfiles) {
        print(
          'Profile: ID=${profile['id']}, name=${profile['name']}, saved_name=${profile['saved_name']}',
        );
      }

      final random = Random();
      final selectedProfiles = <Map<String, dynamic>>[];
      while (selectedProfiles.length < 5 && allProfiles.isNotEmpty) {
        final index = random.nextInt(allProfiles.length);
        selectedProfiles.add(allProfiles.removeAt(index));
      }

      print('Selected ${selectedProfiles.length} random profiles');
      for (var profile in selectedProfiles) {
        print(
          'Selected profile: ID=${profile['id']}, name=${profile['name']}, saved_name=${profile['saved_name']}',
        );
      }

      setState(() {
        _contacts = selectedProfiles;
        _errorMessage = null;
        _isLoading = false;
      });
      print('Loaded ${_contacts.length} contacts');
    } catch (e, stack) {
      print('Error loading contacts: $e\n$stack');
      setState(() {
        _errorMessage = 'Failed to load contacts: $e';
        _isLoading = false;
      });
    }
  }

  @override
  material.Widget build(material.BuildContext context) {
    print(
      'Building ContactsTab: isLoading=$_isLoading, contacts=${_contacts.length}, error=$_errorMessage',
    );
    return material.Scaffold(
      backgroundColor: AppColors.white,
      body: material.Padding(
        padding: const material.EdgeInsets.symmetric(horizontal: 24),
        child: material.Column(
          crossAxisAlignment: material.CrossAxisAlignment.start,
          children: [
            const material.SizedBox(height: 16),
            const material.Text(
              'Contacts',
              style: material.TextStyle(
                fontSize: 18,
                fontWeight: material.FontWeight.w700,
                color: AppColors.grey900,
              ),
            ),
            const material.SizedBox(height: 16),
            material.Expanded(
              child:
                  _errorMessage != null
                      ? material.Center(
                        child: material.Text(
                          _errorMessage!,
                          style: const material.TextStyle(
                            color: AppColors.grey600,
                          ),
                        ),
                      )
                      : _isLoading
                      ? const material.Center(
                        child: material.CircularProgressIndicator(),
                      )
                      : _contacts.isEmpty
                      ? const material.Center(
                        child: material.Text(
                          'No contacts found',
                          style: const material.TextStyle(
                            color: AppColors.grey600,
                          ),
                        ),
                      )
                      : material.ListView.separated(
                        itemCount: _contacts.length,
                        separatorBuilder:
                            (context, index) =>
                                const material.SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final contact = _contacts[index];
                          final startTime = DateTime.now();
                          final widget = material.Padding(
                            padding: const material.EdgeInsets.symmetric(
                              vertical: 6,
                            ),
                            child: ContactsCard(
                              profile: contact,
                              selectedShift: _selectedShift,
                              selectedDistance: _selectedDistance,
                              selectedConsultation: _selectedConsultation,
                            ),
                          );
                          final endTime = DateTime.now();
                          print(
                            'Rendered contact ${contact['id']} in ${(endTime.difference(startTime)).inMilliseconds}ms',
                          );
                          return widget;
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _selectedShift.dispose();
    _selectedDistance.dispose();
    _selectedConsultation.dispose();
    super.dispose();
  }
}
