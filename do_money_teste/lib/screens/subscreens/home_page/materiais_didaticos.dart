import 'package:flutter/material.dart';

class Modulo1Page extends StatefulWidget {
  const Modulo1Page({super.key});

  @override
  _Modulo1PageState createState() => _Modulo1PageState();
}

class _Modulo1PageState extends State<Modulo1Page> {
  final int _materialsViewed = 4;
  final int _totalMaterials = 7;

  final List<Widget> _tabs = [
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
        onPressed: () {},
        isViewed: true,
      ),
    ]),
    MaterialsTab(type: 'Apostilas', materials: [
      MaterialItem(
        title: 'Planejamento financeiro básico',
        icon: Icons.book,
        tooltip: 'Abrir',
        onPressed: () {},
        isViewed: false,
      ),
      MaterialItem(
        title: 'História do dinheiro',
        icon: Icons.book,
        tooltip: 'Abrir',
        onPressed: () {},
        isViewed: true,
      ),
    ]),
  ];

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
