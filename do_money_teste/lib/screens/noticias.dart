import 'dart:async';
import 'package:do_money_teste/screens/subscreens/noticias/filtro_noticias.dart';
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

  late PageController _pageController;
  int _currentPage = 0;

  String categoriaSelecionada = "Economia";

  final List<Map<String, dynamic>> todasNoticias = [
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

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % todasNoticias.length;
        });
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildCarrosselDestaques(),
            const SizedBox(height: 24),
            _buildFiltroCategorias(),
            const SizedBox(height: 16),
            _buildSectionTitle("Mais relevantes para você"),
            _buildListaNoticias(),
            const SizedBox(height: 16),
            _buildSectionTitle("Todas as notícias"),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCarrosselDestaques() {
    return SizedBox(
      height: 170,
      child: PageView.builder(
        controller: _pageController,
        itemCount: todasNoticias.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final noticia = todasNoticias[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(noticia["imagem"]),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    noticia["titulo"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 6),
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

  Widget _buildFiltroCategorias() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: categorias.map((categoria) {
          final isSelected = categoriaSelecionada == categoria;
          return GestureDetector(
            onTap: () {
              setState(() {
                categoriaSelecionada = categoria;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.grey[800],
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                categoria,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

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
        return GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    noticia["imagem"],
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        noticia["titulo"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${noticia["fonte"]} • ${noticia["tempo"]}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
          color: Colors.white,
        ),
      ),
    );
  }
}
