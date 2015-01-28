//
//  CharacterViewController.m
//  LostCharacters
//
//  Created by Kyle Magnesen on 1/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "DetailViewController.h"
#import "ListViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *updateCharacterDataButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self.changeActorTextField setEnabled:NO];
    self.changeActorTextField.alpha = 0;

    [self.changePassengerTextField setEnabled:NO];
    self.changePassengerTextField.alpha = 0;

    [self.changeGenderTextField setEnabled:NO];
    self.changeGenderTextField.alpha = 0;

    [self.changeAgeTextField setEnabled:NO];
    self.changeAgeTextField.alpha = 0;

    [self.changeSeatTextField setEnabled:NO];
    self.changeSeatTextField.alpha = 0;

    self.actorLabel.text = self.character.actor;
    self.passengerLabel.text = self.character.passenger;
    self.genderLabel.text = self.character.gender;
    self.ageLabel.text = self.character.age.stringValue;
    self.seatLabel.text = self.character.seat.stringValue;
}

- (IBAction)onUpdateCharacterButtonTapped:(UIButton *)sender {
    Character *character = [[Character alloc] initWithActorName:self.actorLabel.text andPassengerName:self.passengerLabel.text andGender:self.genderLabel.text andAge:[NSNumber numberWithLong:(long)self.ageLabel.text.longLongValue] andSeatNumber:[NSNumber numberWithLong:(long)self.seatLabel.text.longLongValue]];
    [self.delegate updateCharacter:character atRow:self.indexPath];
}

- (void)setEditing:(BOOL)flag animated:(BOOL)animated
{
    [super setEditing:flag animated:animated];

    if (flag == YES){

        [self.changeActorTextField setEnabled:YES];
        [self.changePassengerTextField setEnabled:YES];
        [self.changeGenderTextField setEnabled:YES];
        [self.changeAgeTextField setEnabled:YES];
        [self.changeSeatTextField setEnabled:YES];
        [self.updateCharacterDataButton setEnabled:NO];

        self.changeActorTextField.alpha = 1;
        self.changePassengerTextField.alpha = 1;
        self.changeGenderTextField.alpha = 1;
        self.changeAgeTextField.alpha = 1;
        self.changeSeatTextField.alpha = 1;

        self.actorLabel.alpha = 0;
        self.passengerLabel.alpha = 0;
        self.genderLabel.alpha = 0;
        self.ageLabel.alpha = 0;
        self.seatLabel.alpha = 0;
        self.updateCharacterDataButton.alpha = 0;

        self.changeActorTextField.text = self.character.actor;
        self.changePassengerTextField.text = self.character.passenger;
        self.changeGenderTextField.text = self.character.gender;
        self.changeAgeTextField.text = self.character.age.stringValue;
        self.changeSeatTextField.text = self.character.seat.stringValue;

    } else {

        [self.changeActorTextField setEnabled:NO];
        [self.changePassengerTextField setEnabled:NO];
        [self.changeGenderTextField setEnabled:NO];
        [self.changeAgeTextField setEnabled:NO];
        [self.changeSeatTextField setEnabled:NO];
        [self.updateCharacterDataButton setEnabled:YES];

        self.changeActorTextField.alpha = 0;
        self.changePassengerTextField.alpha = 0;
        self.changeGenderTextField.alpha = 0;
        self.changeAgeTextField.alpha = 0;
        self.changeSeatTextField.alpha = 0;


        self.actorLabel.alpha = 1;
        self.passengerLabel.alpha = 1;
        self.genderLabel.alpha = 1;
        self.ageLabel.alpha = 1;
        self.seatLabel.alpha = 1;
        self.updateCharacterDataButton.alpha = 1;


        self.actorLabel.text = self.changeActorTextField.text;
        self.passengerLabel.text = self.changePassengerTextField.text;
        self.genderLabel.text = self.changeGenderTextField.text;
        self.ageLabel.text = self.changeAgeTextField.text;
        self.seatLabel.text = self.changeSeatTextField.text;

        [self.changeActorTextField resignFirstResponder];
        [self.changePassengerTextField resignFirstResponder];
        [self.changeGenderTextField resignFirstResponder];
        [self.changeAgeTextField resignFirstResponder];
        [self.changeSeatTextField resignFirstResponder];

        self.character.actor = self.actorLabel.text;
        self.character.passenger = self.passengerLabel.text;
        self.character.gender = self.genderLabel.text;
        [self.character.age.stringValue isEqualToString: self.ageLabel.text];
        [self.character.seat.stringValue isEqualToString: self.seatLabel.text];

    }
}

@end
