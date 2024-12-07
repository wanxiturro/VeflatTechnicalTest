import 'package:flutter/material.dart';
import '/api/character.dart';
import 'cart.dart';

class CharacterDetailPage extends StatefulWidget {
  final Character character;
  final double price;
  final List<Producto> carrito;

  const CharacterDetailPage({
    super.key,
    required this.character,
    required this.price,
    required this.carrito,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CharacterDetailPageState createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCharacterImage(),
            const SizedBox(height: 16),
            _buildCharacterName(),
            const SizedBox(height: 8),
            _buildPriceInfo(),
            const SizedBox(height: 8),
            _buildRatingRow(),
            const Spacer(),
            _buildAddToCartButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(widget.character.name),
      actions: [
        IconButton(
          icon: Icon(isFavorited ? Icons.star : Icons.star_border),
          onPressed: () => _toggleFavorite(context),
        ),
      ],
    );
  }

  Widget _buildCharacterImage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            widget.character.imageUrl,
            width: 700,
            height: 500,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterName() {
    return Text(
      widget.character.name,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPriceInfo() {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: "Price: ",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          TextSpan(
            text: "\$${widget.price.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow() {
    return Row(
      children: const [
        Icon(Icons.star, color: Colors.orange),
        Icon(Icons.star, color: Colors.orange),
        Icon(Icons.star, color: Colors.orange),
        Icon(Icons.star, color: Colors.orange),
        Icon(Icons.star, color: Colors.orange),
        Text(" 5/5", style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _addToCart,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 150.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text(
          "Add to cart",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _toggleFavorite(BuildContext context) {
    setState(() {
      isFavorited = !isFavorited;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isFavorited
                ? '${widget.character.name} has been added to favorites'
                : '${widget.character.name} has been removed from favorites',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _addToCart() {
    final producto = Producto(
      nombre: widget.character.name,
      precio: widget.price,
      imageUrl: widget.character.imageUrl,
    );

    setState(() {
      widget.carrito.add(producto);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${widget.character.name} has been added to cart"),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
