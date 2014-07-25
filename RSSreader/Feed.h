//
//  Feed.h
//  RSSreader
//
//  Created by quadramma on 7/24/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feed : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *imageUrl;

@end
