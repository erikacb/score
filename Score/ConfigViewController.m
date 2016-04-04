//
//  ConfigViewController.m
//  Score
//
//  Created by Erika Bueno on 4/1/16.
//  Copyright © 2016 ErikaBueno. All rights reserved.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()

@property (weak, nonatomic) IBOutlet UITextField *pointsTextField;
@property (weak, nonatomic) IBOutlet UITextField *paceTextField;

@end

@implementation ConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pointsTextField.delegate = self;
    
    self.paceTextField.delegate = self;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    
    self.pointsTextField.text = [config valueForKey:@"Points"];
    
    self.paceTextField.text = [config valueForKey:@"Pace"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveConfig:(id)sender {
    
    if ([self.pointsTextField.text isEqual:@" "] || [self.paceTextField.text isEqual:@" "] || [self.pointsTextField.text isEqual:@""] || [self.paceTextField.text isEqual:@""] ) {
        
        [self emptyField];
        
    }  else {
        
        if ([self.paceTextField.text intValue] > [self.pointsTextField.text intValue]) {
            
            [self paceBiggerThanPoints];
            
        } else {
            
            NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
            
            [config setValue:self.pointsTextField.text forKey:@"Points"];
            
            [config setValue:self.paceTextField.text forKey:@"Pace"];
            
            [config synchronize];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
            
        }
        
        
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)hideKeyBoard {
    [self.pointsTextField resignFirstResponder];
    [self.paceTextField resignFirstResponder];
}

- (void) emptyField {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No empty fields, please!"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                           
                                                       }];
    
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void) paceBiggerThanPoints {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Pace is bigger than maximum points!"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                           
                                                       }];
    
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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
