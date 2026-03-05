import 'package:community_app/app_settings/fonts.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String name;
  final String phone;
  final String address;
  final String ta;
  final String sa2;

  const UserInfo({
    super.key,
    this.name = '',
    this.phone = '',
    this.address = '',
    this.ta = '',
    this.sa2 = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ), // border added
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            '1 User Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.secondaryFontFamily,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildField(Icons.person, 'Name', name)),
              const SizedBox(width: 16),
              Expanded(child: _buildField(Icons.phone, 'Contact #', phone)),
            ],
          ),
          const SizedBox(height: 16),

          // Address
          _buildField(Icons.home, 'Address', address),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildField(Icons.map, 'Territorial Authority', ta),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildField(
                  Icons.location_city,
                  'Statistical Area',
                  sa2,
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
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            value.isNotEmpty ? value : "-",
            style: TextStyle(
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
}

// Request Details

class RequestInfo extends StatelessWidget {
  //category 1
  final String cate1title;
  final String cate1Response;
  //category 2
  final String cate2title;
  final String cate2Response;
  //category 3
  final String cate3title;
  final String cate3Response;

  //type 1
  final String type1title;
  final String type1Response;
  //type 2
  final String type2title;
  final String type2Response;
  //type 3
  final String type3title;
  final String type3Response;

  //select 1
  final String select1title;
  final String select1Response;
  //select 2
  final String select2title;
  final String select2Response;
  //select 3
  final String select3title;
  final String select3Response;

  //person Name
  final String personNameTitle;
  final String personNameResponse;

  //date
  final String preferredDateTitle;
  final String preferredDateResponse;

  //time
  final String preferredTimeTitle;
  final String preferredTimeResponse;

  //item name
  final String itemNameTitle;
  final String itemNameResponse;

  //size
  final String sizeTitle;
  final String sizeResponse;

  //quantity
  final String quantityTitle;
  final String quantityResponse;

  const RequestInfo({
    super.key,
    required this.cate1title,
    required this.cate1Response,
    required this.cate2title,
    required this.cate2Response,
    required this.cate3title,
    required this.cate3Response,
    required this.select1title,
    required this.select1Response,
    required this.select2title,
    required this.select2Response,
    required this.select3title,
    required this.select3Response,
    required this.type1title,
    required this.type1Response,
    required this.type2title,
    required this.type2Response,
    required this.type3title,
    required this.type3Response,
    required this.personNameTitle,
    required this.personNameResponse,
    required this.preferredDateTitle,
    required this.preferredDateResponse,
    required this.preferredTimeTitle,
    required this.preferredTimeResponse,
    required this.itemNameTitle,
    required this.itemNameResponse,
    required this.sizeTitle,
    required this.sizeResponse,
    required this.quantityTitle,
    required this.quantityResponse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(147, 237, 237, 237),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '2 Request Details',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto", // or your AppFonts.secondaryFontFamily
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              _fields(cate1title, cate1Response),
              const SizedBox(width: 10),
              _fields(select1title, select1Response),
              const SizedBox(width: 10),
              _fields(type1title, type1Response),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              _fields(cate2title, cate2Response),
              const SizedBox(width: 10),
              _fields(select2title, select2Response),
              const SizedBox(width: 10),
              _fields(type2title, type2Response),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              _fields(cate3title, cate3Response),
              const SizedBox(width: 10),
              _fields(select3title, select3Response),
              const SizedBox(width: 10),
              _fields(type3title, type3Response),
            ],
          ),
          const SizedBox(height: 12),

          // Row(
          //   children: [
          //     Expanded(child: _fields(preferredDate, preferredDateValue)),
          //     const SizedBox(width: 10),
          //     Expanded(child: _fields(preferredTime, preferredTimeValue)),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class CrimeInfo extends StatelessWidget {
  final String crimeTA;
  final String crimeSA2;
  final String crimeTAValue;
  final String crimeSA2Value;
  final String address;
  final String addressValue;

  const CrimeInfo({
    super.key,
    this.crimeTA = '',
    this.crimeSA2 = '',
    this.crimeTAValue = '',
    this.crimeSA2Value = '',
    this.address = '',
    this.addressValue = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(147, 237, 237, 237),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Crime Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.secondaryFontFamily,
            ),
          ),
          SizedBox(height: 8),
          _fields(address, addressValue),
          const SizedBox(width: 10),
          Row(
            children: [
              Expanded(child: _fields(crimeTA, crimeTAValue)),
              const SizedBox(width: 10),
              Expanded(child: _fields(crimeSA2, crimeSA2Value)),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class PreferedDateTime extends StatelessWidget {
  final String preferredDate;
  final String preferredDateValue;
  final String preferredTime;
  final String preferredTimeValue;

  const PreferedDateTime({
    super.key,
    this.preferredDate = '',
    this.preferredDateValue = '',
    this.preferredTime = '',
    this.preferredTimeValue = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(147, 237, 237, 237),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prefered Date & Time',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.secondaryFontFamily,
            ),
          ),
          SizedBox(height: 8),

          Row(
            children: [
              Expanded(child: _fields(preferredDate, preferredDateValue)),
              const SizedBox(width: 10),
              Expanded(child: _fields(preferredTime, preferredTimeValue)),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

Widget _fields(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 12),
        overflow: TextOverflow.ellipsis,
      ),
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(1),
        child: Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          softWrap: true,
        ),
      ),
    ],
  );
}

class ImageWidget extends StatelessWidget {
  final List<String> imageUrls;
  final double boxSize;

  const ImageWidget({super.key, required this.imageUrls, this.boxSize = 80});

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return const Text("No images available");
    }

    return SizedBox(
      height: boxSize,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrls[i],
              width: boxSize,
              height: boxSize,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, _, _) => Container(
                    width: boxSize,
                    height: boxSize,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  ),
            ),
          );
        },
      ),
    );
  }
}
