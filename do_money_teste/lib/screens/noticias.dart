import 'package:do_money_teste/screens/subscreens/filtro_noticias.dart';
import 'package:flutter/material.dart';

class NoticiasPage extends StatefulWidget {
  const NoticiasPage({super.key});

  @override
  State<NoticiasPage> createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  final List<String> categorias = [
    "Economia",
    "Ações",
    "Criptomoedas",
    "Investimentos",
    "Mercado"
  ];

  String categoriaSelecionada = "Economia"; // Apenas uma categoria selecionada

  final List<Map<String, dynamic>> todasNoticias = [
    // Economia
    {
      "titulo": "Inflação nos EUA surpreende e fica abaixo do esperado",
      "imagem":
          "https://www.portaldoagronegocio.com.br/img/cache/cover//storage/images/notices/65eb4e9e3b8c7.jpg",
      "fonte": "Reuters",
      "tempo": "2 horas atrás",
      "categoria": "Economia"
    },
    {
      "titulo": "PIB do Brasil cresce 3% no último trimestre",
      "imagem":
          "https://fly.metroimg.com/upload/q_85,w_700/https://uploads.metroimg.com/wp-content/uploads/2024/07/29125437/foto-brasil-dinheiro.jpg",
      "fonte": "Exame",
      "tempo": "4 horas atrás",
      "categoria": "Economia"
    },
    {
      "titulo": "Taxa Selic deve permanecer estável, dizem analistas",
      "imagem":
          "https://www.cashme.com.br/blog/wp-content/uploads/2020/06/taxa-selic-baixa.jpg",
      "fonte": "CNN Brasil",
      "tempo": "1 dia atrás",
      "categoria": "Economia"
    },
    // Ações
    {
      "titulo": "Ações da Apple atingem recorde histórico",
      "imagem":
          "https://yt3.googleusercontent.com/M6YRDTT4TuycM6WeCoAC3UBre6Yu_i7RnK6bIs8ysWM1PBJFBvA9uOryoK_kF_4UeHKvTpPdLCY=s900-c-k-c0x00ffffff-no-rj",
      "fonte": "Bloomberg",
      "tempo": "30 minutos atrás",
      "categoria": "Ações"
    },
    {
      "titulo": "Petrobras sobe 5% após novos contratos",
      "imagem":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRN-eDEy0Bvpav33qDC77FN3xslxNfWAa76VQ&s",
      "fonte": "Investing.com",
      "tempo": "3 horas atrás",
      "categoria": "Ações"
    },
    {
      "titulo": "Ações do Itaú disparam após balanço positivo",
      "imagem":
          "https://www.papoimobiliario.com/wp-content/uploads/2024/10/itau.jpg",
      "fonte": "Valor Econômico",
      "tempo": "2 horas atrás",
      "categoria": "Ações"
    },
    // criptomoedasmoedas
    {
      "titulo": "Bitcoin ultrapassa R\$ 350 mil e anima investidores",
      "imagem":
          "https://s2-valor.glbimg.com/CyoiyIEKcVGCDED4P_6rqRAcrt4=/0x0:6048x4024/888x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_63b422c2caee4269b8b34177e8876b93/internal_photos/bs/2023/J/j/1HkW6qT1O7GFU926duAw/bitcoin-dourado.jpg",
      "fonte": "CriptoNews",
      "tempo": "1 hora atrás",
      "categoria": "Criptomoedas"
    },
    {
      "titulo": "Ethereum dispara 10% com novas atualizações",
      "imagem": "https://www.empiricus.com.br/uploads/2023/02/ethereum.jpg",
      "fonte": "CoinDesk",
      "tempo": "4 horas atrás",
      "categoria": "Criptomoedas"
    },
    {
      "titulo": "Regulamentação de criptomoedas avança na Europa",
      "imagem": "https://empiricus.com.br/uploads/2022/11/Criptomoedas.jpg",
      "fonte": "Bloomberg",
      "tempo": "6 horas atrás",
      "categoria": "Criptomoedas"
    },
    // Investimentos
    {
      "titulo": "Fundos Imobiliários atraem mais investidores em 2024",
      "imagem":
          "https://ihublounge.com.br/wp-content/uploads/2023/05/TOPO-DE-BLOG-IHUB-Maio-2023-5-1.jpg",
      "fonte": "Exame",
      "tempo": "2 horas atrás",
      "categoria": "Investimentos"
    },
    {
      "titulo": "CDBs com liquidez diária ganham espaço no mercado",
      "imagem":
          "https://rankia.com.br/cdn-cgi/image/width=1024,quality=80,format=auto,onerror=redirect/app/uploads/2024/09/cdb_brasil.jpg",
      "fonte": "InvestNews",
      "tempo": "5 horas atrás",
      "categoria": "Investimentos"
    },
    {
      "titulo": "Tesouro Direto bate recorde de novos investidores",
      "imagem":
          "https://omentorfinanceiro.com.br/wp-content/uploads/2019/06/logo-tesouro-direto.png",
      "fonte": "CNN Economia",
      "tempo": "1 dia atrás",
      "categoria": "Investimentos"
    },
    // Mercado
    {
      "titulo": "Bolsas asiáticas fecham em alta com otimismo global",
      "imagem":
          "https://fly.metroimg.com/upload/q_85,w_700/https://uploads.metroimg.com/wp-content/uploads/2023/03/13085809/bolsa-asia-getty.jpg",
      "fonte": "Investing.com",
      "tempo": "6 horas atrás",
      "categoria": "Mercado"
    },
    {
      "titulo": "Preço do petróleo recua com aumento de oferta",
      "imagem":
          "https://img.freepik.com/fotos-premium/grafico-barril-petroleo-brent-generar-ai_98402-6806.jpg?w=360",
      "fonte": "Valor Econômico",
      "tempo": "7 horas atrás",
      "categoria": "Mercado"
    },
    {
      "titulo": "Europa enfrenta desaceleração no setor industrial",
      "imagem":
          "https://blog.solucoesindustriais.com.br/wp-content/uploads/2024/04/unnamed-2024-04-04T123029.984.jpg",
      "fonte": "Reuters",
      "tempo": "8 horas atrás",
      "categoria": "Mercado"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Notícias",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.filter_list_outlined,
              color: Colors.white, size: 28),
          tooltip: 'Abrir filtro',
          onPressed: () async {
            final resultado = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FiltroNoticiasPage(
                  categoriaSelecionada: categoriaSelecionada,
                  categoriasSelecionadas: [],
                ),
              ),
            );

            if (resultado != null && resultado is String) {
              setState(() {
                categoriaSelecionada = resultado;
              });
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Carrossel de Destaques
            _buildCarrosselDestaques(),

            const SizedBox(height: 24),

            // Filtro de Categorias
            _buildFiltroCategorias(),

            const SizedBox(height: 16),

            // Lista de Notícias Filtradas
            _buildSectionTitle("Mais relevantes para você"),
            _buildListaNoticias(),
          ],
        ),
      ),
    );
  }

  // Carrossel de Destaques
  Widget _buildCarrosselDestaques() {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: todasNoticias.length,
        itemBuilder: (context, index) {
          final noticia = todasNoticias[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(noticia["imagem"]),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    noticia["titulo"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${noticia["fonte"]} • ${noticia["tempo"]}",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Filtro de Categorias
  Widget _buildFiltroCategorias() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: categorias.map((categoria) {
          final isSelected = categoriaSelecionada == categoria;
          return GestureDetector(
            onTap: () {
              setState(() {
                categoriaSelecionada = categoria;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black12),
              ),
              child: Text(
                categoria,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Lista de Notícias Filtradas
  Widget _buildListaNoticias() {
    final noticiasFiltradas = todasNoticias.where((noticia) {
      return noticia["categoria"] == categoriaSelecionada;
    }).toList();

    return ListView.builder(
      itemCount: noticiasFiltradas.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final noticia = noticiasFiltradas[index];
        return ListTile(
          leading: Image.network(noticia["imagem"], width: 80, height: 80),
          title: Text(noticia["titulo"]),
          subtitle: Text("${noticia["fonte"]} • ${noticia["tempo"]}"),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
