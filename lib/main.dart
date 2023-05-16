import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5DEF0),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Fightersinfo(),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text("Defend".toUpperCase()),
                    const SizedBox(height: 13),
                    BodyPartButtom(
                      bodyPart: BodyPart.head,
                      selected: defendingBodyPart == BodyPart.head,
                      bodyPartSetter: _selectDefendingBodyPart,
                    ),
                    const SizedBox(height: 14),
                    BodyPartButtom(
                      bodyPart: BodyPart.torso,
                      selected: defendingBodyPart == BodyPart.torso,
                      bodyPartSetter: _selectDefendingBodyPart,
                    ),
                    const SizedBox(height: 14),
                    BodyPartButtom(
                      bodyPart: BodyPart.legs,
                      selected: defendingBodyPart == BodyPart.legs,
                      bodyPartSetter: _selectDefendingBodyPart,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    Text("Attack".toUpperCase()),
                    const SizedBox(height: 13),
                    BodyPartButtom(
                      bodyPart: BodyPart.head,
                      selected: attackingBodyPart == BodyPart.head,
                      bodyPartSetter: _selectAttackingBodyPart,
                    ),
                    const SizedBox(height: 14),
                    BodyPartButtom(
                      bodyPart: BodyPart.torso,
                      selected: attackingBodyPart == BodyPart.torso,
                      bodyPartSetter: _selectAttackingBodyPart,
                    ),
                    const SizedBox(height: 14),
                    BodyPartButtom(
                      bodyPart: BodyPart.legs,
                      selected: attackingBodyPart == BodyPart.legs,
                      bodyPartSetter: _selectAttackingBodyPart,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (attackingBodyPart != null &&
                        defendingBodyPart != null) {
                      setState(() {
                        attackingBodyPart = null;
                        defendingBodyPart = null;
                      });
                    }
                  },
                  child: SizedBox(
                    height: 40,
                    child: ColoredBox(
                      color:
                          attackingBodyPart == null || defendingBodyPart == null
                              ? Colors.black38
                              : const Color.fromRGBO(0, 0, 0, 0.87),
                      child: Center(
                        child: Text(
                          "Go".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            //fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(final BodyPart value) {
    setState(() {
      attackingBodyPart = value;
    });
  }
}

class Fightersinfo extends StatelessWidget {
  const Fightersinfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Center(
            child: Column(
              children: const [
                Text("You"),
                LivesWidget(
                  overallLiveCount: 5,
                  currentLiveCount: 5,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Center(
            child: Column(
              children: const [
                Text("You"),
                LivesWidget(
                  overallLiveCount: 5,
                  currentLiveCount: 5,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

class LivesWidget extends StatelessWidget {
  final int overallLiveCount;
  final int currentLiveCount;

  const LivesWidget({
    Key? key,
    required this.overallLiveCount,
    required this.currentLiveCount,
  })  : assert(overallLiveCount >= 1),
        assert(currentLiveCount >= 0),
        assert(currentLiveCount <= overallLiveCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        overallLiveCount,
        (index) {
          if (index < currentLiveCount) {
            return const Text(
              "1",
            );
          } else {
            return const Text(
              "0",
            );
          }
        },
      ),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);
  static const head = BodyPart._("Head");
  static const torso = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }
}

class BodyPartButtom extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButtom({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color:
              selected ? const Color.fromRGBO(28, 121, 206, 1) : Colors.black38,
          child: Center(
            child: Text(
              bodyPart.name.toUpperCase(),
            ),
          ),
        ),
      ),
    );
  }
}
