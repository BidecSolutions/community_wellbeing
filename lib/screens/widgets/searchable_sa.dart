import 'package:community_app/screens/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../app_settings/colors.dart';
import '../../app_settings/settings.dart';
import '../../controllers/profile/test.dart';

class UserModel {
  final String id;
  final String name;

  UserModel({required this.id, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown User',
    );
  }

  static List<UserModel> fromJsonList(dynamic jsonList) {
    if (jsonList == null) {
      return [];
    }
    return List<UserModel>.from(
      jsonList.map((item) => UserModel.fromJson(item)),
    );
  }

  @override
  String toString() => name;
}

class CustomSearchableDropdownSA extends StatefulWidget {
  final String apiUrl = "${AppSettings.baseUrl}housing/statistical-area";
  final ValueChanged<String>? onItemSelected;
  final String selectedValues;

  const CustomSearchableDropdownSA({
    super.key,
    this.onItemSelected,
    required this.selectedValues,
  });

  @override
  State<CustomSearchableDropdownSA> createState() =>
      _CustomSearchableDropdownSAState();
}

class _CustomSearchableDropdownSAState
    extends State<CustomSearchableDropdownSA> {
  UserModel? _selectedUserForDisplay;
  final TextEditingController _displayInputController = TextEditingController();
  void _selectUser(String id, String name) {
    setState(() {
      _selectedUserForDisplay = UserModel(id: id, name: name);
      _displayInputController.text = name;
    });
    widget.onItemSelected?.call(id);
    Navigator.of(context).pop();
  }

  void _clearSelection() {
    setState(() {
      _selectedUserForDisplay = null;
      _displayInputController.clear();
    });
    widget.onItemSelected?.call('');
  }

  void _showSearchModal() {
    if (widget.selectedValues.isEmpty) {
      final snackBarShow = Snackbar(
        title: 'Wait',
        message: "Please Select the Territorial Area First",
        type: 'error',
      );
      snackBarShow.show();
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: _SearchModalContent(
              apiUrl: widget.apiUrl,
              onUserSelected: _selectUser,
              selectedValues: widget.selectedValues,
            ),
          );
        },
      );
    }
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
                labelText: 'Select SA2',
                hintText: 'Tap to search...',
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(12.0),
                //   borderSide: const BorderSide(color: Colors.grey),
                // ),
                // enabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(12.0),
                //   borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
                // ),
                // focusedBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(12.0),
                //   borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                // ),
                suffixIcon:
                    _selectedUserForDisplay != null
                        ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: _clearSelection,
                        )
                        : const Icon(Icons.arrow_drop_down, color: Colors.grey),
                filled: true,
                fillColor: AppColors.whiteTextField,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 0.0,
                ),
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
  final Function(String id, String name) onUserSelected;
  final String selectedValues;

  const _SearchModalContent({
    required this.apiUrl,
    required this.onUserSelected,
    required this.selectedValues,
  });

  @override
  State<_SearchModalContent> createState() => _SearchModalContentState();
}

class _SearchModalContentState extends State<_SearchModalContent> {
  final TextEditingController _modalSearchInputController =
      TextEditingController();
  String _currentSearchQuery = '';

  List<UserModel> _allUsersFromApi = [];
  List<UserModel> _filteredUsers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsersFromApi();
    _modalSearchInputController.addListener(_onSearchChanged);
  }

  Future<void> _fetchUsersFromApi() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final uri = Uri.parse(
        widget.apiUrl +
            (_currentSearchQuery.isEmpty
                ? ''
                : '?name_like=$_currentSearchQuery'),
      );
      final id =
          (widget.selectedValues.isEmpty || widget.selectedValues == 'null')
              ? '0'
              : widget.selectedValues;
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"id": id}),
      );

      if (response.statusCode == 201) {
        final dynamic responseBody = json.decode(response.body);

        final List<dynamic> data = responseBody ?? [];
        setState(() {
          _allUsersFromApi = UserModel.fromJsonList(data);
          _onSearchChanged();
        });
      } else {
        debugPrint(
          'Failed to load users from API: ${response.statusCode} ${response.body}',
        );
        // TODO: Implement user-facing error message (e.g., SnackBar)
      }
    } catch (e) {
      debugPrint('Error fetching users: $e');
      // TODO: Implement user-facing error message
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    final query = _modalSearchInputController.text;
    setState(() {
      _currentSearchQuery = query;
      _filteredUsers =
          _allUsersFromApi.where((user) {
            if (query.isEmpty) return true;
            return user.name.toLowerCase().contains(query.toLowerCase());
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20.0),
        ), // Rounded top corners
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
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Search Statistical Area 2',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(color: Colors.black87),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.of(context).pop(), // Close button
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
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
                suffixIcon:
                    _currentSearchQuery.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _modalSearchInputController.clear();
                          },
                        )
                        : const SizedBox.shrink(),
              ),
            ),
          ),
          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _filteredUsers.isEmpty && _currentSearchQuery.isNotEmpty
                    ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_off, size: 48, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            'No Statistical Area found.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                    : _filteredUsers.isEmpty &&
                        _allUsersFromApi.isEmpty &&
                        !_isLoading
                    ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sentiment_dissatisfied,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'No Statistical Area Loaded.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      itemCount: _filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = _filteredUsers[index];
                        final bool isOddRow = index % 2 != 0;

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap:
                                () => widget.onUserSelected(user.id, user.name),
                            hoverColor: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.1),
                            splashColor: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.2),
                            child: Container(
                              color: isOddRow ? Colors.grey[50] : Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.place,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
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
