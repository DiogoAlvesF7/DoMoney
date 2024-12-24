import 'package:flutter/material.dart';

class CorretoraPage extends StatefulWidget {
  const CorretoraPage({super.key});

  @override
  _CorretoraPageState createState() => _CorretoraPageState();
}

class _CorretoraPageState extends State<CorretoraPage> {
  String? _tipoSelecionado;

  // Tipos de investimento disponíveis
  final Map<String, List<Map<String, dynamic>>> ativosDisponiveis = {
    "Ações": [
      {
        "nome": "PETR4",
        "empresa": "Petrobras",
        "precoAtual": 30.00,
        "variacao": -1.2
      },
      {
        "nome": "VALE3",
        "empresa": "Vale S.A.",
        "precoAtual": 65.00,
        "variacao": 2.8
      },
      {
        "nome": "ITUB4",
        "empresa": "Itaú Unibanco",
        "precoAtual": 25.50,
        "variacao": 1.1
      },
    ],
    "Criptomoedas": [
      {
        "nome": "BTC",
        "empresa": "Bitcoin",
        "precoAtual": 150000.00,
        "variacao": 3.5
      },
      {
        "nome": "ETH",
        "empresa": "Ethereum",
        "precoAtual": 12000.00,
        "variacao": -2.3
      },
      {
        "nome": "SOL",
        "empresa": "Solana",
        "precoAtual": 300.00,
        "variacao": 5.0
      },
    ],
    "Fundos": [
      {
        "nome": "Fundo XP",
        "empresa": "XP Investimentos",
        "precoAtual": 150.00,
        "variacao": 0.5
      },
      {
        "nome": "Fundo Inter",
        "empresa": "Banco Inter",
        "precoAtual": 95.00,
        "variacao": -0.8
      },
    ],
  };

  void _abrirModalCompraVenda(String tipo, Map<String, dynamic> ativo) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        int quantidade = 0;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${ativo['nome']} - ${ativo['empresa']}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Preço Atual:",
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        "R\$ ${ativo['precoAtual'].toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[850],
                      hintText: "Digite a quantidade",
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setModalState(() {
                        quantidade = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        "R\$ ${(quantidade * ativo['precoAtual']).toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: quantidade > 0
                        ? () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "$tipo realizado com sucesso para ${ativo['nome']}!",
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                    ),
                    child: Text(
                      tipo == "Compra" ? "Comprar" : "Vender",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ativos = ativosDisponiveis[_tipoSelecionado] ?? [];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown para selecionar o tipo de investimento
            DropdownButton<String>(
              dropdownColor: Colors.grey[850],
              value: _tipoSelecionado,
              isExpanded: true,
              hint: const Text(
                "Selecione o tipo de investimento",
                style: TextStyle(color: Colors.white54),
              ),
              style: const TextStyle(color: Colors.white),
              underline: Container(),
              onChanged: (String? newValue) {
                setState(() {
                  _tipoSelecionado = newValue!;
                });
              },
              items: ativosDisponiveis.keys.map((String tipo) {
                return DropdownMenuItem<String>(
                  value: tipo,
                  child: Text(
                    tipo,
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Lista de Ativos
            Expanded(
              child: ListView.builder(
                itemCount: ativos.length,
                itemBuilder: (context, index) {
                  final ativo = ativos[index];
                  final isPositivo = ativo['variacao'] >= 0;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Nome do ativo e empresa
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ativo["nome"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ativo["empresa"],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    isPositivo
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    size: 16,
                                    color: isPositivo
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${ativo['variacao']}%",
                                    style: TextStyle(
                                      color: isPositivo
                                          ? Colors.greenAccent
                                          : Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Preço Atual
                        Text(
                          "R\$ ${ativo['precoAtual'].toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Botões Comprar/Vender
                        IconButton(
                          icon: const Icon(Icons.shopping_cart),
                          color: Colors.orange,
                          onPressed: () =>
                              _abrirModalCompraVenda("Compra", ativo),
                        ),
                        IconButton(
                          icon: const Icon(Icons.sell),
                          color: Colors.redAccent,
                          onPressed: () =>
                              _abrirModalCompraVenda("Venda", ativo),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
