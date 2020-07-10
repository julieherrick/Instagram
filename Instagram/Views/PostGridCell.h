//
//  PostGridCell.h
//  Instagram
//
//  Created by Julie Herrick on 7/10/20.
//  Copyright © 2020 Julie Herrick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;



NS_ASSUME_NONNULL_BEGIN

@interface PostGridCell : UICollectionViewCell

@property (weak, nonatomic) Post *post;

@property (weak, nonatomic) IBOutlet PFImageView *photoImageView;

@end

NS_ASSUME_NONNULL_END
