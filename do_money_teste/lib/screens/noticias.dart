import 'package:flutter/material.dart';

class NoticiasPage extends StatelessWidget {
  final List<Map<String, String>> noticiasDestaque = [
    {
      "titulo": "Mercado de ações fecha em alta pelo 3º dia consecutivo",
      "imagem": "https://via.placeholder.com/300x200",
      "resumo": "Bolsas sobem impulsionadas por balanços positivos.",
    },
    {
      "titulo": "Bitcoin atinge máxima histórica após novas regulamentações",
      "imagem": "https://via.placeholder.com/300x200",
      "resumo": "Criptomoeda ultrapassa barreira de 70 mil dólares.",
    },
    {
      "titulo": "Taxa Selic é mantida, e mercado reage de forma positiva",
      "imagem": "https://via.placeholder.com/300x200",
      "resumo": "Banco Central sinaliza estabilidade nos juros.",
    },
  ];

  final Map<String, List<Map<String, String>>> noticiasPorCategoria = {
    "Mercado de Ações": [
      {
        "titulo": "Empresas do setor tech lideram ganhos na bolsa",
        "imagem": "https://via.placeholder.com/150x100",
        "resumo": "Microsoft e Apple apresentam crescimento acima do esperado.",
      },
      {
        "titulo":
            "Índice Nasdaq sobe 2% após anúncio de resultados trimestrais",
        "imagem": "https://via.placeholder.com/150x100",
        "resumo": "Mercado de tecnologia impulsiona alta nos EUA.",
      },
    ],
    "Criptomoedas": [
      {
        "titulo": "Ethereum implementa nova atualização com sucesso",
        "imagem": "https://via.placeholder.com/150x100",
        "resumo": "Mudanças prometem maior eficiência energética.",
      },
      {
        "titulo": "Binance anuncia expansão de operações no Brasil",
        "imagem": "https://via.placeholder.com/150x100",
        "resumo": "Exchange busca ampliar mercado latino-americano.",
      },
    ],
    "Taxas de Juros": [
      {
        "titulo": "Inflação desacelera, mas juros permanecem altos",
        "imagem": "https://via.placeholder.com/150x100",
        "resumo": "Economistas esperam redução no próximo trimestre.",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notícias",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carrossel de Destaques
            _buildCarrosselDestaque(),

            const SizedBox(height: 24),

            // Seções de Categorias
            ..._buildNoticiasPorCategoria(),
          ],
        ),
      ),
    );
  }

  // Carrossel Horizontal de Notícias em Destaque
  Widget _buildCarrosselDestaque() {
    return SizedBox(
      height: 220,
      child: PageView.builder(
        itemCount: noticiasDestaque.length,
        itemBuilder: (context, index) {
          final noticia = noticiasDestaque[index];
          return _buildCardDestaque(noticia);
        },
      ),
    );
  }

  Widget _buildCardDestaque(Map<String, String> noticia) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(noticia["imagem"]!),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              noticia["titulo"]!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Notícias por Categoria
  List<Widget> _buildNoticiasPorCategoria() {
    return noticiasPorCategoria.entries.map((categoria) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoria.key,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: categoria.value.map((noticia) {
              return _buildCardNoticia(noticia);
            }).toList(),
          ),
          const SizedBox(height: 24),
        ],
      );
    }).toList();
  }

  Widget _buildCardNoticia(Map<String, String> noticia) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: Image.network(
          noticia["imagem"]!,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: Text(
          noticia["titulo"]!,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          noticia["resumo"]!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
