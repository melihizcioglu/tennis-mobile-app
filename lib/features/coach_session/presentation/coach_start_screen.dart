import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/router/app_router.dart';
import '../providers/coach_session_provider.dart';

class CoachStartScreen extends ConsumerStatefulWidget {
  const CoachStartScreen({super.key});

  @override
  ConsumerState<CoachStartScreen> createState() => _CoachStartScreenState();
}

class _CoachStartScreenState extends ConsumerState<CoachStartScreen> {
  bool _isCreating = false;
  String? _sessionId;
  String? _error;

  Future<void> _startSession() async {
    setState(() {
      _isCreating = true;
      _error = null;
      _sessionId = null;
    });
    try {
      final id = await ref.read(coachSessionRepositoryProvider).createSession();
      setState(() {
        _sessionId = id;
        _isCreating = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isCreating = false;
      });
    }
  }

  void _openSession() {
    if (_sessionId != null) {
      context.push('${AppRoutes.coachSession}/$_sessionId');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Antrenör - Yeni Oturum')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final padding = constraints.maxWidth >= 600 ? 32.0 : 24.0;
          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Center(
          child: _sessionId == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Kullanıcının okutması için QR kodu oluşturun.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    if (_error != null) ...[
                      Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                      const SizedBox(height: 16),
                    ],
                    FilledButton.icon(
                      onPressed: _isCreating ? null : _startSession,
                      icon: _isCreating
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.add),
                      label: Text(_isCreating ? 'Oluşturuluyor...' : 'Yeni Oturum Başlat'),
                    ),
                  ],
                )
              : Column(
                  children: [
                    const Text(
                      'Kullanıcı bu QR kodu okutsun',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 24),
                    QrImageView(
                      data: _sessionId!,
                      version: QrVersions.auto,
                      size: 220,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: _openSession,
                      child: const Text('Oturum Ekranına Git'),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => setState(() => _sessionId = null),
                      child: const Text('İptal'),
                    ),
                  ],
                ),
            ),
          );
        },
      ),
    );
  }
}
