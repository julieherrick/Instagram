//
//  ProfileViewController.m
//  Instagram
//
//  Created by Julie Herrick on 7/10/20.
//  Copyright © 2020 Julie Herrick. All rights reserved.
//

#import "ProfileViewController.h"
#import "Post.h"
#import "PostGridCell.h"
#import <Parse/Parse.h>
@import Parse;

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *posts;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *postCount;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) NSNumber *numberOfPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self collectionView];

    [self fetchPosts];
    
    self.profileImage.layer.cornerRadius = 45;
    self.profileImage.layer.masksToBounds = YES;
    
    self.usernameLabel.text = [PFUser currentUser].username;
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
     
     CGFloat postersPerLine = 2;
     CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)fetchPosts {
    // construct PFQuery
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Post"];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery whereKey:@"author" equalTo: [PFUser currentUser]];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.posts = (NSMutableArray *) posts;
            [self.collectionView reloadData];
        }
        else {
            // handle error
            NSLog(@"%@", error.localizedDescription);
        }
//        [self.refreshControl endRefreshing];
        NSLog(@"done refreshing");
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostGridCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    cell.post = post;
    
    return cell;
}

- (void)getPostCount {
    __block int count = 0;
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Post"];
        [postQuery orderByDescending:@"createdAt"];
        [postQuery whereKey:@"author" equalTo: [PFUser currentUser]];

        // fetch data asynchronously
        [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
            if (posts) {
                // do something with the data fetched
                count += 1;
            }
            else {
                // handle error
                NSLog(@"%@", error.localizedDescription);
            }
    //        [self.refreshControl endRefreshing];
            NSLog(@"done refreshing");
        }];
    self.numberOfPosts = [NSNumber numberWithInt:count];
    self.postCount.text = [NSString stringWithFormat:@"%@", self.numberOfPosts ];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
