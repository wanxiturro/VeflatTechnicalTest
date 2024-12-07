import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '/api/rick_and_morty_service.dart';
import '/api/character.dart';
import 'cart.dart';
import 'description.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<Character> characters = [];
  final List<Producto> carrito = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    final apiService = ApiService();
    final charactersFromApi = await apiService.fetchCharacters();
    setState(() {
      characters = charactersFromApi;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Find Your Character',
                        style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  _buildPromoCard(),
                  const SizedBox(height: 16),
                  _buildCategoryButtons(context),
                  Expanded(child: _buildCharacterCarousel()),
                ],
              ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: IconButton(
        onPressed: () => _showSnackBar(context, "We haven't added a menu yet!"),
        icon: const Icon(Icons.menu, size: 32),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, size: 32),
          onPressed: () => _showSnackBar(context, 'This button is purely decorative!'),
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart, size: 32),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CarritoPage(carrito: carrito),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCard() {
    return Container(
      width: 350.0,
      height: 200.0,
      decoration: BoxDecoration(
        color: Colors.orange.shade200,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Stack(
        children: [
          const Align(
            alignment: FractionalOffset(0.08, 0.08),
            child: Text(
              'Dec 16 - Dec 31',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.orange),
            ),
          ),
          const Align(
            alignment: FractionalOffset(0.13, 0.27),
            child: Text(
              '25% Off',
              style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Align(
            alignment: FractionalOffset(0.13, 0.55),
            child: Text(
              'Super discount',
              style: TextStyle(fontSize: 25.0),
            ),
          ),
          Align(
            alignment: const FractionalOffset(0.1, 0.83),
            child: ElevatedButton(
              onPressed: () => _showSnackBar(context, 'This button is purely decorative!'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "Grab now",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Align(
            alignment: const FractionalOffset(1.3, 0),
            child: Image.network(
              'https://img.stickers.cloud/packs/3486ffd4-c84f-40c4-a424-8316eaaf5d75/png/1f174570-4c91-4ef3-91d0-187d74354cca.png',
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButtons(BuildContext context) {
    final categories = ['All', "Rick's", "Morty's"];
    final buttonStyles = [
      ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
          side: const BorderSide(color: Colors.black, width: 0.5),
        ),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: categories.asMap().entries.map((entry) {
        final index = entry.key;
        final category = entry.value;
        return Padding(
          padding: EdgeInsets.only(left: index == 0 ? 0.0 : 20.0, top: 20.0),
          child: ElevatedButton(
            onPressed: () => _showSnackBar(context, 'Test section, you can\'t enter!'),
            style: index == 0 ? buttonStyles[0] : buttonStyles[1],
            child: Text(
              category,
              style: TextStyle(
                color: index == 0 ? Colors.white : Colors.black,
                fontSize: 18,
                decoration: index == 0 ? TextDecoration.underline : null,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCharacterCarousel() {
    return CarouselSlider(
      items: characters.asMap().entries.map((entry) {
        final index = entry.key;
        final character = entry.value;
        final price = 50.0 * (index + 1);

        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CharacterDetailPage(
                character: character,
                price: price,
                carrito: carrito,
              ),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.network(
                      character.imageUrl,
                      width: 400,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    character.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 0.7,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        height: 400,
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}
