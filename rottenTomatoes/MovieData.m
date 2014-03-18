//
//  MovieData.m
//  rottenTomatoes
//
//  Created by Eugenia Leong on 3/15/14.
//  Copyright (c) 2014 Eugenia Leong. All rights reserved.
//

#import "MovieData.h"

@implementation MovieData

-(id)initWithParameters:(NSString *)movieTitle :(NSString *)movieDescription : (NSString *)cast : (NSString *)posterURL
{
    if(self = [super init]) {
        self.movieTitle = movieTitle;
        self.movieDescription = movieDescription ;
        self.cast = cast;
        self.posterURL = posterURL;

    }
    return self;
}

@end