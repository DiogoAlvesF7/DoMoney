import 'package:flutter/material.dart';

class Modulo1Page extends StatefulWidget {
  const Modulo1Page({super.key});

  @override
  _Modulo1PageState createState() => _Modulo1PageState();
}

class _Modulo1PageState extends State<Modulo1Page> {
  final int _materialsViewed = 4;
  final int _totalMaterials = 7;

  void _navigateToApostilaPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApostilaPage()),
    );
  }

  late List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      MaterialsTab(type: 'PDFs', materials: [
        MaterialItem(
          title: 'O que é educação financeira',
          icon: Icons.picture_as_pdf,
          tooltip: 'Clique para baixar',
          onPressed: () {},
          isViewed: true,
        ),
        MaterialItem(
          title: 'Método 50/30/20',
          icon: Icons.picture_as_pdf,
          tooltip: 'Clique para baixar',
          onPressed: () {},
          isViewed: true,
        ),
      ]),
      MaterialsTab(type: 'Vídeos', materials: [
        MaterialItem(
          title: 'Introdução à educação financeira',
          icon: Icons.play_circle_sharp,
          tooltip: null,
          onPressed: () {},
          isViewed: false,
        ),
        MaterialItem(
          title: 'Juros compostos no \ndia a dia',
          icon: Icons.play_circle_sharp,
          tooltip: null,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => VideosPage()));
          },
          isViewed: true,
        ),
      ]),
      MaterialsTab(type: 'Apostilas', materials: [
        MaterialItem(
          title: 'Planejamento financeiro básico',
          icon: Icons.book,
          tooltip: 'Abrir',
          onPressed: _navigateToApostilaPage,
          isViewed: true,
        ),
        MaterialItem(
          title: 'História do dinheiro',
          icon: Icons.book,
          tooltip: 'Abrir',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ApostilaPage()));
          },
          isViewed: true,
        ),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100,
          backgroundColor: Colors.black,
          elevation: 0,
          leading: Tooltip(
            message: 'Voltar',
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.orange),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: const Text(
            '   Fundamentos da \nEducação Financeira',
            style: TextStyle(
                color: Colors.orange,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'PDFs'),
              Tab(text: 'Vídeos'),
              Tab(text: 'Apostilas'),
            ],
            indicatorColor: Colors.orange,
            indicatorWeight: 3,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(children: _tabs),
        bottomNavigationBar: BottomAppBar(
          height: 120,
          color: Colors.grey[900],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 170,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(10),
                      minHeight: 10,
                      value: _materialsViewed / _totalMaterials,
                      backgroundColor: Colors.grey[800],
                      valueColor: const AlwaysStoppedAnimation(Colors.orange),
                    ),
                  ),
                  const Spacer(),
                  Text('$_materialsViewed/$_totalMaterials',
                      style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  const Text("Vistos",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/quiz');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, elevation: 1),
                child: const Row(
                  children: [
                    SizedBox(width: 65),
                    Text('Ir para Quizzes',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 25),
                    Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  double _volume = 0.5;
  bool _showVolumeSlider = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DoMoney - Aulas',
          style: TextStyle(
              color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.orange),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Área do vídeo
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: Image.network(
                          'https://i.ytimg.com/vi/ha5hNH6eHBI/sddefault.jpg',
                        ).image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Configurações, velocidade, qualidade
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.speed, color: Colors.white),
                          onPressed: () {
                            // Alterar velocidade (simulado)
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.high_quality,
                              color: Colors.white),
                          onPressed: () {
                            // Alterar qualidade (simulado)
                          },
                        ),
                      ],
                    ),
                  ),
                  // Controle de volume
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            _volume == 0 ? Icons.volume_off : Icons.volume_up,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _showVolumeSlider = !_showVolumeSlider;
                            });
                          },
                        ),
                        if (_showVolumeSlider)
                          Container(
                            width: 40,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Slider(
                                value: _volume,
                                min: 0,
                                max: 1,
                                onChanged: (value) {
                                  setState(() {
                                    _volume = value;
                                  });
                                },
                                activeColor: Colors.orange,
                                inactiveColor: Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Botão de pause/play
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.pause, color: Colors.white),
                      onPressed: () {
                        // Play/pause (simulado)
                      },
                    ),
                  ),
                  // Botão de preencher tela
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.fullscreen, color: Colors.white),
                      onPressed: () {
                        // Preencher tela (simulado)
                      },
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.play_circle_fill,
                              color: Colors.white, size: 50),
                          onPressed: () {
                            // Play/pause (simulado)
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Marcador de vídeo assistido
              Row(
                children: [
                  Switch(
                    value: true,
                    onChanged: (value) {
                      // Marcar vídeo como assistido (simulado)
                    },
                    activeColor: Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Vídeo assistido',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Título do vídeo
              const Text(
                'Juros Compostos no Dia a Dia',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              // Descrição
              Text(
                'Descubra como os juros compostos afetam sua rotina financeira e como utilizá-los a seu favor. Aprenda estratégias práticas para potencializar seus investimentos.',
                style: TextStyle(fontSize: 14, color: Colors.grey[300]),
              ),
              const SizedBox(height: 16),
              // Tira-dúvidas
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tira-dúvidas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        // Minhas dúvidas / Todas
                        DropdownButton<String>(
                          value: 'Minhas dúvidas',
                          items: const [
                            DropdownMenuItem(
                              value: 'Minhas dúvidas',
                              child: Text(
                                'Minhas dúvidas',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Todas',
                              child: Text(
                                'Todas',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ],
                          dropdownColor: Colors.grey[800],
                          onChanged: (value) {
                            // Trocar entre Minhas dúvidas e Todas (simulado)
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        // Foto de perfil
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                              'assets/images/Captura de tela 2024-12-18 093558.png'),
                          backgroundColor: Colors.black,
                        ),
                        const SizedBox(width: 8),
                        // Barra de perguntas
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Qual é a sua dúvida?',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.amber),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Enviar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.send, color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Seção de vídeos relacionados
              const Text(
                'Vídeos Relacionados',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              ..._buildRelatedVideos(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[850],
    );
  }

  // Função para criar os cards de vídeos relacionados
  List<Widget> _buildRelatedVideos() {
    final videos = [
      {
        'title': 'Método 50/30/20 na prática',
        'description':
            'Aprenda a organizar seu orçamento pessoal e definir prioridades.',
      },
      {
        'title': 'Receitas, Despesas e Investimentos',
        'description':
            'Entenda como equilibrar suas finanças para alcançar seus objetivos.',
      },
      {
        'title': 'Planejamento Financeiro em 3 Etapas',
        'description': 'Dicas para curto, médio e longo prazo.',
      },
      {
        'title': 'A História do Dinheiro',
        'description':
            'Uma viagem desde o escambo até o mercado financeiro moderno.',
      },
      {
        'title': 'O impacto dos Juros no Mercado',
        'description':
            'Como os juros simples e compostos afetam suas decisões financeiras.',
      },
    ];

    return videos
        .map((video) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Card(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Container(
                    width: 80,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_arrow,
                        size: 32,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  title: Text(
                    video['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    video['description']!,
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  ),
                  onTap: () {
                    // Ação ao clicar no vídeo (simulado)
                  },
                ),
              ),
            ))
        .toList();
  }
}

class ApostilaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Tooltip(
          message: 'Voltar',
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.orange),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(' História do Dinheiro',
            style: TextStyle(
                color: Colors.orange,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Introdução',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'A história do dinheiro é a história de como a humanidade desenvolveu formas de facilitar trocas e comércio. Desde os primórdios da civilização até os dias de hoje, o dinheiro passou por transformações que moldaram sociedades e economias em todo o mundo.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 32),
            const Text(
              'O Sistema de Trocas Diretas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Antes da invenção do dinheiro, as pessoas usavam o sistema de trocas diretas, conhecido como escambo. Nesse sistema, bens e serviços eram trocados diretamente. Por exemplo, um agricultor podia trocar trigo por carne com um criador de gado. No entanto, o escambo tinha limitações, como a necessidade de "coincidência de desejos" — ambos os participantes precisavam querer o que o outro oferecia.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Image.network(
              'https://d2kcw0xpn7sann.cloudfront.net/papel-moeda1.webp',
              width: 300,
              height: 200,
            ),
            const SizedBox(height: 32),
            const Text(
              'O Surgimento das Moedas de Troca',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Para superar as dificuldades do escambo, algumas sociedades começaram a usar mercadorias como forma de troca. Essas mercadorias, chamadas de "moedas de troca", incluíam sal, grãos, conchas, e até mesmo gado. Essas formas de dinheiro tinham valor intrínseco, mas ainda eram pouco práticas em algumas situações.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 32),
            const Text(
              'A Invenção das Moedas Metálicas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'As primeiras moedas metálicas surgiram por volta de 600 a.C., na região da Lídia, na atual Turquia. Elas eram feitas de metais preciosos, como ouro e prata, e tinham valor definido pelo peso e pela pureza. As moedas eram mais fáceis de transportar e facilitavam transações comerciais em larga escala.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Image.network(
              'https://www.newgreenfil.com/img/uploads/400x201_67073a56b7b67240aa559833bd41d2ce.jpg',
              width: 300,
              height: 200,
            ),
            const SizedBox(height: 32),
            const Text(
              'O Surgimento das Cédulas de Dinheiro',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'As cédulas de dinheiro foram introduzidas na China durante a dinastia Tang, no século VII. Elas se popularizaram durante a dinastia Song (960–1279) e eram emitidas pelo governo como uma forma prática de substituir moedas pesadas. As cédulas rapidamente se tornaram comuns em várias partes do mundo.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 32),
            const Text(
              'O Dinheiro Moderno e a Era Digital',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Hoje, o dinheiro existe em várias formas: físico (moedas e cédulas), digital (transferências bancárias, cartões de crédito) e criptográfico (como Bitcoin). O avanço da tecnologia transformou a maneira como lidamos com dinheiro, tornando as transações mais rápidas e acessíveis globalmente.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            const Divider(),
            const Text(
              'Conclusão',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Entender a história do dinheiro nos ajuda a compreender o papel fundamental que ele desempenha na sociedade. Desde as trocas simples até as transações digitais de hoje, o dinheiro continua a evoluir, refletindo as necessidades e inovações humanas.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Você concluiu a leitura!'),
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text('Finalizar Leitura',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaterialsTab extends StatelessWidget {
  final String type;
  final List<MaterialItem> materials;

  const MaterialsTab({super.key, required this.type, required this.materials});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: materials.length,
      itemBuilder: (context, index) {
        return materials[index];
      },
    );
  }
}

class MaterialItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? imageUrl;
  final String? tooltip;
  final VoidCallback onPressed;

  final bool isViewed;

  const MaterialItem({
    super.key,
    required this.title,
    this.icon,
    this.imageUrl,
    this.tooltip,
    this.isViewed = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                border:
                    isViewed ? Border.all(color: Colors.green, width: 2) : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  if (imageUrl != null)
                    Image.network(imageUrl!, width: 40, height: 40)
                  else if (icon != null)
                    Icon(icon, color: Colors.grey[700], size: 40)
                  else
                    const SizedBox.shrink(),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (icon == Icons.picture_as_pdf)
                    const Tooltip(
                      message: 'Clique para baixar',
                      child: Icon(Icons.download, color: Colors.grey, size: 25),
                    )
                  else if (icon == Icons.play_circle_sharp)
                    const SizedBox.shrink()
                  else if (icon == Icons.book)
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Tooltip(
                        message: 'Abrir',
                        child: Icon(Icons.open_in_new,
                            color: Colors.grey, size: 25),
                      ),
                    ),
                ],
              ),
            ),
            if (isViewed)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
