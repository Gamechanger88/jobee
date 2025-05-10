import 'dart:convert';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart' show rootBundle;
import '../constants/colors.dart';
import '../components/index.dart';
import '../components/jobs_card.dart';

class JobsTab extends material.StatefulWidget {
  final material.ThemeMode themeMode;

  const JobsTab({super.key, this.themeMode = material.ThemeMode.light});

  @override
  JobsTabState createState() => JobsTabState();
}

class JobsTabState extends material.State<JobsTab> {
  int _selectedProfessionIndex = 0;
  final material.ValueNotifier<int> _selectedGender =
      material.ValueNotifier<int>(2);
  final material.ValueNotifier<int> _selectedShift =
      material.ValueNotifier<int>(0);
  final material.ValueNotifier<int> _selectedDistance =
      material.ValueNotifier<int>(0);
  final material.ValueNotifier<int> _selectedConsultation =
      material.ValueNotifier<int>(1);
  final material.ValueNotifier<int> _selectedFilter =
      material.ValueNotifier<int>(0);
  List<Map<String, dynamic>> _cachedJobs = [];
  List<Map<String, dynamic>>? _lastFilteredJobs;
  String? _lastFilterKey;

  Future<List<Map<String, dynamic>>> loadJobs() async {
    if (_cachedJobs.isNotEmpty) return _cachedJobs;

    const filePath = 'assets/data/jobs.json';
    try {
      final String response = await rootBundle.loadString(filePath);
      final data = jsonDecode(response);
      List<Map<String, dynamic>> jobs;
      if (data is List) {
        jobs = data.cast<Map<String, dynamic>>();
      } else if (data is Map && data['jobs'] is List) {
        jobs = (data['jobs'] as List<dynamic>).cast<Map<String, dynamic>>();
      } else {
        print('Unexpected JSON structure');
        return [];
      }

      for (var job in jobs) {
        job['dateTime'] = parseJobDateTime(job);
        job['requirement_lower'] =
            (job['requirement'] as String?)?.toLowerCase() ?? '';
        job['gender_lower'] = (job['gender'] as String?)?.toLowerCase() ?? '';
        job['shift_lower'] = (job['shift'] as String?)?.toLowerCase() ?? '';
      }

      // Assume jobs.json is pre-sorted by dateTime (most recent first)
      _cachedJobs = jobs;
      print('Loaded ${jobs.length} jobs from jobs.json');
      return jobs;
    } catch (e) {
      print('Error loading jobs: $e');
      return [];
    }
  }

  void _onProfessionChanged(int index) {
    setState(() {
      _selectedProfessionIndex = index;
      if (index == 0 || index == 1) {
        _selectedGender.value = 2;
        _selectedShift.value = 0;
        _selectedDistance.value = 0;
        _selectedConsultation.value = 0;
        _selectedFilter.value = 0;
      } else if (index == 2) {
        _selectedGender.value = 2;
        _selectedShift.value = 0;
        _selectedDistance.value = 0;
        _selectedConsultation.value = 0;
        _selectedFilter.value = 0;
      } else if (index == 3) {
        _selectedGender.value = 2;
        _selectedShift.value = 0;
        _selectedDistance.value = 0;
        _selectedConsultation.value = 1;
        _selectedFilter.value = 0;
      } else {
        _selectedGender.value = 2;
        _selectedShift.value = 0;
        _selectedDistance.value = 0;
        _selectedConsultation.value = 0;
        _selectedFilter.value = 0;
      }
      _lastFilteredJobs = null; // Invalidate cache
    });
  }

  void _onGenderChanged(int index) {
    setState(() {
      _selectedGender.value = index;
      _lastFilteredJobs = null;
    });
  }

  void _onShiftChanged(int index) {
    setState(() {
      _selectedShift.value = index;
      if ((_selectedProfessionIndex == 0 || _selectedProfessionIndex == 1) &&
          index == 3) {
        _selectedDistance.value = 0;
      }
      _lastFilteredJobs = null;
    });
  }

  void _onDistanceChanged(int index) {
    setState(() {
      _selectedDistance.value = index;
      _lastFilteredJobs = null;
    });
  }

  void _onConsultationChanged(int index) {
    setState(() {
      _selectedConsultation.value = index;
      _lastFilteredJobs = null;
    });
  }

  void _onFilterChanged(int index) {
    setState(() {
      _selectedFilter.value = index;
      _lastFilteredJobs = null;
    });
  }

  DateTime parseJobDateTime(Map<String, dynamic> job) {
    try {
      final dateStr = job['date']?.toString();
      final timeStr = job['time']?.toString();
      if (dateStr == null || timeStr == null) return DateTime.now();

      final dateParts = dateStr.split('-');
      if (dateParts.length != 3) return DateTime.now();

      final year = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final day = int.parse(dateParts[2]);

      final timeParts = timeStr.toLowerCase().split(':');
      if (timeParts.length < 2) return DateTime.now();

      int hour = int.parse(timeParts[0]);
      final minuteStr = timeParts[1];
      int minute = int.parse(minuteStr.replaceAll(RegExp(r'[a-zA-Z]'), ''));
      bool isPM = minuteStr.contains('pm');
      if (isPM && hour < 12) hour += 12;
      if (!isPM && hour == 12) hour = 0;

      return DateTime(year, month, day, hour, minute);
    } catch (e) {
      return DateTime.now();
    }
  }

  List<Map<String, dynamic>> _filterJobs(List<Map<String, dynamic>> jobs) {
    final filterKey =
        '$_selectedProfessionIndex-${_selectedGender.value}-${_selectedShift.value}-${_selectedDistance.value}-${_selectedConsultation.value}-${_selectedFilter.value}';
    if (_lastFilterKey == filterKey && _lastFilteredJobs != null) {
      return _lastFilteredJobs!;
    }

    final sourceJobs = _cachedJobs.isNotEmpty ? _cachedJobs : jobs;
    final filtered =
        sourceJobs.where((job) {
          bool matchesProfession = true;
          bool matchesGender = true;
          bool matchesShift = true;
          bool matchesDistance = true;

          final requirement = job['requirement_lower'] as String;
          if (_selectedProfessionIndex == 0) {
            matchesProfession = requirement == 'staff nurse';
          } else if (_selectedProfessionIndex == 1) {
            matchesProfession = requirement == 'attendant';
          } else if (_selectedProfessionIndex == 2) {
            matchesProfession = requirement == 'physiotherapist';
          } else if (_selectedProfessionIndex == 3) {
            matchesProfession = requirement == 'doctor';
          }

          final gender = job['gender_lower'] as String;
          if (_selectedGender.value == 1) {
            matchesGender = gender == 'male';
          } else if (_selectedGender.value == 3) {
            matchesGender = gender == 'female';
          }

          final shift = job['shift_lower'] as String;
          const validShifts = {'8am - 8pm', '8pm - 8am', '24 hours', 'visit'};
          if (_selectedShift.value == 1) {
            matchesShift = shift == '8am - 8pm';
          } else if (_selectedShift.value == 2) {
            matchesShift = shift == '8pm - 8am';
          } else if (_selectedShift.value == 3) {
            matchesShift = shift == '24 hours';
          } else if (_selectedShift.value == 4) {
            matchesShift = shift == 'visit';
          } else {
            matchesShift = validShifts.contains(shift);
          }

          final distance = job['distance'] as num?;
          if (_selectedDistance.value == 1) {
            matchesDistance = distance != null && distance <= 5.0;
          } else if (_selectedDistance.value == 2) {
            matchesDistance =
                distance != null && distance > 5.0 && distance <= 10.0;
          } else if (_selectedDistance.value == 3) {
            matchesDistance = distance != null && distance > 10.0;
          }

          return matchesProfession &&
              matchesGender &&
              matchesShift &&
              matchesDistance;
        }).toList();

    _lastFilterKey = filterKey;
    _lastFilteredJobs = filtered;
    print('Filtered jobs: ${filtered.length}');
    return filtered;
  }

  @override
  material.Widget build(material.BuildContext context) {
    return material.Scaffold(
      appBar: material.AppBar(
        title: const material.Text('Jobs'),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      backgroundColor: AppColors.white,
      body: material.Padding(
        padding: const material.EdgeInsets.symmetric(horizontal: 24),
        child: material.Column(
          children: [
            material.Padding(
              padding: const material.EdgeInsets.symmetric(vertical: 6),
              child: UserTypeSelector(onTabChanged: _onProfessionChanged),
            ),
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
            material.Expanded(
              child: material.FutureBuilder<List<Map<String, dynamic>>>(
                future: loadJobs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      material.ConnectionState.waiting) {
                    return const material.Center(
                      child: material.CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const material.Center(
                      child: material.Text('Error loading jobs'),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const material.Center(
                      child: material.Text('No jobs found'),
                    );
                  }
                  final filteredJobs = _filterJobs(snapshot.data!);
                  if (filteredJobs.isEmpty) {
                    return const material.Center(
                      child: material.Text('No matching jobs found'),
                    );
                  }
                  return material.ListView.separated(
                    cacheExtent: 1000.0,
                    itemCount: filteredJobs.length,
                    separatorBuilder:
                        (context, index) => const material.SizedBox(height: 6),
                    itemBuilder: (context, index) {
                      final job = filteredJobs[index];
                      final start = DateTime.now().millisecondsSinceEpoch;
                      final widget = JobsCard(job: job);
                      material.WidgetsBinding.instance.addPostFrameCallback((
                        _,
                      ) {
                        print(
                          'Rendered job ${job['id']} in ${DateTime.now().millisecondsSinceEpoch - start}ms',
                        );
                      });
                      return widget;
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
