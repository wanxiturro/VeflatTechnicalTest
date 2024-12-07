import 'dart:convert';
import 'package:http/http.dart' as http;
import 'character.dart'; 

class ApiService {
  final String apiUrl = 'https://rickandmortyapi.com/api/character';

  Future<List<Character>> fetchCharacters({String? nextPageUrl}) async {
    final url = nextPageUrl ?? apiUrl; 

      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List characters = data['results'];
        
        List<Character> characterList = characters.map((char) => Character.fromJson(char)).toList();

        // ignore: unused_local_variable
        String? nextPage = data['info']['next'];
        
        return characterList;
      } else {
        throw Exception('Un error ha ocurrido :( (${response.statusCode})');
      }
  }
}
