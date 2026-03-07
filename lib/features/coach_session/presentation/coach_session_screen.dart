import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../providers/coach_session_provider.dart';

class CoachSessionScreen extends ConsumerStatefulWidget {
  const CoachSessionScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  ConsumerState<CoachSessionScreen> createState() => _CoachSessionScreenState();
}

class _CoachSessionScreenState extends ConsumerState<CoachSessionScreen> {
  bool _timerRunning = false;
  int _elapsedSeconds = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(sessionStreamProvider(widget.sessionId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Antrenman Oturumu'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.coachStart),
        ),
      ),
      body: sessionAsync.when(
        data: (session) {
          if (session == null) {
            return const Center(child: Text('Oturum bulunamadı'));
          }
          final isWide = MediaQuery.sizeOf(context).shortestSide >= 600;
        return SingleChildScrollView(
            padding: EdgeInsets.all(isWide ? 24 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          _formatDuration(_elapsedSeconds),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                              onPressed: () {
                                _timer?.cancel();
                                setState(() => _timerRunning = !_timerRunning);
                                if (_timerRunning) _startTimer();
                              },
                              child: Text(_timerRunning ? 'Duraklat' : 'Başlat'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (session.userId != null) ...[
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Kullanıcı bağlandı'),
                      subtitle: Text('ID: ${session.userId}'),
                    ),
                  ),
                ] else
                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.hourglass_empty),
                      title: Text('Kullanıcı bekleniyor...'),
                      subtitle: Text('QR kodu okutulmasını bekleyin'),
                    ),
                  ),
                if (session.programId != null) ...[
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Program',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          ...(session.programSteps?.map((s) => ListTile(
                                leading: const Icon(Icons.check_circle_outline),
                                title: Text(s),
                              )) ?? []),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Hata: $e')),
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || !_timerRunning) {
        _timer?.cancel();
        return;
      }
      setState(() => _elapsedSeconds++);
    });
  }

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
