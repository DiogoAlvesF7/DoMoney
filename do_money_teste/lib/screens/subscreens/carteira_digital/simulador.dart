import 'package:flutter/material.dart';

class SimuladorFinanceiroPage extends StatefulWidget {
  const SimuladorFinanceiroPage({super.key});

  @override
  _SimuladorFinanceiroPageState createState() =>
      _SimuladorFinanceiroPageState();
}

class _SimuladorFinanceiroPageState extends State<SimuladorFinanceiroPage> {
  String? _tipoInvestimentoSelecionado;
  String? _itemSelecionado;
  String _periodoInvestimento = '1 mês';
  double _valorInvestido = 0.0;
  double? _resultadoSimulacao;

  // Tipos de investimento disponíveis
  final Map<String, List<Map<String, String>>> tiposDeInvestimento = {
    "Ações": [
      {"nome": "PETR4", "empresa": "Petrobras"},
      {"nome": "VALE3", "empresa": "Vale S.A."},
      {"nome": "ITUB4", "empresa": "Itaú Unibanco"},
    ],
    "Criptomoedas": [
      {"nome": "BTC", "empresa": "Bitcoin"},
      {"nome": "ETH", "empresa": "Ethereum"},
      {"nome": "SOL", "empresa": "Solana"},
    ],
    "Fundos": [
      {"nome": "Fundo XP", "empresa": "XP Investimentos"},
      {"nome": "Fundo Inter", "empresa": "Banco Inter"},
    ],
    "CDBs": [
      {"nome": "CDB XP", "empresa": "Banco XP"},
      {"nome": "CDB Inter", "empresa": "Banco Inter"},
    ],
  };

  final List<String> periodosInvestimento = [
    '1 mês',
    '6 meses',
    '1 ano',
    '5 anos'
  ];

  void _simularInvestimento() {
    setState(() {
      if (_itemSelecionado != null) {
        double rendimento = 0.1; // Valor fictício para simulação
        int multiplicador = _periodoInvestimento == '1 mês'
            ? 1
            : _periodoInvestimento == '6 meses'
                ? 6
                : _periodoInvestimento == '1 ano'
                    ? 12
                    : 60;

        _resultadoSimulacao =
            _valorInvestido * (1 + (rendimento * multiplicador / 12));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lista de itens disponíveis de acordo com o tipo de investimento selecionado
    final List<Map<String, String>>? itensDisponiveis =
        tiposDeInvestimento[_tipoInvestimentoSelecionado];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título Centralizado
              const Text(
                "Simule seus Investimentos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Tipo de Investimento
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Selecione o Tipo de Investimento:",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      dropdownColor: Colors.grey[850],
                      value: _tipoInvestimentoSelecionado,
                      isExpanded: true,
                      hint: const Text(
                        "Escolha o tipo",
                        style: TextStyle(color: Colors.white54),
                      ),
                      style: const TextStyle(color: Colors.white),
                      underline: Container(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _tipoInvestimentoSelecionado = newValue!;
                          _itemSelecionado = null; // Reseta o item selecionado
                        });
                      },
                      items: tiposDeInvestimento.keys.map((String tipo) {
                        return DropdownMenuItem<String>(
                          value: tipo,
                          child: Text(tipo),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // Item de Investimento
                    if (itensDisponiveis != null) ...[
                      const Text(
                        "Selecione um Item:",
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      DropdownButton<String>(
                        dropdownColor: Colors.grey[850],
                        value: _itemSelecionado,
                        isExpanded: true,
                        hint: const Text(
                          "Escolha o item",
                          style: TextStyle(color: Colors.white54),
                        ),
                        style: const TextStyle(color: Colors.white),
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _itemSelecionado = newValue!;
                          });
                        },
                        items: itensDisponiveis.map((item) {
                          return DropdownMenuItem<String>(
                            value: item["nome"],
                            child: Text("${item["nome"]} - ${item["empresa"]}"),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),

              // Valor do Investimento
              const SizedBox(height: 16),
              const Text(
                "Valor do Investimento:",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[850],
                  hintText: "Digite o valor",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  _valorInvestido = double.tryParse(value) ?? 0.0;
                },
              ),
              const SizedBox(height: 16),

              // Período do Investimento
              const Text(
                "Período do Investimento:",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                dropdownColor: Colors.grey[850],
                value: _periodoInvestimento,
                isExpanded: true,
                style: const TextStyle(color: Colors.white),
                underline: Container(),
                onChanged: (String? newValue) {
                  setState(() {
                    _periodoInvestimento = newValue!;
                  });
                },
                items: periodosInvestimento.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Botão Simular
              Center(
                child: ElevatedButton(
                  onPressed: _simularInvestimento,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Simular",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Resultado da Simulação
              if (_resultadoSimulacao != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Resultado da Simulação",
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "R\$ ${_resultadoSimulacao!.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent,
                        ),
                      ),
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
