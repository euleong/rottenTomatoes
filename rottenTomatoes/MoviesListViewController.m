//
//  MoviesListViewController.m
//  rottenTomatoes
//
//  Created by Eugenia Leong on 3/14/14.
//  Copyright (c) 2014 Eugenia Leong. All rights reserved.
//

#import "MoviesListViewController.h"
#import "MovieCell.h"
#import "MovieDetailViewController.h"
#import "MovieData.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"

@interface MoviesListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *moviesList;
@property (weak, nonatomic) IBOutlet UIView *networkError;


@end

NSString * const CELL_IDENTIFIER = @"MovieCell";
NSArray *movies;
MBProgressHUD *loadingHud;

@implementation MoviesListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Top DVD Rentals";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.moviesList.dataSource = self;
    self.moviesList.delegate = self;
    
    UINib *customNib = [UINib nibWithNibName:CELL_IDENTIFIER bundle:nil];
    [self.moviesList registerNib:customNib forCellReuseIdentifier:CELL_IDENTIFIER];
    
    // hide network error view by default
    [self.networkError setHidden:YES];
    
    // enable pull to refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Release to refresh"];
    [self.moviesList addSubview:refreshControl];
    
    [self getMovies];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator]; 
    
    cell.movieTitle.text = movies[indexPath.row][@"title"];

    cell.movieDescription.text = movies[indexPath.row][@"synopsis"];

    cell.cast.text = [NSString stringWithFormat:@"%@",[self getCastString:indexPath.row]];
    
    [cell.posterThumbnail setImageWithURL:[NSURL URLWithString:movies[indexPath.row][@"posters"][@"profile"]] placeholderImage:[UIImage imageNamed:cell.movieTitle.text]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0;
}

- (void) getMovies
{
    loadingHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    loadingHud.mode = MBProgressHUDModeAnnularDeterminate;
    loadingHud.labelText = @"loading";
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [loadingHud hide:YES];
        if (connectionError) {
            [self.networkError setHidden:NO];
            movies = nil;
        }
        else {
            [self.networkError setHidden:YES];
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", object);
            
            movies = [object objectForKey:@"movies"];
        }
        
        [self.moviesList reloadData];

    }];
}

-(NSString *)getCastString:(NSInteger)row
{
    NSArray *castList = movies[row][@"abridged_cast"];
    NSMutableArray *castMembers = [[NSMutableArray alloc]init];
    
    for (id object in castList)
    {
        [castMembers addObject:[NSString stringWithFormat:@"%@", object[@"name"]]];
    }
    
    NSString *result = [NSString stringWithFormat:@"%@", [castMembers componentsJoinedByString:@", "]];
    
    NSLog(@"%@",result);
    return result;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell *cell = (MovieCell*)[self.moviesList cellForRowAtIndexPath:indexPath];

    NSString *posterURL = movies[indexPath.row][@"posters"][@"original"];
    MovieData *movieData = [[MovieData alloc ] initWithParameters:cell.movieTitle.text :cell.movieDescription.text :cell.cast.text :posterURL];
    MovieDetailViewController *mdvc = [[MovieDetailViewController alloc] init];
    mdvc.movieData = movieData;
    [self.navigationController pushViewController:mdvc animated:YES];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self getMovies];
    [refreshControl endRefreshing];
}
@end
