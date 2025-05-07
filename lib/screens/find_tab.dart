import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import '../constants/colors.dart';
import '../components/index.dart';

class FindTab extends material.StatefulWidget {
  final material.ThemeMode themeMode;

  const FindTab({super.key, this.themeMode = material.ThemeMode.light});

  @override
  FindTabState createState() => FindTabState();
}

class FindTabState extends material.State<FindTab> {
  int _selectedProfessionIndex = 0; // Default: Nurse (index 0)
  final material.ValueNotifier<int> _selectedGender =
      material.ValueNotifier<int>(2); // Default: Both (2)
  final material.ValueNotifier<int> _selectedShift =
      material.ValueNotifier<int>(3); // Default: 24 hrs (3)
  final material.ValueNotifier<int> _selectedDistance =
      material.ValueNotifier<int>(0); // Default: All (0)
  final material.ValueNotifier<int> _selectedConsultation =
      material.ValueNotifier<int>(1); // Default: Teleconsultation (1)
  final material.ValueNotifier<int> _selectedFilter =
      material.ValueNotifier<int>(0); // Default: None (0)
  List<Map<String, dynamic>> _cachedProfiles = []; // Cache filtered profiles

  Future<List<Map<String, dynamic>>> loadProfiles() async {
    String filePath;
    switch (_selectedProfessionIndex) {
      case 0: // Nurse
        filePath = 'assets/data/staff_nurses.json';
        break;
      case 1: // Attendant
        filePath = 'assets/data/attendants.json';
        break;
      case 2: // Physio
        filePath = 'assets/data/physiotherapists.json';
        break;
      case 3: // Doctor
        filePath = 'assets/data/doctors.json';
        break;
      default:
        filePath = 'assets/data/staff_nurses.json';
    }
    try {
      final String response = await material.DefaultAssetBundle.of(
        context,
      ).loadString(filePath);
      final profiles = await compute(
        jsonDecode,
        response,
      ).then((data) => data.cast<Map<String, dynamic>>());
      _cachedProfiles = profiles; // Cache profiles on load
      return profiles;
    } catch (e) {
      print('Error loading profiles: $e');
      return [];
    }
  }

  void _onProfessionChanged(int index) {
    setState(() {
      _selectedProfessionIndex = index;
      // Set defaults based on profession
      if (index == 0 || index == 1) {
        _selectedGender.value = 2; // Both
        _selectedShift.value = 3; // 24 hrs
        _selectedDistance.value = 0; // All
        _selectedConsultation.value = 0;
        _selectedFilter.value = 0;
      } else if (index == 2) {
        _selectedGender.value = 0;
        _selectedShift.value = 0;
        _selectedDistance.value = 0; // All
        _selectedConsultation.value = 0;
        _selectedFilter.value = 0;
      } else if (index == 3) {
        _selectedGender.value = 0;
        _selectedShift.value = 0;
        _selectedDistance.value = 0;
        _selectedConsultation.value = 1; // Teleconsultation
        _selectedFilter.value = 0;
      } else {
        _selectedGender.value = 0;
        _selectedShift.value = 0;
        _selectedDistance.value = 0;
        _selectedConsultation.value = 0;
        _selectedFilter.value = 0;
      }
      _cachedProfiles = []; // Clear cache on profession change
      print(
        'Profession changed to: $index, Gender: ${_selectedGender.value}, Shift: ${_selectedShift.value}, Distance: ${_selectedDistance.value}',
      );
    });
  }

  void _onGenderChanged(int index) {
    setState(() {
      _selectedGender.value = index;
      print('Gender changed to: $index');
    });
  }

  void _onShiftChanged(int index) {
    _selectedShift.value = index;
    // Reset distance for 24-hour shift
    if ((_selectedProfessionIndex == 0 || _selectedProfessionIndex == 1) &&
        index == 3) {
      _selectedDistance.value = 0;
      print('Distance reset to 0 for 24-hour shift');
    }
    print('Shift changed to: $index');
  }

  void _onDistanceChanged(int index) {
    setState(() {
      _selectedDistance.value = index;
      _cachedProfiles = []; // Invalidate cache to force profile reload
      print('Distance changed to: $index');
    });
  }

  void _onConsultationChanged(int index) {
    _selectedConsultation.value = index;
    print('Consultation changed to: $index');
  }

  void _onFilterChanged(int index) {
    _selectedFilter.value = index;
    print('Filter changed to: $index');
  }

  List<Map<String, dynamic>> _filterProfiles(
    List<Map<String, dynamic>> profiles,
  ) {
    final sourceProfiles =
        _cachedProfiles.isNotEmpty ? _cachedProfiles : profiles;

    final filtered =
        sourceProfiles.where((profile) {
            bool matchesGender = true;
            bool matchesDistance = true;
            bool matchesConsultation = true;

            // Nurse or Attendant: Filter by Gender and Distance
            if (_selectedProfessionIndex == 0 ||
                _selectedProfessionIndex == 1) {
              if (_selectedGender.value == 1) {
                matchesGender = profile['gender'] == 'Male';
              } else if (_selectedGender.value == 3) {
                matchesGender = profile['gender'] == 'Female';
              } else if (_selectedGender.value == 2) {
                matchesGender = true; // Both
              }
              // Apply distance filter
              if (_selectedDistance.value == 0) {
                matchesDistance = true; // All profiles
              } else if (_selectedDistance.value == 1) {
                matchesDistance =
                    profile['distance_from_client'] != null &&
                    profile['distance_from_client'] <= 5;
              } else if (_selectedDistance.value == 2) {
                matchesDistance =
                    profile['distance_from_client'] != null &&
                    profile['distance_from_client'] > 5 &&
                    profile['distance_from_client'] <= 10;
              } else if (_selectedDistance.value == 3) {
                matchesDistance =
                    profile['distance_from_client'] != null &&
                    profile['distance_from_client'] > 10;
              }
            }
            // Physio: Filter by Distance
            else if (_selectedProfessionIndex == 2) {
              if (_selectedDistance.value == 0) {
                matchesDistance = true; // All profiles
              } else if (_selectedDistance.value == 1) {
                matchesDistance =
                    profile['distance_from_client'] != null &&
                    profile['distance_from_client'] <= 5 &&
                    profile['rates'] != null &&
                    profile['rates']['up_to_5_km'] is num &&
                    profile['rates']['up_to_5_km'] != "Not interested";
              } else if (_selectedDistance.value == 2) {
                matchesDistance =
                    profile['distance_from_client'] != null &&
                    profile['distance_from_client'] > 5 &&
                    profile['distance_from_client'] <= 10 &&
                    profile['rates'] != null &&
                    profile['rates']['5_to_10_km'] is num &&
                    profile['rates']['5_to_10_km'] != "Not interested";
              } else if (_selectedDistance.value == 3) {
                matchesDistance =
                    profile['distance_from_client'] != null &&
                    profile['distance_from_client'] > 10 &&
                    profile['rates'] != null &&
                    profile['rates']['beyond_10_km'] is num &&
                    profile['rates']['beyond_10_km'] != "Not interested";
              }
            }
            // Doctor: Filter by Consultation
            else if (_selectedProfessionIndex == 3) {
              if (_selectedConsultation.value == 1) {
                matchesConsultation =
                    profile['rates'] != null &&
                    profile['rates']['teleconsultation'] is num &&
                    profile['rates']['teleconsultation'] != "Not interested";
              } else if (_selectedConsultation.value == 2) {
                matchesConsultation =
                    profile['distance_from_client'] != null &&
                    profile['distance_from_client'] > 5 &&
                    profile['distance_from_client'] <= 10 &&
                    profile['rates'] != null &&
                    profile['rates']['5_to_10_km'] is num &&
                    profile['rates']['5_to_10_km'] != "Not interested";
              } else if (_selectedConsultation.value == 3) {
                matchesConsultation =
                    profile['distance_from_client'] != null &&
                    profile['distance_from_client'] > 10 &&
                    profile['rates'] != null &&
                    profile['rates']['beyond_10_km'] is num &&
                    profile['rates']['beyond_10_km'] != "Not interested";
              }
            }

            print(
              'Filtering profile: ${profile['id']}, Gender: ${profile['gender']}, MatchesGender: $matchesGender, Distance: ${profile['distance_from_client']}, MatchesDistance: $matchesDistance',
            );
            return matchesGender && matchesDistance && matchesConsultation;
          }).toList()
          ..sort((a, b) {
            bool aAvailable = true;
            bool bAvailable = true;

            // Check shift availability for Nurse/Attendant
            if (_selectedProfessionIndex == 0 ||
                _selectedProfessionIndex == 1) {
              if (_selectedShift.value == 1) {
                aAvailable =
                    a['rates'] != null && a['rates']['day_shift'] is num;
                bAvailable =
                    b['rates'] != null && b['rates']['day_shift'] is num;
              } else if (_selectedShift.value == 2) {
                aAvailable =
                    a['rates'] != null && a['rates']['night_shift'] is num;
                bAvailable =
                    b['rates'] != null && b['rates']['night_shift'] is num;
              } else if (_selectedShift.value == 3) {
                aAvailable =
                    a['rates'] != null && a['rates']['24_hour_shift'] is num;
                bAvailable =
                    b['rates'] != null && b['rates']['24_hour_shift'] is num;
              }
              // Sort by experience for Nurse/Attendant
              if (aAvailable && !bAvailable) return -1;
              if (!aAvailable && bAvailable) return 1;
              return (b['experience'] ?? 0).compareTo(a['experience'] ?? 0);
            }
            // For Physio, sort by experience
            else if (_selectedProfessionIndex == 2) {
              return (b['experience'] ?? 0).compareTo(a['experience'] ?? 0);
            }
            // For Doctor, sort by experience
            else if (_selectedProfessionIndex == 3) {
              return (b['experience'] ?? 0).compareTo(a['experience'] ?? 0);
            }
            // Default: Sort by experience
            return (b['experience'] ?? 0).compareTo(a['experience'] ?? 0);
          });

    print('Filtered profiles: ${filtered.length}');
    return filtered;
  }

  @override
  material.Widget build(material.BuildContext context) {
    return material.Scaffold(
      body: material.Padding(
        padding: const material.EdgeInsets.symmetric(horizontal: 24),
        child: material.Column(
          mainAxisAlignment: material.MainAxisAlignment.start,
          children: [
            // First row: AppTopBar with UserTypeAppBar variant
            AppTopBar(
              variant: TopBarVariant.UserTypeAppBar,
              themeMode: widget.themeMode,
              onBackPressed: () {
                material.Navigator.pop(context);
              },
            ),
            // Second row: UserTypeSelector
            material.Padding(
              padding: const material.EdgeInsets.symmetric(vertical: 6),
              child: UserTypeSelector(onTabChanged: _onProfessionChanged),
            ),
            // Third row: SecondaryFilter
            material.Padding(
              padding: const material.EdgeInsets.symmetric(vertical: 6),
              child: SecondaryFilter(
                activeIndex: _selectedProfessionIndex,
                selectedGender: _selectedGender,
                selectedShift: _selectedShift,
                selectedDistance: _selectedDistance,
                selectedConsultation: _selectedConsultation,
                selectedFilter: _selectedFilter,
                onGenderChanged: _onGenderChanged,
                onShiftChanged: _onShiftChanged,
                onDistanceChanged: _onDistanceChanged,
                onConsultationChanged: _onConsultationChanged,
                onFilterChanged: _onFilterChanged,
              ),
            ),
            // Fourth row: JobCards from selected profession
            material.Expanded(
              child: material.FutureBuilder<List<Map<String, dynamic>>>(
                future: loadProfiles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      material.ConnectionState.waiting) {
                    return const material.Center(
                      child: material.CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return material.Center(
                      child: material.Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const material.Center(
                      child: material.Text('No profiles found'),
                    );
                  }
                  final filteredProfiles = _filterProfiles(snapshot.data!);
                  if (filteredProfiles.isEmpty) {
                    return const material.Center(
                      child: material.Text('No matching profiles found'),
                    );
                  }
                  return material.ListView.builder(
                    itemCount: filteredProfiles.length,
                    itemBuilder: (context, index) {
                      return material.Padding(
                        padding: const material.EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                        child: JobCard(
                          profile: filteredProfiles[index],
                          selectedShift: _selectedShift,
                          selectedDistance: _selectedDistance,
                          selectedConsultation: _selectedConsultation,
                        ),
                      );
                    },
                  );
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
    _selectedGender.dispose();
    _selectedShift.dispose();
    _selectedDistance.dispose();
    _selectedConsultation.dispose();
    _selectedFilter.dispose();
    super.dispose();
  }
}
