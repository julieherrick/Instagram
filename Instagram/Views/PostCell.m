//
//  PostCell.m
//  Instagram
//
//  Created by Julie Herrick on 7/7/20.
//  Copyright © 2020 Julie Herrick. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    self.photoImageView.file = post.image;
    [self.photoImageView loadInBackground];
    self.usernameLabel.text = post.author.username;
    self.captionLabel.text = post.caption;
}

@end
