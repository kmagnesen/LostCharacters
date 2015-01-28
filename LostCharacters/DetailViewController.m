//
//  CharacterViewController.m
//  LostCharacters
//
//  Created by Kyle Magnesen on 1/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "Character.h"
#import <UIKit/UIKit.h>

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *updateCharacterDataButton;



@property NSManagedObjectContext *moc;
//@property (nonatomic) NSArray *characters;
//@property NSIndexPath *indexPath;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appDelegate.managedObjectContext;

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

    [self loadCharacters];

}

- (NSURL *)documentDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}

- (void) setCharacters:(NSArray *)characters {
    _characters = characters;
    [self.actorLabel reloadInputViews];
    [self.passengerLabel reloadInputViews];
    [self.genderLabel reloadInputViews];
    [self.ageLabel reloadInputViews];
    [self.seatLabel reloadInputViews];
}

- (void)loadCharacters {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Character"];
    self.characters = [self.moc executeFetchRequest:request error:nil];
}

- (IBAction)onUpdateCharacterButtonTapped:(UIButton *)sender {
    Character *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.moc];

    character.actor = self.actorLabel.text;
    character.passenger = self.passengerLabel.text;
    character.gender = self.genderLabel.text;
    [character.age.stringValue isEqualToString:self.ageLabel.text ];
    [character.seat.stringValue isEqualToString:self.seatLabel.text];

    [self.moc save:nil];
    [self loadCharacters];
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

        self.changeActorTextField.text = self.actorLabel.text;
        self.changePassengerTextField.text = self.passengerLabel.text;
        self.changeGenderTextField.text = self.genderLabel.text;
        [self.changeAgeTextField.text isEqualToString:self.ageLabel.text];
        [self.changeSeatTextField.text isEqualToString:self.seatLabel.text];

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
//
//        self.actorLabel = self.actorLabel.text;
//        self.character.passenger = self.passengerLabel.text;
//        self.character.gender = self.genderLabel.text;
//        [self.character.age.stringValue isEqualToString: self.ageLabel.text];
//        [self.character.seat.stringValue isEqualToString: self.seatLabel.text];

    }
}

@end
