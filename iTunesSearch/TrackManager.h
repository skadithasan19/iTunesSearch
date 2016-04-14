//
//  TrackManager.h
//  iTunesSearch
//
//  Created by Md Adit Hasan on 4/5/16.
//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Track.h"

@interface TrackManager : NSObject


@property (nonatomic,strong) NSMutableArray *tracksArray;

+ (TrackManager *)shareTrackManager;

- (NSArray *) getTrackList;

- (NSInteger) getTotalTrackCount;

- (NSArray *) removeTrackList;

- (Track *)getTrackByIndex:(NSInteger)index;

- (void)addTracks:(NSArray *)contents;


@end
