//
//  CharacterViewController.h
//  LostCharacters
//
//  Created by Kyle Magnesen on 1/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) NSArray *characters;
@property NSIndexPath *indexPath;

@property (strong, nonatomic) IBOutlet UILabel *actorLabel;
@property (strong, nonatomic) IBOutlet UILabel *passengerLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *seatLabel;


@property (strong, nonatomic) IBOutlet UITextField *changeActorTextField;
@property (strong, nonatomic) IBOutlet UITextField *changePassengerTextField;
@property (strong, nonatomic) IBOutlet UITextField *changeGenderTextField;
@property (strong, nonatomic) IBOutlet UITextField *changeAgeTextField;
@property (strong, nonatomic) IBOutlet UITextField *changeSeatTextField;

@end
