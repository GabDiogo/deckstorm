// DeckStorm - O protótipo de jogo de cartas estilo Super Trunfo
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
// --- Cartas --- 
class CardModel {
  final String id;
  final String nome;
  final String descricao;
  final String imagem; 
  final Map<String, int> atributos;

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
    nome: 'Killua',
    descricao: 'Um assassino prodígio do clã Zoldyck',
    imagem: '',
    atributos: {'Poder de ataque': 85, 'Estratégia': 70, 'Resistência': 80, 'Técnica': 95},
  ),
  CardModel(
    id: 'c2',
    nome: 'Levi',
    descricao: 'Um dos soldados mais habilidosos da humanidade',
    imagem: '',
    atributos: {'Poder de ataque': 88, 'Estratégia': 90, 'Resistência': 70, 'Técnica': 98},
  ),
  CardModel(
    id: 'c3',
    nome: 'Gojo',
    descricao: 'O feiticeiro mais poderoso do mundo moderno.',
    imagem: '',
    atributos: {'Poder de ataque': 97, 'Estratégia': 85, 'Resistência': 95, 'Técnica': 99},
  ),
  CardModel(
    id: 'c4',
    nome: 'Zoro',
    descricao: 'Espadachim dos Chapéus de Palha.',
    imagem: '',
    atributos: {'Poder de ataque': 95, 'Estratégia': 60, 'Resistência': 90, 'Técnica': 92},
  ),
  CardModel(
    id: 'c5',
    nome: 'Shikamaru',
    descricao: 'Um gênio tático preguiçoso.',
    imagem: '',
    atributos: {'Poder de ataque': 55, 'Estratégia': 100, 'Resistência': 65, 'Técnica': 85},
  ),
  CardModel(
    id: 'c6',
    nome: 'Tanjiro',
    descricao: 'Um caçador de demônios de coração puro.',
    imagem: '',
    atributos: {'Poder de ataque': 85, 'Estratégia': 75, 'Resistência': 85, 'Técnica': 85},
  ),
   CardModel(
    id: 'c7',
    nome: 'Itachi',
    descricao: 'Um gênio do clã Uchiha.',
    imagem: '',
    atributos: {'Poder de ataque': 92, 'Estratégia': 98, 'Resistência': 82, 'Técnica': 97},
  ),
   CardModel(
    id: 'c8',
    nome: 'Gohan',
    descricao: 'O guerreiro híbrido que atinge um poder além dos deuses quando luta por aqueles que ama.',
    imagem: '',
    atributos: {'Poder de ataque': 99, 'Estratégia': 78, 'Resistência': 95, 'Técnica': 90},
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
            DefaultTabController.of(context);
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
  final List<CardModel> playerDeck; 
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
    playerCards = widget.playerDeck.isEmpty ? defaultDeck.take(5).toList() : List.from(widget.playerDeck);
    botCards = List.from(defaultDeck);
  }

  void playRound(CardModel chosen, String atributo) {
    if (botCards.isEmpty) {
      setState(() { message = 'O bot não tem mais cartas.'; });
      return;
    }

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
          Text(
                'DeckStorm é um protótipo de jogo de cartas baseado no clássico Super Trunfo.\n\n'
                 style: TextStyle(fontSize: 16),  
              ),
        ],
      ),
    );
  }
}
