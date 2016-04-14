//
//  Track.h
//  iTunesSearch
//
//  Created by Md Adit Hasan on 4/5/16.
//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject

@property(nonatomic,strong) NSString *trackName;
@property(nonatomic,strong) NSString *artWorkURL30;
@property(nonatomic,strong) NSString *artWorkURL60;
@property(nonatomic,strong) NSString *artWorkURL100;
@property(nonatomic,strong) NSString *shortDescription;
@property(nonatomic,strong) NSString *longDescription;
@property(nonatomic,strong) NSString *kindName;
@property(nonatomic,strong) NSString *trackPrice;
@property(nonatomic,strong) NSString *trackCurrency;

@end
