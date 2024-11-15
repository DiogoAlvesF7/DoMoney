import 'package:flutter/material.dart';

class CarteiraDigitalPage extends StatefulWidget {
  const CarteiraDigitalPage({super.key});

  @override
  _CarteiraDigitalPageState createState() => _CarteiraDigitalPageState();
}

class _CarteiraDigitalPageState extends State<CarteiraDigitalPage> {
  double _fundos = 2500.00; // Valor inicial dos fundos
  double _metaFinanceira = 5000.00; // Meta financeira inicial
  double _limiteGasto = 1000.00; // Limite de gasto mensal inicial
  String _categoriaAtual =
      'Entretenimento'; // Categoria de despesas selecionada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Carteira Digital',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              // Ações para configurações
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de adicionar/retirar fundos
            Text(
              'Adicionar/Retirar Fundos',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            _buildFundosSection(),
            const Divider(),

            // Seção de metas financeiras
            Text(
              'Metas Financeiras',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            _buildMetasFinanceirasSection(),
            const Divider(),

            // Seção de configurações da carteira
            Text(
              'Configurações da Carteira',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            _buildConfiguracoesCarteiraSection(),
            const Divider(),

            // Seção de simulador financeiro
            Text(
              'Simulador Financeiro',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            _buildSimuladorFinanceiroSection(),
          ],
        ),
      ),
    );
  }

  // Seção de adicionar/retirar fundos
  Widget _buildFundosSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fundos Disponíveis: R\$${_fundos.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showAddFundsDialog();
                    },
                    child: const Text('Adicionar Fundos'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showWithdrawFundsDialog();
                    },
                    child: const Text('Retirar Fundos'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Diálogo para adicionar fundos
  void _showAddFundsDialog() {
    double amountToAdd = 0;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Fundos'),
          content: TextField(
            decoration: const InputDecoration(hintText: 'Digite o valor'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              amountToAdd = double.tryParse(value) ?? 0;
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Adicionar'),
              onPressed: () {
                setState(() {
                  _fundos += amountToAdd;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Diálogo para retirar fundos
  void _showWithdrawFundsDialog() {
    double amountToWithdraw = 0;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Retirar Fundos'),
          content: TextField(
            decoration: const InputDecoration(hintText: 'Digite o valor'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              amountToWithdraw = double.tryParse(value) ?? 0;
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Retirar'),
              onPressed: () {
                setState(() {
                  if (amountToWithdraw <= _fundos) {
                    _fundos -= amountToWithdraw;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saldo insuficiente')),
                    );
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Seção de metas financeiras
  Widget _buildMetasFinanceirasSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meta Atual: R\$${_metaFinanceira.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showSetGoalDialog();
                    },
                    child: const Text('Definir Nova Meta'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Diálogo para definir nova meta financeira
  void _showSetGoalDialog() {
    double newGoal = 0;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Definir Nova Meta Financeira'),
          content: TextField(
            decoration:
                const InputDecoration(hintText: 'Digite o valor da meta'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              newGoal = double.tryParse(value) ?? 0;
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Definir'),
              onPressed: () {
                setState(() {
                  _metaFinanceira = newGoal;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Seção de configurações da carteira
  Widget _buildConfiguracoesCarteiraSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Limite de Gasto Mensal: R\$${_limiteGasto.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showSetLimitDialog();
                    },
                    child: const Text('Definir Limite'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Categoria Atual: $_categoriaAtual',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showSetCategoryDialog();
                    },
                    child: const Text('Modificar Categoria'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Diálogo para definir limite de gasto
  void _showSetLimitDialog() {
    double newLimit = 0;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Definir Limite de Gasto Mensal'),
          content: TextField(
            decoration:
                const InputDecoration(hintText: 'Digite o valor do limite'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              newLimit = double.tryParse(value) ?? 0;
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Definir'),
              onPressed: () {
                setState(() {
                  _limiteGasto = newLimit;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Diálogo para modificar a categoria de despesas
  void _showSetCategoryDialog() {
    String newCategory = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modificar Categoria de Despesas'),
          content: DropdownButton<String>(
            value: _categoriaAtual,
            isExpanded: true,
            onChanged: (String? value) {
              setState(() {
                newCategory = value ?? _categoriaAtual;
              });
            },
            items: <String>[
              'Entretenimento',
              'Alimentação',
              'Transporte',
              'Educação',
              'Saúde'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Modificar'),
              onPressed: () {
                setState(() {
                  _categoriaAtual = newCategory;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Seção de simulador financeiro
  Widget _buildSimuladorFinanceiroSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Simulador Financeiro',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Simule o impacto de diferentes decisões financeiras em seus fundos.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildSimuladorOptions(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showSimulationResult();
              },
              child: const Text('Simular'),
            ),
          ],
        ),
      ),
    );
  }

  // Opções do simulador financeiro
  Widget _buildSimuladorOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '1. Escolha o tipo de investimento:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        _buildInvestmentTypeDropdown(),
        const SizedBox(height: 20),
        const Text(
          '2. Digite o valor do investimento:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        _buildInvestmentAmountInput(),
        const SizedBox(height: 20),
        const Text(
          '3. Escolha o período de investimento:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        _buildInvestmentPeriodDropdown(),
      ],
    );
  }

  // Dropdown para tipo de investimento
  String _investmentType = 'Ações';
  Widget _buildInvestmentTypeDropdown() {
    return DropdownButton<String>(
      value: _investmentType,
      isExpanded: true,
      onChanged: (String? newValue) {
        setState(() {
          _investmentType = newValue!;
        });
      },
      items: <String>[
        'Ações',
        'Renda Fixa',
        'Fundos Imobiliários',
        'Criptomoedas',
        'Poupança'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  // Input para valor do investimento
  double _investmentAmount = 0;
  Widget _buildInvestmentAmountInput() {
    return TextField(
      decoration: const InputDecoration(hintText: 'Digite o valor'),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          _investmentAmount = double.tryParse(value) ?? 0;
        });
      },
    );
  }

  // Dropdown para período de investimento
  String _investmentPeriod = '1 ano';
  Widget _buildInvestmentPeriodDropdown() {
    return DropdownButton<String>(
      value: _investmentPeriod,
      isExpanded: true,
      onChanged: (String? newValue) {
        setState(() {
          _investmentPeriod = newValue!;
        });
      },
      items: <String>['1 ano', '2 anos', '5 anos', '10 anos']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  // Mostrar resultado da simulação
  void _showSimulationResult() {
    // Exemplo básico de cálculo de simulação, baseado em regras arbitrárias
    double result = _investmentAmount;
    if (_investmentType == 'Ações') {
      result += _investmentAmount * 0.15;
    } else if (_investmentType == 'Renda Fixa') {
      result += _investmentAmount * 0.05;
    } else if (_investmentType == 'Fundos Imobiliários') {
      result += _investmentAmount * 0.10;
    } else if (_investmentType == 'Criptomoedas') {
      result += _investmentAmount * 0.25;
    } else if (_investmentType == 'Poupança') {
      result += _investmentAmount * 0.03;
    }

    // Ajusta o resultado conforme o período de investimento
    if (_investmentPeriod == '2 anos') {
      result *= 1.2;
    } else if (_investmentPeriod == '5 anos') {
      result *= 1.5;
    } else if (_investmentPeriod == '10 anos') {
      result *= 2.0;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Resultado da Simulação'),
          content: Text(
              'Após $_investmentPeriod de investimento em $_investmentType, seu montante seria de R\$${result.toStringAsFixed(2)}.'),
          actions: [
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
