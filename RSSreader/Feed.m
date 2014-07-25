//
//  Feed.m
//  RSSreader
//
//  Created by quadramma on 7/24/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "Feed.h"

@implementation Feed

@synthesize title;
@synthesize description;
@synthesize link;
@synthesize imageUrl;

-(id)init
{
    self = [super init];
    if (self) {
        if(!title)
            title       = [[NSString alloc] init];
        if(!description)
            description = [[NSString alloc] init];
        if(!link)
            link        = [[NSString alloc] init];
        if(!imageUrl)
            imageUrl    = [[NSString alloc] init];
    }
    return self;
}


@end
