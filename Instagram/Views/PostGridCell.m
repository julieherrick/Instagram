//
//  PostGridCell.m
//  Instagram
//
//  Created by Julie Herrick on 7/10/20.
//  Copyright © 2020 Julie Herrick. All rights reserved.
//

#import "PostGridCell.h"

@implementation PostGridCell

- (void)setPost:(Post *)post {
    _post = post;
    self.photoImageView.file = post.image;
    [self.photoImageView loadInBackground];
    
}


@end
