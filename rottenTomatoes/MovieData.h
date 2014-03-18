//
//  MovieData.h
//  rottenTomatoes
//
//  Created by Eugenia Leong on 3/15/14.
//  Copyright (c) 2014 Eugenia Leong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieData : NSObject
@property (nonatomic,weak) NSString *posterURL;
@property (nonatomic, weak) NSString *movieTitle;
@property (nonatomic, weak) NSString *movieDescription;
@property (nonatomic, weak) NSString *cast;

-(id)initWithParameters:(NSString *)movieTitle :(NSString *)movieDescription : (NSString *)cast : (NSString *)posterURL;

@end
