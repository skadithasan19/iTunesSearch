//
//  TrackManager.m
//  iTunesSearch
//
//  Created by Md Adit Hasan on 4/5/16.
//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//

#import "TrackManager.h"

@implementation TrackManager


+ (TrackManager *)shareTrackManager {
    
    static TrackManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance =[[TrackManager alloc] init];
    });
    
    return shareInstance;
}


- (void)addTracks:(NSArray *)contents {
    self.tracksArray = [[NSMutableArray alloc] initWithCapacity:[contents count]];
    [contents enumerateObjectsUsingBlock:^(NSDictionary *trackDictionary, NSUInteger idx, BOOL * _Nonnull stop) {
    
    Track *trackObj = [[Track alloc] init];
    [trackObj setTrackName:[trackDictionary valueForKey:@"trackName"]];
    [trackObj setKindName:[trackDictionary valueForKey:@"kind"]];
    [trackObj setTrackPrice:[trackDictionary valueForKey:@"trackPrice"]];
    [trackObj setArtWorkURL30:[trackDictionary valueForKey:@"artworkUrl30"]];
    [trackObj setArtWorkURL60:[trackDictionary valueForKey:@"artworkUrl60"]];
    [trackObj setArtWorkURL100:[trackDictionary valueForKey:@"artworkUrl100"]];
    [trackObj setShortDescription:[trackDictionary valueForKey:@"shortDescription"]];
    [trackObj setLongDescription:[trackDictionary valueForKey:@"longDescription"]];
    [trackObj setTrackCurrency:[trackDictionary valueForKey:@"currency"]];
    [self.tracksArray addObject:trackObj];
    }];
    
}

- (NSArray *) getTrackList {

    return self.tracksArray;
}

-(NSInteger) getTotalTrackCount {

    return [self.tracksArray count];
}

- (Track *)getTrackByIndex:(NSInteger)index {
    
    return [self.tracksArray objectAtIndex:index];
}

- (NSArray *) removeTrackList {
    
    [self.tracksArray removeAllObjects];
    return self.tracksArray;
}
@end
