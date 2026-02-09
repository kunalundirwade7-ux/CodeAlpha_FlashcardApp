import 'package:flutter/material.dart';

void main() {
  runApp(FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard App',
      home: FlashcardHome(),
    );
  }
}

class Flashcard {
  String question;
  String answer;

  Flashcard(this.question, this.answer);
}

class FlashcardHome extends StatefulWidget {
  @override
  _FlashcardHomeState createState() => _FlashcardHomeState();
}

class _FlashcardHomeState extends State<FlashcardHome> {
  List<Flashcard> cards = [
    Flashcard("What is Flutter?", "Flutter is a UI toolkit by Google."),
    Flashcard("What is Dart?", "Dart is the language used in Flutter."),
    Flashcard("What is Widget?", "Everything in Flutter is a widget."),
  ];

  int index = 0;
  bool showAnswer = false;

  TextEditingController qController = TextEditingController();
  TextEditingController aController = TextEditingController();

  void nextCard() {
    setState(() {
      showAnswer = false;
      index = (index + 1) % cards.length;
    });
  }

  void prevCard() {
    setState(() {
      showAnswer = false;
      index = (index - 1 + cards.length) % cards.length;
    });
  }

  void addCard() {
    if (qController.text.isEmpty || aController.text.isEmpty) return;

    setState(() {
      cards.add(Flashcard(qController.text, aController.text));
      qController.clear();
      aController.clear();
    });

    Navigator.pop(context);
  }

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Flashcard"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: qController,
              decoration: InputDecoration(labelText: "Question"),
            ),
            TextField(
              controller: aController,
              decoration: InputDecoration(labelText: "Answer"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: addCard,
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flashcard Quiz"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      showAnswer
                          ? cards[index].answer
                          : cards[index].question,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  showAnswer = !showAnswer;
                });
              },
              child: Text(
                showAnswer ? "Show Question" : "Show Answer",
              ),
            ),

            SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: prevCard,
                  child: Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: nextCard,
                  child: Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
