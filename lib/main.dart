import 'package:flutter/material.dart';

void main() {
  runApp(const test());
}

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // Ajout d'un fond en dégradé
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4F5BD5), Color(0xFF962FBF), Color(0xFFD62976)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const SafeArea(
            child: Padding(padding: EdgeInsets.all(20.0), child: testpage()),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class testpage extends StatefulWidget {
  const testpage({super.key});

  @override
  State<testpage> createState() => _testpageState();
}

class _testpageState extends State<testpage> {
  List<Widget> answerresult = [];
  List<String> questions = [
    'عدد الكواكب في المجموعة الشمسية هو ثمانية كواكب',
    'القطط حيوانات لاحمة',
    'الصين موجودة في قارة افريقيا',
    'الأرض مسطحة و ليست كروية',
    'باستطاعة الانسان العيش بدون أكل اللحوم',
    'الشمس تدور حول الأرض و الأرض تدور حول القمر',
    'الحيوانات لا تشعر بالألم',
  ];
  List<bool> answers = [true, true, false, false, true, false, false];
  int questionindex = 0;
  int x = 1;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Score et résultats
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'النتيجة: $score/${questions.length}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children:
                  answerresult
                      .map(
                        (icon) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: IconTheme(
                            data: const IconThemeData(size: 28),
                            child: icon,
                          ),
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
        const SizedBox(height: 30),
        // Question avec image dans une Card
        Expanded(
          flex: 3,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: Colors.white.withOpacity(0.9),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'images/image-$x.jpg',
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    questions[questionindex],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3A3A3A),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        // Boutons stylisés
        Expanded(
          child: Column(
            children: [
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 28,
                ),
                label: const Text(
                  'صح',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43A047),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  setState(() {
                    bool correctanswer = answers[questionindex];
                    if (correctanswer == true) {
                      score++;
                      answerresult.add(
                        const Icon(Icons.check_circle, color: Colors.green),
                      );
                    } else {
                      answerresult.add(
                        const Icon(Icons.cancel, color: Colors.red),
                      );
                    }
                    if (questionindex == questions.length - 1) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('نهاية الاختبار'),
                            content: Text(
                              'لقد أجبت على $score من ${questions.length} بشكل صحيح',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    questionindex = 0;
                                    x = 1;
                                    score = 0;
                                    answerresult = [];
                                  });
                                },
                                child: const Text('اعادة الاختبار'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      questionindex++;
                      x++;
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.cancel, color: Colors.white, size: 28),
                label: const Text(
                  'خطأ',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  setState(() {
                    bool correctanswer = answers[questionindex];
                    if (correctanswer == false) {
                      score++;
                      answerresult.add(
                        const Icon(Icons.check_circle, color: Colors.green),
                      );
                    } else {
                      answerresult.add(
                        const Icon(Icons.cancel, color: Colors.red),
                      );
                    }
                    if (questionindex == questions.length - 1) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('نهاية الاختبار'),
                            content: Text(
                              'لقد أجبت على $score من ${questions.length} بشكل صحيح',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    questionindex = 0;
                                    x = 1;
                                    score = 0;
                                    answerresult = [];
                                  });
                                },
                                child: const Text('اعادة الاختبار'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      questionindex++;
                      x++;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
