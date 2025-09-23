import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../services/audio_service.dart';

class AudioProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isPlaying = false;
  bool _isLoading = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  String? _currentAudioUrl;
  String? _error;
  int? _currentSurahNumber;
  int? _currentAyahNumber;

  // Getters
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  Duration get position => _position;
  Duration get duration => _duration;
  String? get currentAudioUrl => _currentAudioUrl;
  String? get error => _error;
  int? get currentSurahNumber => _currentSurahNumber;
  int? get currentAyahNumber => _currentAyahNumber;

  AudioProvider() {
    _initializeAudioPlayer();
  }

  void _initializeAudioPlayer() {
    _audioPlayer.positionStream.listen((position) {
      _position = position;
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((duration) {
      _duration = duration ?? Duration.zero;
      notifyListeners();
    });

    _audioPlayer.playingStream.listen((playing) {
      _isPlaying = playing;
      notifyListeners();
    });

    _audioPlayer.processingStateStream.listen((state) {
      _isLoading =
          state == ProcessingState.loading ||
          state == ProcessingState.buffering;
      notifyListeners();
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _isPlaying = false;
        notifyListeners();
      }
    });
  }

  // Play ayah audio
  Future<void> playAyahAudio(
    int ayahNumber, {
    int? surahNumber,
    int? ayahNumberInSurah,
  }) async {
    try {
      _error = null;
      _isLoading = true;
      _currentSurahNumber = surahNumber;
      _currentAyahNumber = ayahNumberInSurah;
      notifyListeners();

      final audioUrl = await AudioService.getAyahAudioUrl(ayahNumber);

      if (audioUrl == null) {
        throw Exception('Failed to get audio URL');
      }

      if (_currentAudioUrl != audioUrl) {
        await _audioPlayer.setUrl(audioUrl);
        _currentAudioUrl = audioUrl;
      }

      await _audioPlayer.play();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to play audio: $e';
      notifyListeners();
    }
  }

  // Play surah audio
  Future<void> playSurahAudio(int surahNumber) async {
    try {
      _error = null;
      _isLoading = true;
      _currentSurahNumber = surahNumber;
      _currentAyahNumber = null;
      notifyListeners();

      final audioUrl = await AudioService.getSurahAudioUrl(surahNumber);

      if (audioUrl == null) {
        throw Exception('Failed to get audio URL');
      }

      if (_currentAudioUrl != audioUrl) {
        await _audioPlayer.setUrl(audioUrl);
        _currentAudioUrl = audioUrl;
      }

      await _audioPlayer.play();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to play audio: $e';
      notifyListeners();
    }
  }

  // Legacy method for backward compatibility
  Future<void> playAudio(
    String audioUrl, {
    int? surahNumber,
    int? ayahNumber,
  }) async {
    try {
      _error = null;
      _isLoading = true;
      _currentSurahNumber = surahNumber;
      _currentAyahNumber = ayahNumber;
      notifyListeners();

      if (_currentAudioUrl != audioUrl) {
        await _audioPlayer.setUrl(audioUrl);
        _currentAudioUrl = audioUrl;
      }

      await _audioPlayer.play();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to play audio: $e';
      notifyListeners();
    }
  }

  // Pause audio
  Future<void> pauseAudio() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      _error = 'Failed to pause audio: $e';
      notifyListeners();
    }
  }

  // Stop audio
  Future<void> stopAudio() async {
    try {
      await _audioPlayer.stop();
      _position = Duration.zero;
      _currentSurahNumber = null;
      _currentAyahNumber = null;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to stop audio: $e';
      notifyListeners();
    }
  }

  // Seek to position
  Future<void> seekTo(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      _error = 'Failed to seek: $e';
      notifyListeners();
    }
  }

  // Set volume
  Future<void> setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume);
    } catch (e) {
      _error = 'Failed to set volume: $e';
      notifyListeners();
    }
  }

  // Set playback speed
  Future<void> setSpeed(double speed) async {
    try {
      await _audioPlayer.setSpeed(speed);
    } catch (e) {
      _error = 'Failed to set speed: $e';
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
