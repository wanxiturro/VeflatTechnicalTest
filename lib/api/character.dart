class Character {
  final String name;
  final String status;
  final String species;
  final String gender;
  final String imageUrl; 

  Character({
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.imageUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      imageUrl: json['image'], // Asigna la URL de la imagen
    );
  }
}
