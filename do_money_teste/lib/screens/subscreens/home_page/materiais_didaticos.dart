import 'package:flutter/material.dart';

class MateriaisDidaticosPage extends StatelessWidget {
  final String moduloTitulo;

  MateriaisDidaticosPage({required this.moduloTitulo});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("$moduloTitulo",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                icon: Icon(Icons.picture_as_pdf),
                text: "PDFs",
              ),
              Tab(icon: Icon(Icons.video_library), text: "Vídeos"),
              Tab(icon: Icon(Icons.book), text: "Apostila"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // PDFs
            PDFsTab(),
            // Vídeos
            VideosTab(),
            // Apostila
            ApostilaTab(),
          ],
        ),
      ),
    );
  }
}

class PDFsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pdfs = [
      {
        "title": "Planilha de Orçamento",
        "description": "Gerencie receitas e despesas."
      },
      {
        "title": "Resumo do Módulo",
        "description": "Referências rápidas para estudo."
      },
    ];

    return ListView.builder(
      itemCount: pdfs.length,
      itemBuilder: (context, index) {
        final pdf = pdfs[index];
        return ListTile(
          leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
          title: Text(pdf["title"]!),
          subtitle: Text(pdf["description"]!),
          trailing: IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Função para download ou visualização
            },
          ),
        );
      },
    );
  }
}

class VideosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final videos = [
      {"title": "Como criar um orçamento mensal", "duration": "4:35 min"},
      {"title": "Dicas para economizar dinheiro", "duration": "3:20 min"},
    ];

    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return ListTile(
          leading: const Icon(Icons.play_circle_fill, color: Colors.blue),
          title: Text(video["title"]!),
          subtitle: Text(video["duration"]!),
          onTap: () {
            // Abrir vídeo
          },
        );
      },
    );
  }
}

class ApostilaTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Abrir apostila como PDF viewer
        },
        child: const Text("Abrir Apostila"),
      ),
    );
  }
}
