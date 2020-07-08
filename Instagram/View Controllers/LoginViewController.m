//
//  ViewController.m
//  Instagram
//
//  Created by Julie Herrick on 7/6/20.
//  Copyright © 2020 Julie Herrick. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onLogin:(id)sender {
    [self loginUser];
}

- (IBAction)onSignup:(id)sender {
    [self registerUser];
}


- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
//    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    
    [self checkFieldEmpty];
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        // enforces that the username isn't already taken
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            [self alertError:error.localizedDescription];
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            [self alertError:error.localizedDescription];
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)checkFieldEmpty {
    
    if ([self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Username or Password field is empty" preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // closes to let the user fill the fields
        }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    }
}

- (void)alertError:(NSString *)errorMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:(UIAlertControllerStyleAlert)];
    
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // closes to let the user fill the fields
    }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
}



@end
