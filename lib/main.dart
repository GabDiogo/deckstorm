// DeckStorm - Exemplo completo em Flutter
// Idioma: PT-BR
// Arquivo: main.dart
// Observações: código auto-contido, sem pacotes externos. Coloque imagens de cartas em assets/ se quiser.

import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(DeckStormApp());
}

class DeckStormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeckStorm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: MainTabs(),
      locale: Locale('pt', 'BR'),
    );
  }
}

// --- MODELS ---
class CardModel {
  final String id;
  final String nome;
  final String descricao;
  final String imagem; // caminho em assets (opcional)
  final Map<String, int> atributos; // ex: {'Força': 80, 'Velocidade': 60}

  CardModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.imagem,
    required this.atributos,
  });
}

// --- Dados iniciais (deck padrão) ---
List<CardModel> defaultDeck = [
  CardModel(
    id: 'c1',
    nome: 'Fênix',
    descricao: 'Uma ave mítica renascida das chamas.',
    imagem: '',
    atributos: {'Força': 85, 'Velocidade': 70, 'Inteligência': 60},
  ),
  CardModel(
    id: 'c2',
    nome: 'Titã',
    descricao: 'Gigante de força bruta.',
    imagem: '',
    atributos: {'Força': 95, 'Velocidade': 40, 'Inteligência': 45},
  ),
  CardModel(
    id: 'c3',
    nome: 'Assassino',
    descricao: 'Rápido e letal nas sombras.',
    imagem: '',
    atributos: {'Força': 60, 'Velocidade': 95, 'Inteligência': 70},
  ),
  CardModel(
    id: 'c4',
    nome: 'Arcanista',
    descricao: 'Mestre das artes arcanas.',
    imagem: '',
    atributos: {'Força': 40, 'Velocidade': 50, 'Inteligência': 98},
  ),
  CardModel(
    id: 'c5',
    nome: 'Colosso',
    descricao: 'Defesa impenetrável.',
    imagem: '',
    atributos: {'Força': 88, 'Velocidade': 30, 'Inteligência': 50},
  ),
  CardModel(
    id: 'c6',
    nome: 'Raptor',
    descricao: 'Predador ágil.',
    imagem: '',
    atributos: {'Força': 70, 'Velocidade': 85, 'Inteligência': 55},
  ),
];

// --- MAIN TABS ---
class MainTabs extends StatefulWidget {
  @override
  _MainTabsState createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  int _selectedIndex = 0;

  // Estado compartilhado simples: cartas selecionadas para a partida
  List<CardModel> selectedCards = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = <Widget>[
      OpeningTab(onStart: () => setState(() => _selectedIndex = 1)),
      HomeTab(),
      CardsTab(
        availableCards: defaultDeck,
        selectedCards: selectedCards,
        onSelectionChanged: (newSel) => setState(() => selectedCards = newSel),
      ),
      BattleTab(playerDeck: selectedCards),
      AboutTab(),
    ];

    return Scaffold(
      body: SafeArea(child: tabs[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: 'Abertura'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.style), label: 'Cartas'),
          BottomNavigationBarItem(icon: Icon(Icons.sports_mma), label: 'Batalha'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Sobre'),
        ],
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// --- 1) Abertura ---
class OpeningTab extends StatelessWidget {
  final VoidCallback onStart;
  const OpeningTab({required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('DeckStorm', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Jogo de cartas estilo Super Trunfo', style: TextStyle(fontSize: 18)),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: onStart,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Text('Iniciar', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 2) Home (hub) ---
class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text('Bem-vindo ao DeckStorm', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text('Escolha uma das opções abaixo para começar:'),
          SizedBox(height: 20),
          HubButton(label: 'Minhas cartas', icon: Icons.style, onTap: () {
            // navegar para a aba de Cartas (índice 2)
            DefaultTabController.of(context);
            // jeito simples: acessar ancestor state
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => CardsTab(
              availableCards: defaultDeck,
              selectedCards: [],
              onSelectionChanged: (_) {},
            )));
          }),
          HubButton(label: 'Batalha', icon: Icons.sports_mma, onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => BattleTab(playerDeck: [])));
          }),
          HubButton(label: 'Tutorial', icon: Icons.help_outline, onTap: () {
            showDialog(context: context, builder: (_) => AlertDialog(
              title: Text('Tutorial'),
              content: Text('Selecione até 5 cartas na aba "Cartas". Na batalha, escolha uma carta e um atributo para competir contra o bot. O bot usa um deck padrão.'),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Fechar'))],
            ));
          }),
        ],
      ),
    );
  }
}

class HubButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  HubButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 36, color: Colors.deepPurple),
        title: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

// --- 3) Cartas ---
class CardsTab extends StatefulWidget {
  final List<CardModel> availableCards;
  final List<CardModel> selectedCards;
  final ValueChanged<List<CardModel>> onSelectionChanged;

  CardsTab({required this.availableCards, required this.selectedCards, required this.onSelectionChanged});

  @override
  _CardsTabState createState() => _CardsTabState();
}

class _CardsTabState extends State<CardsTab> {
  late List<CardModel> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selectedCards);
  }

  void toggleSelect(CardModel card) {
    setState(() {
      if (_selected.contains(card)) {
        _selected.remove(card);
      } else {
        if (_selected.length < 5) {
          _selected.add(card);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Máximo de 5 cartas selecionadas')));
        }
      }
      widget.onSelectionChanged(_selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cartas'), automaticallyImplyLeading: false),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Text('Selecionadas: ${_selected.length}/5'),
                Spacer(),
                TextButton(onPressed: () {
                  setState(() { _selected.clear(); widget.onSelectionChanged(_selected); });
                }, child: Text('Limpar'))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.availableCards.length,
              itemBuilder: (context, index) {
                final c = widget.availableCards[index];
                final isSel = _selected.contains(c);
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    onTap: () => toggleSelect(c),
                    leading: CircleAvatar(child: Text(c.nome[0])),
                    title: Text(c.nome),
                    subtitle: Text(c.descricao),
                    trailing: isSel ? Icon(Icons.check_circle, color: Colors.green) : Icon(Icons.add_circle_outline),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- 4) Batalha ---
class BattleTab extends StatefulWidget {
  final List<CardModel> playerDeck; // as cartas que o jogador selecionou (até 5)
  BattleTab({required this.playerDeck});

  @override
  _BattleTabState createState() => _BattleTabState();
}

class _BattleTabState extends State<BattleTab> {
  late List<CardModel> playerCards;
  late List<CardModel> botCards;
  int playerScore = 0;
  int botScore = 0;
  String message = 'Selecione uma carta para começar a rodada.';

  @override
  void initState() {
    super.initState();
    // Se o jogador não escolheu cartas, usar um deck padrão (primeiras 5)
    playerCards = widget.playerDeck.isEmpty ? defaultDeck.take(5).toList() : List.from(widget.playerDeck);
    // Bot tem o mesmo deck padrão (mesmo cards e stats) — por especificação
    botCards = List.from(defaultDeck);
  }

  void playRound(CardModel chosen, String atributo) {
    if (botCards.isEmpty) {
      setState(() { message = 'O bot não tem mais cartas.'; });
      return;
    }

    // bot escolhe aleatoriamente uma carta do seu deck
    final rand = Random();
    final botChoice = botCards[rand.nextInt(botCards.length)];

    final playerValue = chosen.atributos[atributo] ?? 0;
    final botValue = botChoice.atributos[atributo] ?? 0;

    String resultado;
    if (playerValue > botValue) {
      playerScore++;
      resultado = 'Você venceu a rodada! ($playerValue x $botValue)';
    } else if (playerValue < botValue) {
      botScore++;
      resultado = 'Você perdeu a rodada. ($playerValue x $botValue)';
    } else {
      resultado = 'Empate! ($playerValue x $botValue)';
    }

    setState(() {
      message = 'Sua carta: ${chosen.nome} (\$atributo: $playerValue)\nBot: ${botChoice.nome} (\$atributo: $botValue)\n$resultado';
      // remover cartas usadas para evitar repetição
      playerCards.remove(chosen);
      botCards.remove(botChoice);
    });
  }

  void resetMatch() {
    setState(() {
      playerCards = widget.playerDeck.isEmpty ? defaultDeck.take(5).toList() : List.from(widget.playerDeck);
      botCards = List.from(defaultDeck);
      playerScore = 0;
      botScore = 0;
      message = 'Partida reiniciada. Selecione uma carta.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Batalha'), automaticallyImplyLeading: false, actions: [
        IconButton(onPressed: resetMatch, icon: Icon(Icons.refresh)),
      ]),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Placar: ', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Text('Você $playerScore  -  $botScore Bot'),
              ],
            ),
            SizedBox(height: 12),
            Text(message),
            SizedBox(height: 12),
            Text('Suas cartas:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Expanded(
              child: playerCards.isEmpty
                  ? Center(child: Text('Você não tem mais cartas. Reinicie a partida.'))
                  : ListView.builder(
                      itemCount: playerCards.length,
                      itemBuilder: (context, i) {
                        final c = playerCards[i];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(c.nome),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(c.descricao),
                                SizedBox(height: 6),
                                Wrap(
                                  spacing: 8,
                                  children: c.atributos.keys.map((attr) {
                                    return ElevatedButton(
                                      onPressed: () => playRound(c, attr),
                                      child: Text(attr),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(height: 8),
            Center(child: Text('Bot usa um deck padrão idêntico a cada round')),
          ],
        ),
      ),
    );
  }
}

// --- 5) Sobre / Info ---
class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text('Sobre o DeckStorm', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text('DeckStorm é um protótipo de jogo de cartas baseado no clássico Super Trunfo.\n\nNeste protótipo:')
        ..split('\n').forEach((_){}),
          SizedBox(height: 8),
          Text('- Selecione até 5 cartas na aba "Cartas".'),
          Text('- Inicie batalhas contra um bot que usa um deck padrão.'),
          SizedBox(height: 16),
          Text('Dicas:'),
          Text('- Você pode ajustar os atributos e imagens das cartas editando o array `defaultDeck` no código.'),
          SizedBox(height: 24),
          Text('Versão de demonstração - código aberto para customização.'),
        ],
      ),
    );
  }
}
