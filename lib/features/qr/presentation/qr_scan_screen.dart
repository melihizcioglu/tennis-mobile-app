import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../providers/session_join_provider.dart';
import '../../auth/providers/auth_provider.dart';

class QrScanScreen extends ConsumerStatefulWidget {
  const QrScanScreen({super.key});

  @override
  ConsumerState<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends ConsumerState<QrScanScreen> {
  final _controller = MobileScannerController();
  bool _isJoining = false;
  String? _message;
  bool _success = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_isJoining) return;
    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;
    final code = barcodes.first.rawValue;
    if (code == null || code.isEmpty) return;

    setState(() {
      _isJoining = true;
      _message = null;
    });

    try {
      final userId = ref.read(currentUserProvider)?.uid;
      if (userId == null) {
        setState(() {
          _message = 'Giriş yapmanız gerekiyor';
          _isJoining = false;
        });
        return;
      }

      final sessionId = _parseSessionId(code);
      await ref.read(sessionJoinRepositoryProvider).joinSession(sessionId, userId);

      setState(() {
        _success = true;
        _message = 'Antrenmana katıldınız!';
        _isJoining = false;
      });
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) context.pop();
    } catch (e) {
      setState(() {
        _message = e.toString().replaceFirst('Exception: ', '');
        _isJoining = false;
      });
    }
  }

  String _parseSessionId(String code) {
    if (code.startsWith('http')) {
      final uri = Uri.tryParse(code);
      final segment = uri?.pathSegments.last ?? code;
      return segment;
    }
    return code.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Okut')),
      body: Stack(
        children: [
          if (Platform.isIOS || Platform.isAndroid)
            MobileScanner(
              controller: _controller,
              onDetect: _onDetect,
            )
          else
            const Center(
              child: Text('QR okutma bu platformda desteklenmiyor'),
            ),
          if (_message != null)
            Positioned(
              left: 16,
              right: 16,
              bottom: 32,
              child: Material(
                color: _success ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _message!,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          if (_isJoining)
            const Center(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Katılıyor...'),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
