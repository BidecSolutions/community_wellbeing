class DoctorList {
  final int id;
  final String name;
  final String image;
  final String major;
  final String venue;
  final String des;
  final String experience;


  DoctorList({
    required this.id,
    required this.name,
    required this.image,
    required this.major,
    required this.venue,
    required this.des,
    required this.experience,

  });

  factory DoctorList.fromJson(Map<String, dynamic> json) {
    return DoctorList(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      major: json['specialization'],
      venue: json['hospitalName'],
      des: json['potfolio_decription'],
      experience: json['experience'],

    );
  }
}



class DoctorOpdList {
  final int id;
  final String hospitalName;
  final String day;
  final String start;
  final String end;
  final int opdType;
  final int  fee;
  final int patient;
  final int doctorID;

  DoctorOpdList({
    required this.id,
    required this.hospitalName,
    required this.day,
    required this.start,
    required this.end,
    required this.opdType,
    required this.fee,
    required this.patient,
    required this.doctorID,
  });

  factory DoctorOpdList.fromJson(Map<String, dynamic> json) {
    return DoctorOpdList(
      id: json['id'],
      hospitalName: json['name'],
      day: json['day'],
      start: json['start_from'],
      end: json['end_from'],
      opdType: json['opd_type'],
      fee: json['doctor_fee'],
      patient: json['no_of_patient'],
      doctorID: json['doctor_id']
    );
  }
}