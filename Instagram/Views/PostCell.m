//
//  PostCell.m
//  Instagram
//
//  Created by Julie Herrick on 7/7/20.
//  Copyright © 2020 Julie Herrick. All rights reserved.
//

#import "PostCell.h"
#import "DateTools.h"

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
    
    
    NSMutableAttributedString *captionText = [[NSMutableAttributedString alloc] init];
    NSDictionary *bold = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17]} ; // dictionary with attributes
    NSDictionary *normal = @{NSFontAttributeName: [UIFont systemFontOfSize:17]} ; // dictionary with attributes
    NSAttributedString *formattedAuthor = [[NSAttributedString alloc] initWithString:post.author.username attributes:bold];
    NSAttributedString *formattedCaption = [[NSAttributedString alloc] initWithString:[@" " stringByAppendingString:post.caption] attributes:normal];
    
    [captionText appendAttributedString:formattedAuthor];
    [captionText appendAttributedString:formattedCaption];
    
    [self.captionLabel setAttributedText:captionText];
    
    NSDate *createdAt = [self.post createdAt];
    self.timestampLabel.text = createdAt.timeAgoSinceNow;
    
    self.profileImage.layer.cornerRadius = 26;
    self.profileImage.layer.masksToBounds = YES;
    
}


@end
