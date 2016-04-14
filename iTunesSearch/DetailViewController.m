
//
//  DetailViewController.m
//  iTunesSearch
//
//  Created by Md Adit Hasan on 4/5/16.
//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//

#import "DetailViewController.h"
#import "iService.h"

@interface DetailViewController()<UIWebViewDelegate>

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [iService downloadImageWithURL:[NSURL URLWithString:self.trackObject.artWorkURL100] completionBlock:^(BOOL succeeded, UIImage *image) {
        
        self.topPhoto.image = image;
    }];
    
    self.trackName.text = self.trackObject.trackName;
    
    NSString *combineString = [NSString stringWithFormat:@"<html><body><p>%@</p></body></html>",self.trackObject.longDescription];
    self.longDescription.delegate = self;
    [self.longDescription loadHTMLString:combineString baseURL:nil];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.heightConstraints.constant = webView.scrollView.contentSize.height +100;
    [self.mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.heightConstraints.constant + self.topPhoto.frame.size.height + self.trackName.frame.size.height + 100)];
    [self.mainScrollView setScrollEnabled:YES];

}

@end
