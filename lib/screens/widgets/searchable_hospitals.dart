
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../app_settings/settings.dart';
import '../../controllers/profile/test.dart';

class HospitalModel {
  final String id;
  final String name;
  final double longitude;
  final double latitude;
  final String address;
  final int type;

  HospitalModel({
    required this.id,
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.type,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown',
      latitude: (json['latitude'] is String)
          ? double.tryParse(json['latitude']) ?? 0.0
          : (json['latitude']?.toDouble() ?? 0.0),
      longitude: (json['longitude'] is String)
          ? double.tryParse(json['longitude']) ?? 0.0
          : (json['longitude']?.toDouble() ?? 0.0),
      address: json['address']?.toString() ?? '',
      type: json['type'] ?? 0,
    );
  }

  static List<HospitalModel> fromJsonList(dynamic jsonList) {
    if (jsonList == null) return [];
    return List<HospitalModel>.from(jsonList.map((item) => HospitalModel.fromJson(item)));
  }

  @override
  String toString() => name;
}

class SearchableDropdownHospitals extends StatefulWidget {
  final String apiUrl = "${AppSettings.baseUrl}doctor/get-all-hospital-and-clinic";
  final ValueChanged<String>? onItemSelected;
  final String selectedValues;

  const SearchableDropdownHospitals({
    super.key,
    this.onItemSelected,
    required this.selectedValues,
  });

  @override
  State<SearchableDropdownHospitals> createState() => _SearchableDropdownHospitalsState();
}

class _SearchableDropdownHospitalsState extends State<SearchableDropdownHospitals> {
  HospitalModel? _selectedHospital;
  final TextEditingController _displayInputController = TextEditingController();

  void _selectHospital(HospitalModel hospital) {
    setState(() {
      _selectedHospital = hospital;
      _displayInputController.text = hospital.name;
    });
    widget.onItemSelected?.call(hospital.id);
    Navigator.of(context).pop();
  }

  void _clearSelection() {
    setState(() {
      _selectedHospital = null;
      _displayInputController.clear();
    });
    widget.onItemSelected?.call('');
  }

  void _showSearchModal() {

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: _SearchModalContent(
              apiUrl: widget.apiUrl,
              onHospitalSelected: _selectHospital,
              selectedValues: widget.selectedValues,
            ),
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _showSearchModal,
          child: AbsorbPointer(
            child: TextFormField(
              controller: _displayInputController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Select Hospital',
                hintText: 'Tap to search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                ),
                suffixIcon: _selectedHospital != null
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: _clearSelection,
                )
                    : const Icon(Icons.arrow_drop_down, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _displayInputController.dispose();
    super.dispose();
  }
}

class _SearchModalContent extends StatefulWidget {
  final String apiUrl;
  final Function(HospitalModel hospital) onHospitalSelected;
  final String selectedValues;

  const _SearchModalContent({
    required this.apiUrl,
    required this.onHospitalSelected,
    required this.selectedValues,
  });

  @override
  State<_SearchModalContent> createState() => _SearchModalContentState();
}

class _SearchModalContentState extends State<_SearchModalContent> {
  final TextEditingController _modalSearchInputController = TextEditingController();
  String _currentSearchQuery = '';

  List<HospitalModel> _allHospitals = [];
  List<HospitalModel> _filteredHospitals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHospitals();
    _modalSearchInputController.addListener(_onSearchChanged);
  }

  Future<void> _fetchHospitals() async {
    setState(() => _isLoading = true);

    try {
      final uri = Uri.parse(
        widget.apiUrl + (_currentSearchQuery.isEmpty ? '' : '?name_like=$_currentSearchQuery'),
      );

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"city_id":widget.selectedValues.isEmpty || widget.selectedValues == 'null' ? null :widget.selectedValues  }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseBody = json.decode(response.body);
        final List<dynamic> data = responseBody['data'] ?? [];
        setState(() {
          _allHospitals = HospitalModel.fromJsonList(data);
          _onSearchChanged();
        });
      } else {
        debugPrint('Failed to load hospitals: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      debugPrint('Error fetching hospitals: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onSearchChanged() {
    final query = _modalSearchInputController.text;
    setState(() {
      _currentSearchQuery = query;
      _filteredHospitals = _allHospitals.where((hospital) {
        if (query.isEmpty) return true;
        return hospital.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Search Hospitals',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black87),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
            child: TextField(
              controller: _modalSearchInputController,
              decoration: InputDecoration(
                hintText: 'Type to search...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.blueGrey[50],
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                suffixIcon: _currentSearchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () => _modalSearchInputController.clear(),
                )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredHospitals.isEmpty
                ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_hospital_outlined, size: 48, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('No hospitals found.', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
                : ListView.builder(
              itemCount: _filteredHospitals.length,
              itemBuilder: (context, index) {
                final hospital = _filteredHospitals[index];
                final bool isOddRow = index % 2 != 0;

                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => widget.onHospitalSelected(hospital),
                    hoverColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    splashColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                    child: Container(
                      color: isOddRow ? Colors.grey[50] : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.place, color: Theme.of(context).primaryColor),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hospital.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  hospital.address,
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _modalSearchInputController.removeListener(_onSearchChanged);
    _modalSearchInputController.dispose();
    super.dispose();
  }
}
