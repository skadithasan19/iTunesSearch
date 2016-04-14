//
//  DetailViewController.h
//  iTunesSearch
//
//  Created by Md Adit Hasan on 4/5/16.
//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Track.h"
@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *topPhoto;
@property (weak, nonatomic) IBOutlet UILabel *trackName;
@property (weak, nonatomic) IBOutlet UIWebView *longDescription;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraints;
@property (nonatomic, strong) Track *trackObject;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end
