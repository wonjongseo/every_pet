import 'package:every_pet/common/admob/ad_unit_id.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialManager {
  static final InterstitialManager instance = InterstitialManager._();
  InterstitialManager._();

  InterstitialAd? _ad;
  bool _isLoading = false;

  // 설정값
  int _maxPerDay = 3;
  double _showChance = 0.35; // 35% 확률
  int _cooldownMinutes = 0; // 0 이면 비활성화

  // 상태 키
  static const _kDateKey = 'interstitial_day';
  static const _kCountKey = 'interstitial_count';
  static const _kLastTsKey = 'interstitial_last_ts';

  // ---------- 공개 API ----------

  /// 초기 설정 (앱 시작 시 1회)
  void configure({
    required int maxPerDay,
    required double showChance,
    int cooldownMinutes = 0,
  }) {
    _maxPerDay = maxPerDay;
    _showChance = showChance.clamp(0.0, 1.0);
    _cooldownMinutes = cooldownMinutes.clamp(0, 24 * 60);
  }

  /// 광고 미리 로드 (앱 시작 시 1회 권장)
  void preload() {
    if (_isLoading || _ad != null) return;
    _isLoading = true;
    InterstitialAd.load(
      adUnitId: AdUnitId().interstitial[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _isLoading = false;
          _attachCallbacks(ad);
        },
        onAdFailedToLoad: (err) {
          _ad = null;
          _isLoading = false;
          if (kDebugMode) {
            print('Interstitial load failed: $err');
          }
        },
      ),
    );
  }

  /// “랜덤 + 하루 캡 + 쿨다운” 조건을 통과하면 광고 표시.
  /// 표시했다면 true, 아니면 false.
  Future<bool> maybeShow() async {
    // 준비 여부
    if (_ad == null) return false;

    // 조건 확인
    final ok = await _shouldShowNow();
    if (!ok) return false;

    // 표시
    await _ad!.show();
    _ad = null;

    // 카운트 + 타임스탬프 업데이트
    await _markShown();

    return true;
  }

  // ---------- 내부 ----------

  void _attachCallbacks(InterstitialAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _ad = null;
        // 다음을 위해 즉시 예열
        preload();
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        ad.dispose();
        _ad = null;
        preload();
      },
    );
  }

  String _todayKey() {
    final now = DateTime.now();
    final y = now.year.toString().padLeft(4, '0');
    final m = now.month.toString().padLeft(2, '0');
    final d = now.day.toString().padLeft(2, '0');
    return '$y$m$d';
  }

  Future<bool> _shouldShowNow() async {
    // 날짜 리셋
    final today = _todayKey();
    final savedDay = await SettingRepository.getString(_kDateKey);
    if (savedDay != today) {
      await SettingRepository.setString(_kDateKey, today);
      await SettingRepository.setInt(_kCountKey, 0);
      await SettingRepository.setInt(_kLastTsKey, 0);
    }

    // 일일 캡
    final count = await SettingRepository.getInt(_kCountKey);
    if (count >= _maxPerDay) return false;

    // 쿨다운 검사
    if (_cooldownMinutes > 0) {
      final lastTs = await SettingRepository.getInt(_kLastTsKey);
      if (lastTs > 0) {
        final elapsed = DateTime.now().millisecondsSinceEpoch - lastTs;
        if (elapsed < _cooldownMinutes * 60 * 1000) {
          return false;
        }
      }
    }

    // 랜덤 확률
    final r = Random().nextDouble();
    if (r > _showChance) return false;

    return true;
  }

  Future<void> _markShown() async {
    final count = (await SettingRepository.getInt(_kCountKey)) + 1;
    await SettingRepository.setInt(_kCountKey, count);
    await SettingRepository.setInt(
        _kLastTsKey, DateTime.now().millisecondsSinceEpoch);
  }
}
