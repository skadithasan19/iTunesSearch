//
//  SWActionSheet.h
//  iTunesSearch
//
//  Created by Md Adit Hasan on 4/5/16.
//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SKActionSheet : UIView
@property(nonatomic, strong) UIView *bgView;

- (void)dismissWithClickedButtonIndex:(int)i animated:(BOOL)animated;

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;

- (instancetype)initWithView:(UIView *)view;

- (void)showInContainerView;
@end