//
//  MovieCell.h
//  rottenTomatoes
//
//  Created by Eugenia Leong on 3/15/14.
//  Copyright (c) 2014 Eugenia Leong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UIImageView *posterThumbnail;
@property (nonatomic, weak) IBOutlet UILabel *movieTitle;
@property (nonatomic, weak) IBOutlet UILabel *movieDescription;
@property (nonatomic, weak) IBOutlet UILabel *cast;

@end
