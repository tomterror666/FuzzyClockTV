//
//  ViewController.m
//  FuzzyClockTV
//
//  Created by Andre Hess on 29.10.15.
//  Copyright © 2015 Andre Hess. All rights reserved.
//

#import "MainViewController.h"
#import "NSString+FuzzyTime.h"

#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface MainViewController ()
@property (nonatomic, weak) IBOutlet UILabel *fuzzyClockLabel;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerViewController *playerController;
@property (nonatomic, strong) NSDate *now;
//@property (nonatomic, strong) id moviePlayer;
@end

@implementation MainViewController

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.fuzzyClockLabel.text = [[NSString alloc] initWithFuzzyDate:[NSDate date]];
	[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateFuzzyTime) userInfo:nil repeats:YES];
	
//	Class webviewClass = NSClassFromString(@"UIWebView");
//	id webView = [[webviewClass alloc] initWithFrame:self.view.bounds];
//	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youtube.com/embed/5f2T-5mq_UY/?autoplay=1"]];
////	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youtube.com/watch?v=cYU_dhrmvyU"]];
//	[webView loadRequest:request];
//	[self.view insertSubview:webView atIndex:0];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	//NSString *urlStr = @"http://techslides.com/demos/sample-videos/small.mp4";//https://www.youtube.com/embed/5f2T-5mq_UY/?autoplay=1";
	NSString *urlStr = @"https://ia600801.us.archive.org/31/items/SnowFalling_201402/Snow%20H264.mp4";
//	NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"Snow" ofType:@"mov"];
//	NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"small" ofType:@"mp4"];
	
	
//	<iframe width="854" height="480" src="https://www.youtube.com/embed/RuqVnqNPyC0" frameborder="0" allowfullscreen></iframe>
	
	NSURL *url = [NSURL URLWithString:urlStr];
	//NSURL *url = [NSURL fileURLWithPath:urlStr];
//	Class moviPlayerClass = NSClassFromString(@"MPMoviePlayerController");
//	self.moviePlayer = [[moviPlayerClass alloc] initWithContentURL:url];
//	[self.moviePlayer prepareToPlay];
//	[self.view insertSubview:[self.moviePlayer view] atIndex:0];
//	[self.moviePlayer view].frame = CGRectInset(self.view.bounds, 100, 100);
//	[self.moviePlayer play];
	
	self.playerItem = [AVPlayerItem playerItemWithURL:url];
	NSError *playerError = self.playerItem.error;
	self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRewind:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
	
	self.playerController = [[AVPlayerViewController alloc] initWithNibName:nil bundle:nil];
	self.playerController.player = self.player;
	
	self.playerController.view.frame = self.view.bounds;
	[self addChildViewController:self.playerController];
	[self.view insertSubview:self.playerController.view atIndex:0];
	[self.playerController didMoveToParentViewController:self];
	self.playerController.showsPlaybackControls = NO;
	self.now = [NSDate date];
	[self.playerController.player play];
}

- (void)updateFuzzyTime {
	self.fuzzyClockLabel.text = [[NSString alloc] initWithFuzzyDate:[NSDate date]];
}

- (void)handleRewind:(NSNotification *)notification {
	//[self.player pause];
	self.playerController.showsPlaybackControls = NO;
	[self.player seekToTime:kCMTimeZero];
	[self.player play];
}

@end
