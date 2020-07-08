//
//  PostCell.h
//  Instagram
//
//  Created by Julie Herrick on 7/7/20.
//  Copyright © 2020 Julie Herrick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
