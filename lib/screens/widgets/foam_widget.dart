import 'dart:convert';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/models/app_categories_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app_settings/fonts.dart';
import '../../controllers/History/history_controller.dart';
import '../../functions/conversions.dart';

class FoamWidget extends StatefulWidget {
  final Map<String, dynamic> foamDetails;
  final Map<dynamic, dynamic> foamItems;

  const FoamWidget({
    required this.foamItems,
    required this.foamDetails,
    super.key,
  });

  @override
  State<FoamWidget> createState() => _FoamWidgetState();
}

class _FoamWidgetState extends State<FoamWidget> {
  final historyController = Get.put(HistoryController());
  String getExtraDetail(String key) {
    final value = widget.foamDetails['extraDetail']?[key];
    if (value == null) return '';
    if (value.toString().toLowerCase() == 'null') {
      return '';
    }
    return value.toString();
  }

  var dateConvertor = "";
  @override
  Widget build(BuildContext context) {
    final status = widget.foamDetails['status']?.toString().toLowerCase() ?? '';
    final rawDate = widget.foamDetails['date']?.toString();
    if (rawDate != null && rawDate.toString().isNotEmpty) {
      dateConvertor = formatDate(rawDate.toString());
    }
    int sectionIndex = 1;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              ExpansionTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(Icons.category, color: Colors.blue.shade700),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Module name
                    Obx(() {
                      final selectedCategoryId =
                          historyController.selectedCategory.value;
                      final selectedCategory = historyController.allTabs
                          .firstWhere(
                            (tab) => tab.id == selectedCategoryId,
                            orElse:
                                () => AllTabModel(
                                  id: 0,
                                  formName: "No Category",
                                  categoryId: 0,
                                  status: 0,
                                ), // dummy fallback
                          );

                      return Text(
                        selectedCategory.formName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      );
                    }),

                    const SizedBox(height: 6),

                    // Row with badge + requested at
                    Row(
                      children: [
                        // Status badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                status == 'pending'
                                    ? Colors.orange.shade100
                                    : status == 'rejected'
                                    ? Colors.red.shade100
                                    : Colors.green.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.foamDetails['status'].toString(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color:
                                  status == 'pending'
                                      ? Colors.orange.shade800
                                      : status == 'rejected'
                                      ? Colors.red.shade800
                                      : Colors.green.shade800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Requested At
                      ],
                    ),
                  ],
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey.shade700,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        _buildInfoSection(sectionIndex++),
                        const SizedBox(height: 10),
                        _buildFoamRequest(sectionIndex++),

                        if (widget.foamItems['is_image'] == 1) ...[
                          const SizedBox(height: 10),
                          _buildFoamImages(sectionIndex++),
                        ],

                        if (widget.foamItems['is_description_box'] == 1) ...[
                          const SizedBox(height: 10),
                          _buildFoamDescription(sectionIndex++),
                        ],

                        if (widget.foamItems['is_extra_sa2'] == 1) ...[
                          const SizedBox(height: 10),
                          _buildExtraSA2(sectionIndex++),
                        ],

                        if (widget.foamItems['is_verification_document'] ==
                            1) ...[
                          const SizedBox(height: 10),
                          _buildFoamIncomeVerification(sectionIndex++),
                        ],

                        if (widget.foamItems['is_verification_document'] ==
                            2) ...[
                          _buildEssentialImages(
                            sectionIndex++,
                            widget.foamDetails['extraDetail']['image_response']
                                as List<dynamic>,
                          ),
                        ],
                        SizedBox(height: 10),
                        if (widget.foamItems['is_verification_document'] ==
                            3) ...[
                          _buildFoamEducation(sectionIndex++),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 5,
            right: 15,
            child: Text(
              "Requested at: ${dateConvertor.toString()}",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// SECTION 1 - User Info
  Widget _buildInfoSection(int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index. User Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.secondaryFontFamily,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildField(
                  Icons.person,
                  'Name',
                  widget.foamDetails['userName']?.toString() ?? '-',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildField(
                  Icons.phone,
                  'Contact #',
                  widget.foamDetails['userContact']?.toString() ?? '-',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildField(
            Icons.home,
            'Address',
            widget.foamDetails['address']?.toString() ?? '-',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildField(
                  Icons.map,
                  'Territorial Authority',
                  widget.foamDetails['TA']?.toString() ?? '-',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildField(
                  Icons.location_city,
                  'Statistical Area',
                  widget.foamDetails['SA2']?.toString() ?? '-',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildField(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.blueGrey),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value.isNotEmpty ? value : "-",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: "Roboto",
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  /// SECTION 2 - Request Info
  Widget _buildFoamRequest(int index) {
    var dateConvert = "";
    final rawDate = widget.foamDetails['extraDetail']?['request_date_response'];
    if (rawDate != null && rawDate.toString().isNotEmpty) {
      dateConvert = formatDate(rawDate.toString());
    }
    List<Widget> rows = [];

    void addRow(List<Widget> children) {
      if (children.isNotEmpty) {
        if (rows.isNotEmpty) {
          rows.add(
            const SizedBox(height: 20),
          ); // spacing only if previous exists
        }
        rows.add(_buildRequestRow(children));
      }
    }

    addRow([
      if (widget.foamItems['is_category'] == 1)
        _buildRequestColumn(
          getExtraDetail('category_title'),
          getExtraDetail('category_response'),
        ),

      if (widget.foamItems['is_type'] == 1)
        Expanded(
          child: _buildRequestColumn(
            getExtraDetail('type_title'),
            getExtraDetail('type_response'),
          ),
        ),
      if (widget.foamItems['is_selected'] == 1)
        _buildRequestColumn(
          getExtraDetail('selected_type_title'),
          getExtraDetail('selected_type_response'),
        ),
    ]);

    addRow([
      if (widget.foamItems['is_category2'] == 1)
        _buildRequestColumn(
          getExtraDetail('category_title2'),
          getExtraDetail('category_response2'),
        ),
      if (widget.foamItems['is_type2'] == 1)
        _buildRequestColumn(
          getExtraDetail('type_title2'),
          getExtraDetail('type_response2'),
        ),
      if (widget.foamItems['is_selected3'] == 1)
        _buildRequestColumn(
          getExtraDetail('selected_type_title3'),
          getExtraDetail('selected_type_response3'),
        ),
    ]);

    addRow([
      if (widget.foamItems['is_person_name'] == 1)
        _buildRequestColumn(
          getExtraDetail('person_name_title'),
          getExtraDetail('person_name_response'),
        ),
    ]);

    addRow([
      if (widget.foamItems['is_item_name'] == 1)
        _buildRequestColumn(
          getExtraDetail('item_name_title'),
          getExtraDetail('item_name_response'),
        ),
    ]);

    addRow([
      if (widget.foamItems['is_size'] == 1)
        _buildRequestColumn(
          getExtraDetail('size_title'),
          getExtraDetail('size_response'),
        ),
      if (widget.foamItems['is_quantity'] == 1)
        _buildRequestColumn(
          getExtraDetail('quantity_title'),
          getExtraDetail('quantity_response'),
        ),
    ]);

    addRow([
      if (widget.foamItems['is_preference_date_time'] == 1 &&
          widget.foamDetails['extraDetail']?['request_date_title'] != null)
        _buildRequestColumn(getExtraDetail('request_date_title'), dateConvert),
      if (widget.foamDetails['extraDetail']?['request_time_title'] != null)
        _buildRequestColumn(
          getExtraDetail('request_time_title'),
          getExtraDetail('request_time_response'),
        ),
    ]);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index. Request Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.secondaryFontFamily,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          ...rows,
        ],
      ),
    );
  }

  Widget _buildRequestRow(List<Widget> children) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(children.length, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right:
                  index == children.length - 1
                      ? 0
                      : 12, // spacing only between items
            ),
            child: children[index],
          ),
        );
      }),
    );
  }

  Widget _buildRequestColumn(dynamic title, dynamic response) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: Text(
            title.toString(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Expanded(
            child: Text(
              response.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: "Roboto",
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///Section 3 for Images
  Widget _buildFoamImages(int index) {
    final baseUrl = AppSettings.baseUrl;
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$index. ${widget.foamDetails['extraDetail']?['image_title'] ?? ''}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.secondaryFontFamily,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              baseUrl +
                  (widget.foamDetails['extraDetail']?['image_response'] ?? ''),
              width: 140,
              height: 140,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoamDescription(int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index. Description Box',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.secondaryFontFamily,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),

          Text(
            widget.foamDetails['extraDetail']?['description_title']
                    .toString() ??
                '',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              widget.foamDetails['extraDetail']?['description_response']
                      .toString() ??
                  '',
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: "Roboto",
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtraSA2(int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index. Crime Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.secondaryFontFamily,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildRequestColumn(
                  getExtraDetail('crime_ta_title'),
                  getExtraDetail('crime_ta_response'),
                ),
              ),
              Expanded(
                child: _buildRequestColumn(
                  getExtraDetail('crime_Sa_title'),
                  getExtraDetail('crime_Sa_response'),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          _buildRequestColumn(
            getExtraDetail('crime_address_title'),
            getExtraDetail('crime_address_response'),
          ),
          SizedBox(height: 5),
          _buildRequestColumn(
            getExtraDetail('description_title'),
            getExtraDetail('description_response'),
          ),
        ],
      ),
    );
  }

  Widget _buildFoamIncomeVerification(int index) {
    final baseUrl = AppSettings.baseUrl;
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$index. ${widget.foamDetails['extraDetail']?['income_verification_title'] ?? ''}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.secondaryFontFamily,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              baseUrl +
                  (widget.foamDetails['extraDetail']?['income_verification_response'] ??
                      ''),
              width: 140,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEssentialImages(int index, List<dynamic> items) {
    final baseUrl = AppSettings.baseUrl;

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$index. Item Images",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 20),

          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, i) {
                final item = items[i] as Map<String, dynamic>;
                final imageUrl = "$baseUrl${item['image']}";
                final name = item['name'] ?? "No name";
                final description = item['description'] ?? "";

                return Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl,
                          width: 160,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoamEducation(int index) {
    final extraDetail = widget.foamDetails['extraDetail'] ?? {};

    // Define a list of fields so we can loop
    final List<Map<String, String>> items = [
      {
        "title": extraDetail['identity_title'] ?? '',
        "file": extraDetail['identity_response'] ?? '',
      },
      {
        "title": extraDetail['transcript_title'] ?? '',
        "file": extraDetail['transcript_response'] ?? '',
      },
      {
        "title": extraDetail['enrollment_title'] ?? '',
        "file": extraDetail['enrollment_response'] ?? '',
      },
      {
        "title": extraDetail['income_title'] ?? '',
        "file": extraDetail['income_response'] ?? '',
      },
      {
        "title": extraDetail['personal_statement_title'] ?? '',
        "file": extraDetail['personal_statement_response'] ?? '',
      },
      {
        "title": extraDetail['cv_title'] ?? '',
        "file": extraDetail['cv_response'] ?? '',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: items.length,
        itemBuilder: (context, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _buildFileViewer(items[i]['file'] ?? '')),
              const SizedBox(height: 8),
              Text(
                "${items[i]['title']}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.secondaryFontFamily,
                  fontSize: 14,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _buildFileViewer(String filePath) {
  if (filePath.isEmpty) {
    return const Text("No file uploaded");
  }
  String fixedPath = filePath.replaceFirst("upload/", "uploads/");
  String fixedUrl = fixedPath;
  if (!fixedUrl.startsWith("http")) {
    fixedUrl =
        '${AppSettings.baseUrl.replaceAll(RegExp(r'/$'), '')}/${fixedPath.replaceFirst(RegExp(r'^/'), '')}';
  }

  print("🔗 Final File URL: $fixedUrl");
  final lowerUrl = fixedUrl.toLowerCase();

  if (lowerUrl.endsWith(".jpg") ||
      lowerUrl.endsWith(".jpeg") ||
      lowerUrl.endsWith(".png") ||
      lowerUrl.endsWith(".gif") ||
      lowerUrl.endsWith(".webp")) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        fixedUrl,
        width: 140,
        height: 140,
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) =>
                Icon(Icons.image_not_supported_outlined),
      ),
    );
  }

  if (lowerUrl.endsWith(".pdf")) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(fixedUrl)),
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red[100],
        ),
        child: const Center(
          child: Icon(Icons.picture_as_pdf, size: 50, color: Colors.red),
        ),
      ),
    );
  }

  if (lowerUrl.endsWith(".doc") || lowerUrl.endsWith(".docx")) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(fixedUrl)),
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue[100],
        ),
        child: const Center(
          child: Icon(Icons.description, size: 50, color: Colors.blue),
        ),
      ),
    );
  }

  // ✅ Fallback
  return InkWell(
    onTap: () => launchUrl(Uri.parse(fixedUrl)),
    child: Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: const Center(
        child: Icon(
          Icons.insert_drive_file,
          size: 50,
          color: Color.fromARGB(255, 252, 198, 0),
        ),
      ),
    ),
  );
}
