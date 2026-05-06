import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Maç kurulum ekranı: skor senaryosu, seviye, rakip stil, süre seçimi.
class MatchSetupScreen extends ConsumerStatefulWidget {
  const MatchSetupScreen({super.key});

  @override
  ConsumerState<MatchSetupScreen> createState() => _MatchSetupScreenState();
}

class _MatchSetupScreenState extends ConsumerState<MatchSetupScreen> {
  String? _scoreScenario;
  String? _level;
  String? _opponentStyle;
  int? _durationMinutes;
  final _formKey = GlobalKey<FormState>();

  static const _scoreScenarios = [
    ('normal', 'Normal (0-0\'dan başla)'),
    ('break_down', 'Break geride (örn. 2-3)'),
    ('break_up', 'Break önde (örn. 3-2)'),
    ('set_point', 'Set puanı (5-4, 40-30)'),
    ('match_point', 'Maç puanı'),
  ];

  static const _levels = [
    ('beginner', 'Başlangıç'),
    ('intermediate', 'Orta'),
    ('advanced', 'İleri'),
    ('pro', 'Profesyonel'),
  ];

  static const _opponentStyles = [
    ('aggressive', 'Agresif (sert vuruş, risk alan)'),
    ('defensive', 'Savunmacı (uzun rally)'),
    ('all_court', 'All-court (dengeli)'),
    ('serve_volley', 'Servis-vole'),
  ];

  static const _durations = [5, 10, 15, 20, 30, 45, 60, null]; // null = süresiz

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maç Kurulumu'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SectionTitle(title: 'Skor senaryosu'),
            ..._scoreScenarios.map((e) => RadioListTile<String>(
                  title: Text(e.$2),
                  value: e.$1,
                  groupValue: _scoreScenario,
                  onChanged: (v) => setState(() => _scoreScenario = v),
                )),
            const SizedBox(height: 24),
            _SectionTitle(title: 'Seviye'),
            ..._levels.map((e) => RadioListTile<String>(
                  title: Text(e.$2),
                  value: e.$1,
                  groupValue: _level,
                  onChanged: (v) => setState(() => _level = v),
                )),
            const SizedBox(height: 24),
            _SectionTitle(title: 'Rakip stili'),
            ..._opponentStyles.map((e) => RadioListTile<String>(
                  title: Text(e.$2),
                  value: e.$1,
                  groupValue: _opponentStyle,
                  onChanged: (v) => setState(() => _opponentStyle = v),
                )),
            const SizedBox(height: 24),
            _SectionTitle(title: 'Süre (dakika) – isteğe bağlı'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _durations.map((d) {
                final label = d == null ? 'Süresiz' : '$d dk';
                final selected = _durationMinutes == d;
                return FilterChip(
                  label: Text(label),
                  selected: selected,
                  onSelected: (_) => setState(() => _durationMinutes = d),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _startMatch,
              child: const Text('Maçı Başlat'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startMatch() {
    if (_scoreScenario == null || _level == null || _opponentStyle == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen skor senaryosu, seviye ve rakip stili seçin.'),
        ),
      );
      return;
    }
    // TODO: Maç simülasyonu ekranına geçiş
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Maç: $_scoreScenario, $_level, $_opponentStyle, '
          'süre: ${_durationMinutes == null ? "süresiz" : "${_durationMinutes} dk"}',
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
