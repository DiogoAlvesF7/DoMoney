// lib/screens/news_carousel.dart
// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Noticias extends StatelessWidget {
  CarouselSliderController? _noticiasController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 80, // Tornar o carrossel mais quadrado
      color: Colors.grey, // Cor de fundo

      child: CarouselSlider(
        items: [
          _buildNewsButton(context, 'NOTÍCIA 1'),
          _buildNewsButton(context, 'NOTÍCIA 2'),
          _buildNewsButton(context, 'NOTÍCIA 3'),
          _buildNewsButton(context, 'NOTÍCIA 4'),
        ],
        carouselController: _noticiasController,
        options: CarouselOptions(
          initialPage: 0,
          viewportFraction: 0.6, // Tornar os itens mais largos
          disableCenter: true,
          enlargeCenterPage: true,
          enlargeFactor: 0.5, // Controlar o aumento do item central
          enableInfiniteScroll: true,
          scrollDirection: Axis.horizontal,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          onPageChanged: (index, reason) {},
        ),
      ),
    );
  }

  Widget _buildNewsButton(BuildContext context, String text) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          print('$text pressed');
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          foregroundColor: Colors.black,
          textStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
        child: Text(text),
      ),
    );
  }
}
