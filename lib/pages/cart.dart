import 'package:flutter/material.dart';

class Producto {
  final String nombre;
  final double precio;
  final String imageUrl;
  int cantidad;

  Producto({
    required this.nombre,
    required this.precio,
    required this.imageUrl,
    this.cantidad = 1, 
  });
}

class CarritoPage extends StatefulWidget {
  final List<Producto> carrito; 

  const CarritoPage({super.key, required this.carrito});

  @override
  // ignore: library_private_types_in_public_api
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  double calcularTotal() {
    double total = 0;
    for (var producto in widget.carrito) {
      total += producto.precio * producto.cantidad;
    }
    return total;
  }

  void eliminarDelCarrito(int index) {
    setState(() {
      widget.carrito.removeAt(index);
    });
  }

  void incrementarCantidad(int index) {
    setState(() {
      widget.carrito[index].cantidad++;
    });
  }

  void disminuirCantidad(int index) {
    setState(() {
      if (widget.carrito[index].cantidad > 1) {
        widget.carrito[index].cantidad--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: const FractionalOffset(0.4, 0),
          child: Text('My cart'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.carrito.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: widget.carrito.length,
                  itemBuilder: (context, index) {
                    final producto = widget.carrito[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 16.0), 
                      padding: EdgeInsets.all(8.0), 
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15), 
                            child: SizedBox(
                              width: 150, 
                              height: 200, 
                              child: Image.network(
                                producto.imageUrl,
                                fit: BoxFit.cover, 
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  producto.nombre,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$${producto.precio.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () => disminuirCantidad(index),
                                    ),
                                    Text(
                                      '${producto.cantidad}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () => incrementarCantidad(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                              onPressed: () {
                                eliminarDelCarrito(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('It has been removed from the cart!'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }, 
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

            if (widget.carrito.isEmpty)
              Text(
                'The cart is empty. Add at least 1 products.',
                style: TextStyle(fontSize: 24, color: Colors.black),
                
              ),
            if (widget.carrito.isEmpty)
            SizedBox(height: 480),
            if (widget.carrito.isNotEmpty)
            SizedBox(height: 20),
            if (widget.carrito.isNotEmpty)
            TextField(
             decoration: InputDecoration( labelText: 'Promotional Code', border: OutlineInputBorder(), suffixIcon: Icon(Icons.arrow_forward_ios_rounded) ),
            ),
            SizedBox(height: 30),
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Subtotal ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          WidgetSpan( child: SizedBox(width: 230),),
          TextSpan(
            text: '\$${calcularTotal().toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
    SizedBox(height: 30),
    RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Shipping ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey, 
            ),
          ),
          WidgetSpan( child: SizedBox(width: 230),),
          TextSpan(
            text: '\$0.00',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black, 
            ),
          ),
        ],
      ),
    ),
    SizedBox(height: 30),
    Divider(
      color: Colors.black, 
      thickness: 1, 
      indent: 0, 
      endIndent: 0, 
    ),
    RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Total: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey, 
            ),
          ),
          WidgetSpan( child: SizedBox(width: 255),),
          TextSpan(
            text: '\$${(calcularTotal() + 0).toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black, 
            ),
          ),
        ],
      ),
    ),
  ],
),
              SizedBox(height: 30),
              Center(
              child: ElevatedButton(
                onPressed: () {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Checkout processing.."),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 150.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Checkout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ), 
          ],
        ),
      ),
    );
  }
}
