//
//  MovieDetailViewController.m
//  rottenTomatoes
//
//  Created by Eugenia Leong on 3/15/14.
//  Copyright (c) 2014 Eugenia Leong. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieData.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cast;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;
@property (weak, nonatomic) IBOutlet UIImageView *poster;


@end

@implementation MovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.movieData.movieTitle;
    self.synopsis.text = self.movieData.movieDescription;
    self.cast.text = self.movieData.cast;
    
    [self.poster setImageWithURL:[NSURL URLWithString:self.movieData.posterURL] placeholderImage:[UIImage imageNamed:self.title]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)close:(id)sender
{
    
}

@end
