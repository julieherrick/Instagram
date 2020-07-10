//
//  ComposeViewController.m
//  Instagram
//
//  Created by Julie Herrick on 7/7/20.
//  Copyright © 2020 Julie Herrick. All rights reserved.
//

#import "ComposeViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "Post.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageToPost;
@property (weak, nonatomic) IBOutlet UITextView *captionToPost;

@property (strong, nonatomic) NSArray *posts;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.captionToPost.text = @"Caption...";
//    self.captionToPost.textColor = [UIColor grayColor];
}

- (IBAction)onPhotoSelect:(id)sender {
    NSLog(@"tapped");
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
//    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    [self.imageToPost setImage:[self resizeImage:editedImage withSize:CGSizeMake(414, 414)]];
    
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)onShare:(id)sender {
    
    [Post postUserImage:self.imageToPost.image withCaption:self.captionToPost.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"The post was shared!");
            [self backToFeed];
            
        } else {
            NSLog(@"Problem saving post: %@", error.localizedDescription);
        }
    }];
}
- (IBAction)onCancel:(id)sender {
    
    [self backToFeed];
}

- (void)backToFeed {
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *feedNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"FeedNavigationController"];
    myDelegate.window.rootViewController = feedNavigationController;
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
