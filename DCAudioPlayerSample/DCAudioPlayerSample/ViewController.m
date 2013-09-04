//
//  ViewController.m
//  DCAudioPlayerSample
//
//  Created by 廣川政樹 on 2013/07/31.
//  Copyright (c) 2013年 Dolice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property DCAudioPlayer *audioPlayer;
@property UISlider      *audioVolumeSlider;

@end

@implementation ViewController

typedef enum audioPlayButtonEvent : NSInteger {
    AUDIO_PLAY  = 1,
    AUDIO_PAUSE = 2,
    AUDIO_STOP  = 3
} audioPlayButtonEvent;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初期化
    _audioPlayer = [[DCAudioPlayer alloc] initWithAudio:AUDIO_RESOURCE_FILE_NAME
                                                    ext:AUDIO_RESOURCE_FILE_EXT
                                          isUseDelegate:YES];
    
    //再生/停止ボタンとボリュームスライダー表示
    [self setButtonsAndSlider];
}


//再生/停止ボタンイベント
- (void)buttonTapped:(UIButton *)button
{
    if (button.tag == AUDIO_PLAY) {
        //ボリューム指定
        [_audioPlayer setVolume:_audioVolumeSlider.value];
        
        //ループ回数指定
        [_audioPlayer setNumberOfLoops:0];
        
        //再生
        [_audioPlayer play];
    } else if (button.tag == AUDIO_PAUSE) {
        if (_audioPlayer.isPlaying) {
            //一時停止
            [_audioPlayer pause];
        } else {
            //再生
            [_audioPlayer play];
        }
    } else if (button.tag == AUDIO_STOP) {
        //再生フレーム指定
        [_audioPlayer setCurrentTime:0];
        //停止
        [_audioPlayer stop];
    }
}

//再生/停止ボタンとボリュームスライダーの表示
- (void)setButtonsAndSlider
{
    //再生ボタン
    UIButton *buttonPlay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonPlay.frame = CGRectMake(20, 50, BUTTON_WIDTH, BUTTON_HEIGHT);
    buttonPlay.tag = AUDIO_PLAY;
    [buttonPlay setTitle:@"Play" forState:UIControlStateNormal];
    [buttonPlay addTarget:self
                   action:@selector(buttonTapped:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonPlay];
    
    //一時停止ボタン
    UIButton *buttonPause = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonPause.frame = CGRectMake(120, 50, BUTTON_WIDTH, BUTTON_HEIGHT);
    buttonPause.tag = AUDIO_PAUSE;
    [buttonPause setTitle:@"Pause" forState:UIControlStateNormal];
    [buttonPause addTarget:self
                    action:@selector(buttonTapped:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonPause];
    
    //停止ボタン
    UIButton *buttonStop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonStop.frame = CGRectMake(220, 50, BUTTON_WIDTH, BUTTON_HEIGHT);
    buttonStop.tag = AUDIO_STOP;
    [buttonStop setTitle:@"Stop" forState:UIControlStateNormal];
    [buttonStop addTarget:self
                   action:@selector(buttonTapped:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonStop];
    
    //ボリュームスライダー
    _audioVolumeSlider = [_audioPlayer volumeControlSlider:self
                                                     point:CGPointMake(50, 150)
                                              defaultValue:0.5f
                                                  selector:@selector(sliderValueChanged:)];
    [self.view addSubview:_audioVolumeSlider];
}

//オーディオボリューム変更
- (void)sliderValueChanged:(UISlider *)slider
{
    if (_audioPlayer) {
        [_audioPlayer setVolume:slider.value];
    }
}

//再生終了時のデリゲートメソッド
- (void)dcAudioPlayerDidFinishPlaying
{
    NSLog(@"End Playing");
}

@end
