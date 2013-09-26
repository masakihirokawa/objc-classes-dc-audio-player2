DCAudioPlayer
=============================

音楽ファイルの再生停止などの制御をする「DCAudioPlayer」クラスです。

オーディオの再生／停止／一時停止／再生状況の取得、ボリュームコントロールスライダーの生成などを行えます。

このクラスの使用には AVFoundationフレームワークが必要になります。

##バックグラウンド再生するために必要な手順

###info.plistファイルを編集

1. info.plistファイルを Xcode左側のプロジェクトメニューから開く
2. Keyに Required background modesを追加
3. Item 0 の Valueを App plays audio に指定

##使用方法

###オーディオファイルを指定し初期化

```objective-c
_audioPlayer = [[DCAudioPlayer alloc] initWithAudio:AUDIO_RESOURCE_FILE_NAME
                                                ext:AUDIO_RESOURCE_FILE_EXT
                                      isUseDelegate:YES];
```

###再生

```objective-c
[_audioPlayer play];
```

###停止

```objective-c
[_audioPlayer stop];
```

###一時停止

```objective-c
[_audioPlayer pause];
```

###ボリュームコントロールスライダーの取得

```objective-c
_audioVolumeSlider = [_audioPlayer volumeControlSlider:self
                                                 point:CGPointMake(50, 150)
                                          defaultValue:0.5f
                                              selector:@selector(sliderValueChanged:)];
```

```objective-c
- (void)sliderValueChanged:(UISlider *)slider
{
    if (_audioPlayer) {
        [_audioPlayer setVolume:slider.value];
    }
}
```

###音量の指定

```objective-c
[_audioPlayer setVolume:0.5f];
```

###現在の再生フレームの指定

```objective-c
[_audioPlayer setCurrentTime:0];
```

###再生ループ回数の指定

```objective-c
[_audioPlayer setNumberOfLoops:-1];
```

###再生状況の取得

```objective-c
BOOL isPlaying = _audioPlayer.isPlaying;
```
