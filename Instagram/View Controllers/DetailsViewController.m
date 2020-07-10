//
//  DetailsViewController.m
//  Instagram
//
//  Created by Julie Herrick on 7/9/20.
//  Copyright © 2020 Julie Herrick. All rights reserved.
//

#import "DetailsViewController.h"
#import "Post.h"
#import "DateTools.h"
@import Parse;

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshData];
}
- (void)refreshData {
    self.photoImageView.file = self.post.image;
    [self.photoImageView loadInBackground];
    self.usernameLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    
    NSDate *createdAt = [self.post createdAt];
    self.timestampLabel.text = createdAt.timeAgoSinceNow;
    
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
