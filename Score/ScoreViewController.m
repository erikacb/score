//
//  ScoreViewController.m
//  Score
//
//  Created by Erika Bueno on 4/1/16.
//  Copyright © 2016 ErikaBueno. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@property (strong, nonatomic) NSString *savedPoints;
@property (strong, nonatomic) NSString *savedPace;
@property int teamAPoints;
@property int teamBPoints;
@property int maximum;
@property (weak, nonatomic) IBOutlet UIButton *teamAButton;
@property (weak, nonatomic) IBOutlet UIButton *teamBButton;
@property (nonatomic, assign) BOOL hasFinished;


@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.teamAPoints = 0;
    
    self.teamBPoints = 0;
    
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    
    self.savedPoints = [config valueForKey:@"Points"];
    
    self.savedPace = [config valueForKey:@"Pace"];
    
    self.maximum = [self.savedPoints intValue];
    
    self.hasFinished = NO;
    

    
    [self.teamAButton setTitle: [NSString stringWithFormat:@"%d", self.teamAPoints] forState: UIControlStateNormal];
    
    [self.teamBButton setTitle: [NSString stringWithFormat:@"%d", self.teamBPoints] forState: UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {

    self.teamAPoints = 0;
    
    self.teamBPoints = 0;
    
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    
    self.savedPoints = [config valueForKey:@"Points"];
    
    self.savedPace = [config valueForKey:@"Pace"];
    
    self.maximum = [self.savedPoints intValue];
    
    self.hasFinished = NO;
    
    
    [self.teamAButton setTitle: [NSString stringWithFormat:@"%d", self.teamAPoints] forState: UIControlStateNormal];
    
    [self.teamBButton setTitle: [NSString stringWithFormat:@"%d", self.teamBPoints] forState: UIControlStateNormal];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)teamA:(id)sender {
    
    NSLog(@"Team A scored");
    self.teamAPoints++;
    NSLog(@"%i", self.teamAPoints);
    [self.teamAButton setTitle: [NSString stringWithFormat:@"%d", self.teamAPoints] forState: UIControlStateNormal];
    self.hasFinished = [self finishedMatchWithMaximumOf:self.maximum checkingPointsA:self.teamAPoints andCheckingPointsB:self.teamBPoints];
    if (self.hasFinished == YES) {
        NSLog(@"Team A is the winner!");
        
        self.teamAButton.enabled = NO;
       
        self.teamBButton.enabled = NO;
        
    }
    
    
}

- (IBAction)teamB:(id)sender {
    
    NSLog(@"Team B scored");
    self.teamBPoints++;
    NSLog(@"%i", self.teamBPoints);
    [self.teamBButton setTitle: [NSString stringWithFormat:@"%d", self.teamBPoints] forState: UIControlStateNormal];
    self.hasFinished = [self finishedMatchWithMaximumOf:self.maximum checkingPointsA:self.teamAPoints andCheckingPointsB:self.teamBPoints];
    if (self.hasFinished == YES) {

        NSLog(@"Team B is the winner!");
        
        self.teamAButton.enabled = NO;
       
        self.teamBButton.enabled = NO;
        
        
    }
    
}

- (IBAction)setConfig:(id)sender {
    [self performSegueWithIdentifier:@"setConfig" sender:self];
}

- (BOOL)finishedMatchWithMaximumOf:(int)maximum checkingPointsA:(int)pointsA andCheckingPointsB:(int)pointsB {

    if ((maximum == pointsA) || (maximum == pointsB)) {

        return YES;
    
    } else {
    
        return NO;
    
    }
    
}

- (IBAction)restartMatch:(id)sender {
    
    self.teamAButton.enabled = YES;
    
    self.teamBButton.enabled = YES;
    
    self.teamAPoints = 0;
    
    self.teamBPoints = 0;
    
        [self.teamAButton setTitle: [NSString stringWithFormat:@"%d", self.teamAPoints] forState: UIControlStateNormal];
    
        [self.teamBButton setTitle: [NSString stringWithFormat:@"%d", self.teamBPoints] forState: UIControlStateNormal];
    
    
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
