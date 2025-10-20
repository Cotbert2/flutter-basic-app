import 'package:flutter/material.dart';
import '../core/weight_analyzer.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  static const int members = 5;
  static const int scales = WeightAnalyzer.scalesCount;

  int currentMember = 0;

  // Controllers for each member
  late final List<TextEditingController> lastWeightCtrls;
  late final List<List<TextEditingController>> scaleCtrls; // [member][scale]

  // Cached results as we go
  late final List<WeightResult?> results;

  @override
  void initState() {
    super.initState();
    lastWeightCtrls = List.generate(members, (_) => TextEditingController());
    scaleCtrls = List.generate(
      members,
      (_) => List.generate(scales, (_) => TextEditingController()),
    );
    results = List<WeightResult?>.filled(members, null);
  }

  @override
  void dispose() {
    for (final c in lastWeightCtrls) {
      c.dispose();
    }

    for (final member in scaleCtrls) {
      for (final c in member) {
        c.dispose();
      }
    }
    super.dispose();
  }

  void showHelperPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exercise Description #15'),
          content: const Text(
            'Five members of an anti-obesity club want to know how much weight they have lost or gained since the last time they met. To do this, they must perform a weigh-in ritual, where each member weighs themselves on ten different scales to obtain the most accurate average of their weight. If there is a positive difference between this average weight and the weight from the last time they met, it means they have gained weight. But if the difference is negative, it means they have lost weight. The problem requires that each member be given a sign that says "GAINED" or "LOST" and the number of kilos they have gained or lost.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Flutter App: Weight'),
        actions: [
          IconButton(icon: const Icon(Icons.info), onPressed: showHelperPopUp),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Member ${currentMember + 1} of $members',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Last weight (kg)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: lastWeightCtrls[currentMember],
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'e.g., 80.5',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Scale readings (10 different scales)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...List.generate(scales ~/ 2, (row) {
                        final i = row * 2;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Expanded(child: _readingField(currentMember, i)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _readingField(currentMember, i + 1),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: currentMember == 0 ? null : _onBack,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text(
                        'Back',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _onNext,
                      icon: Icon(
                        currentMember == members - 1
                            ? Icons.check
                            : Icons.arrow_forward,
                      ),
                      label: Text(
                        currentMember == members - 1 ? 'Finish' : 'Next',
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: _resetAll,
                icon: const Icon(Icons.refresh, color: Colors.red),
                label: const Text(
                  'Reset all',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _readingField(int memberIndex, int scaleIndex) {
    return TextField(
      controller: scaleCtrls[memberIndex][scaleIndex],
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Scale ${scaleIndex + 1} (kg)',
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        floatingLabelStyle: TextStyle(color: Colors.blue),
      ),
    );
  }

  void _resetAll() {
    setState(() {
      currentMember = 0;

      for (final c in lastWeightCtrls) {
        c.clear();
      }

      for (final member in scaleCtrls) {
        for (final c in member) {
          c.clear();
        }
      }

      results = List<WeightResult?>.filled(members, null);
    });
  }

  void _onBack() {
    if (currentMember > 0) {
      setState(() {
        currentMember--;
      });
    }
  }

  void _onNext() {
    final errors = _validateMember(currentMember);
    if (errors.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errors.join(' | '))));
      return;
    }

    // Compute and store result for current member
    final last = double.parse(
      lastWeightCtrls[currentMember].text.trim().replaceAll(',', '.'),
    );
    final readings = _collectReadings(currentMember);
    results[currentMember] = WeightAnalyzer.analyze(
      lastWeight: last,
      readings: readings,
    );

    if (currentMember < members - 1) {
      setState(() {
        currentMember++;
      });
    } else {
      _showResults();
    }
  }

  List<String> _validateMember(int i) {
    final errs = <String>[];
    final lastStr = lastWeightCtrls[i].text.trim();
    final last = double.tryParse(lastStr.replaceAll(',', '.'));
    if (last == null || last <= 0) {
      errs.add('Invalid last weight');
    }
    final readings = _collectReadings(i, tolerant: true);
    if (readings.length != scales) {
      errs.add('Please enter all $scales readings');
    } else if (readings.any((v) => v <= 0)) {
      errs.add('Readings must be positive');
    }
    return errs;
  }

  List<double> _collectReadings(int i, {bool tolerant = false}) {
    final vals = <double>[];
    for (int j = 0; j < scales; j++) {
      final txt = scaleCtrls[i][j].text.trim();
      if (txt.isEmpty) {
        if (tolerant) {
          continue;
        } else {
          return <double>[];
        }
      }
      final v = double.tryParse(txt.replaceAll(',', '.'));
      if (v == null) {
        if (tolerant) {
          continue;
        } else {
          return <double>[];
        }
      }
      vals.add(v);
    }
    return vals;
  }

  void _showResults() {
    for (int i = 0; i < members; i++) {
      if (results[i] == null) {
        final errs = _validateMember(i);
        if (errs.isEmpty) {
          final last = double.parse(
            lastWeightCtrls[i].text.trim().replaceAll(',', '.'),
          );
          final readings = _collectReadings(i);
          results[i] = WeightAnalyzer.analyze(
            lastWeight: last,
            readings: readings,
          );
        }
      }
    }

    final issues = <String>[];
    for (int i = 0; i < members; i++) {
      if (results[i] == null) {
        issues.add('Member ${i + 1} has incomplete/invalid data');
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Weigh-in Results'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(members, (i) {
                  final res = results[i];
                  if (res == null) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Member ${i + 1}: Missing or invalid data',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  final color = res.status == 'GAINED'
                      ? Colors.red
                      : res.status == 'LOST'
                      ? Colors.green
                      : Colors.grey;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black87),
                        children: [
                          TextSpan(
                            text: 'Member ${i + 1}: ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                '${res.status} ${res.kilos.toStringAsFixed(2)} kg (avg ${res.average.toStringAsFixed(2)} kg)',
                            style: TextStyle(color: color),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                if (issues.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text(
                    'Issues found:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ...issues.map((e) => Text('- $e')),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }
}
