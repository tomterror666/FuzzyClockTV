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
@end

@implementation MainViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.fuzzyClockLabel.text = [[NSString alloc] initWithFuzzyDate:[NSDate date]];
	self.fuzzyClockLabel.textColor = [UIColor whiteColor];
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
	
	NSString *urlStr = @"http://techslides.com/demos/sample-videos/small.mp4";//https://www.youtube.com/embed/5f2T-5mq_UY/?autoplay=1";
	NSURL *url = [NSURL fileURLWithPath:urlStr];
//	Class moviPlayerClass = NSClassFromString(@"MPMoviePlayerController");
//	id moviePlayer = [[moviPlayerClass alloc] initWithContentURL:url];
//	[moviePlayer prepareToPlay];
//	[self.view insertSubview:[moviePlayer view] atIndex:0];
//	[moviePlayer view].frame = self.view.bounds;
//	[moviePlayer play];
	
	AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
	NSError *playerError = playerItem.error;
	AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
	
	AVPlayerViewController *playerController = [[AVPlayerViewController alloc] initWithNibName:nil bundle:nil];
	playerController.player = player;
	
	playerController.view.frame = CGRectInset(self.view.bounds, 100, 100);
	[self addChildViewController:playerController];
	[self.view insertSubview:playerController.view atIndex:0];
	[playerController didMoveToParentViewController:self];
	playerController.showsPlaybackControls = YES;
	[playerController.player play];
}

- (void)updateFuzzyTime {
	self.fuzzyClockLabel.text = [[NSString alloc] initWithFuzzyDate:[NSDate date]];
}

@end
