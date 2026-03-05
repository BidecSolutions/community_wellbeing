class Coach {
  final int id;
  final String name;
  final String image;
  final String qualification;
  final String description;
  final int experience;
  final List<dynamic> slots;

  Coach({
    required this.id,
    required this.name,
    required this.image,
    required this.qualification,
    required this.description,
    required this.experience,
    required this.slots,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      qualification: json['qualification'],
      description: json['description'],
      experience: json['experience'],
      slots: json['slots'],
    );
  }
}
