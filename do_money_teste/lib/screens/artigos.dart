import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Artigos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarousel(), // Carrossel de artigos recentes
            const SizedBox(height: 20),
            _buildFilterOptions(), // Filtro de assuntos
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Função para construir o carrossel de artigos recentes
  Widget _buildCarousel() {
    return CarouselSlider(
      items: [
        _buildCarouselItem(
          title: 'Educação Financeira para Iniciantes',
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsxR59jn_plamkfq5iOl2uiWttjJCTWYEfOw&s',
        ),
        _buildCarouselItem(
          title: 'Investimentos de Baixo Risco',
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsxR59jn_plamkfq5iOl2uiWttjJCTWYEfOw&s',
        ),
        _buildCarouselItem(
          title: 'Aprenda a Como Sair das Dívidas',
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsxR59jn_plamkfq5iOl2uiWttjJCTWYEfOw&s',
        ),
      ],
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
    );
  }

  // Função para construir um item do carrossel
  Widget _buildCarouselItem({required String title, required String imageUrl}) {
    return GestureDetector(
      onTap: () {
        // Lógica para navegar para o artigo
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir o filtro de assuntos
  Widget _buildFilterOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filtros de Artigos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: [
              _buildFilterChip(label: 'Educação Financeira'),
              _buildFilterChip(label: 'Investimentos'),
              _buildFilterChip(label: 'Dívidas'),
            ],
          ),
        ],
      ),
    );
  }

  // Função para construir um filtro Chip
  Widget _buildFilterChip({required String label}) {
    return FilterChip(
      label: Text(label),
      onSelected: (bool value) {
        // Lógica para filtrar os artigos
      },
    );
  }

  void main() {
    runApp(const MaterialApp(
      home: ArticlesPage(),
    ));
  }
}
