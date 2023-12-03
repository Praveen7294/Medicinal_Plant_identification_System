import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late String output = '';

  @override
  Widget build(BuildContext context) {
    Map info = ModalRoute.of(context)?.settings.arguments as Map;

    setState(() {
      output = info['rsoutput'].toString().replaceAll(' ', '');
      print(output);
    });
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Forest.jpg'), fit: BoxFit.cover)),
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.green.withOpacity(0.9),
                child: const Text(
                  "Arogyam",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              )),
              Expanded(
                flex: 8,
                child: Container(
                  color: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          color: Colors.transparent.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const Text(
                                'Chemical Composition and',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Medicinal values',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                info[output],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        )));
  }
}
