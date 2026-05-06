import 'dart:async';

import 'package:flutter/material.dart';

/// Seviye challenge: örn. 30 saniyede 10 isabetli atış.
class LevelChallengeScreen extends StatefulWidget {
  const LevelChallengeScreen({super.key});

  @override
  State<LevelChallengeScreen> createState() => _LevelChallengeScreenState();
}

class _LevelChallengeScreenState extends State<LevelChallengeScreen> {
  int _selectedSeconds = 30;
  int _selectedHits = 10;
  bool _isPlaying = false;
  int _remainingSeconds = 0;
  int _currentHits = 0;
  Timer? _timer;

  static const _durations = [15, 30, 45, 60];
  static const _hitTargets = [5, 10, 15, 20, 25];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startChallenge() {
    setState(() {
      _isPlaying = true;
      _remainingSeconds = _selectedSeconds;
      _currentHits = 0;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        _remainingSeconds--;
        if (_remainingSeconds <= 0) {
          t.cancel();
          _onChallengeEnd();
        }
      });
    });
  }

  void _onChallengeEnd() {
    final success = _currentHits >= _selectedHits;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(success ? 'Tebrikler!' : 'Süre Doldu'),
        content: Text(
          success
              ? '$_selectedHits isabet hedefine $_currentHits isabetle ulaştınız!'
              : 'Hedef: $_selectedHits isabet. Yaptığınız: $_currentHits isabet.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() => _isPlaying = false);
              _startChallenge();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seviye Challenge'),
      ),
      body: _isPlaying ? _buildPlayView() : _buildSetupView(),
    );
  }

  Widget _buildSetupView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Süre (saniye)',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _durations.map((s) {
                    final selected = _selectedSeconds == s;
                    return FilterChip(
                      label: Text('$s sn'),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedSeconds = s),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hedef isabet sayısı',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _hitTargets.map((h) {
                    final selected = _selectedHits == h;
                    return FilterChip(
                      label: Text('$h isabet'),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedHits = h),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        FilledButton.icon(
          onPressed: _startChallenge,
          icon: const Icon(Icons.timer),
          label: Text('$_selectedSeconds saniyede $_selectedHits isabet – Başla'),
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 0),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayView() {
    return Column(
      children: [
        const Spacer(),
        Text(
          '$_remainingSeconds',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        Text(
          'saniye kaldı',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_currentHits',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              ' / $_selectedHits isabet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(24),
          child: FilledButton.icon(
            onPressed: () {
              setState(() => _currentHits++);
              if (_currentHits >= _selectedHits) {
                _timer?.cancel();
                _onChallengeEnd();
              }
            },
            icon: const Icon(Icons.add),
            label: const Text('İsabet (simülasyon)'),
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 0),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
