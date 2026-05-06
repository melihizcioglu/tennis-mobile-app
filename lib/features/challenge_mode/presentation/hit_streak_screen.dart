import 'dart:async';

import 'package:flutter/material.dart';

/// İsabet serisi: hedef bölge arayüzde yanıp söner, kullanıcı oraya atış yapmalı.
class HitStreakScreen extends StatefulWidget {
  const HitStreakScreen({super.key});

  @override
  State<HitStreakScreen> createState() => _HitStreakScreenState();
}

class _HitStreakScreenState extends State<HitStreakScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _blinkController;
  int _streak = 0;
  bool _isPlaying = false;
  static const _targets = ['Sol köşe', 'Sağ köşe', 'Orta', 'Fileye yakın'];

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İsabet Serisi'),
      ),
      body: Column(
        children: [
          if (_isPlaying) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_fire_department,
                      color: Theme.of(context).colorScheme.primary, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    'Seri: $_streak',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: _BlinkingTarget(
                  controller: _blinkController,
                  label: _targets[_streak % _targets.length],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Hedef: ${_targets[_streak % _targets.length]}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ] else ...[
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        Icons.gps_fixed,
                        size: 64,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Hedef bölge ekranda yanıp sönecek. '
                        'Topu o bölgeye atarak isabet serinizi artırın.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: FilledButton.icon(
                onPressed: () => setState(() {
                  _isPlaying = true;
                  _streak = 0;
                }),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Başla'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ],
      ),
      bottomNavigationBar: _isPlaying
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: OutlinedButton(
                  onPressed: () => setState(() => _isPlaying = false),
                  child: const Text('Bitir'),
                ),
              ),
            )
          : null,
    );
  }
}

class _BlinkingTarget extends AnimatedWidget {
  const _BlinkingTarget({
    required this.controller,
    required this.label,
  }) : super(listenable: controller);

  final AnimationController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    final anim = controller;
    return AnimatedBuilder(
      animation: anim,
      builder: (context, child) {
        return Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary.withValues(
                  alpha: 0.2 + (anim.value * 0.5),
                ),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 4 + (anim.value * 4),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                blurRadius: 12 + (anim.value * 8),
                spreadRadius: anim.value * 4,
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ),
        );
      },
    );
  }
}
