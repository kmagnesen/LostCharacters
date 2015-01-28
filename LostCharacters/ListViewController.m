//
//  ViewController.m
//  LostCharacters
//
//  Created by Kyle Magnesen on 1/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ListViewController.h"
#import "AppDelegate.h"
#import "Character.h"
#import "DetailViewController.h"
#import <CoreData/CoreData.h>

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property NSManagedObjectContext *moc;
@property (strong, nonatomic) NSArray *characters;
@property NSIndexPath *indexPath;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appDelegate.managedObjectContext;

    [self loadCharacters];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"dataImported"]) {
        [self populateCoreData];

        [defaults setObject:@"OK" forKey:@"dataImported"];
        [defaults synchronize];
    }
}

- (NSURL *)documentDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}

- (void) setCharacters:(NSArray *)characters {
    _characters = characters;
    [self.tableView reloadData];
}

- (void)loadCharacters {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Character"];
    NSSortDescriptor *actorSorter = [[NSSortDescriptor alloc] initWithKey:@"actor" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:actorSorter];
    self.characters = [self.moc executeFetchRequest:request error:nil];
}

#pragma mark ACTIONS

- (IBAction)addCharacter:(UIBarButtonItem *)sender {
    Character *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.moc];

    character.actor = self.textField.text;

    [self.moc save:nil];
    [self loadCharacters];
    self.textField.text = nil;
    [self resignFirstResponder];
}
- (IBAction)onEditButtonTapped:(UIBarButtonItem *)sender {
    if (self.tableView.editing)
    {
        self.editing = false;
        [self.tableView setEditing:NO animated:YES];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    } else {
        self.editing = true;
        [self.tableView setEditing:YES animated:YES];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
        [sender setTitle:@"Done"];
    }
}

#pragma mark EDIT FUNCTIONS

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//    Character *actor = [self.characters objectAtIndex:sourceIndexPath.row];
//    [self.characters removeObject:actor];
//    [self.characters insertObject:actor atIndex:destinationIndexPath.row];
//
//    [self.tableView reloadData];
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        self.indexPath = indexPath;

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hold Up!" message:@"Are you sure you want to delete this character?  This cannot be undone" delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)//OK button pressed
    {
//        [self.characters removeObserver:self.moc forKeyPath:self.characters.indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {

        [UIView transitionWithView:self.tableView
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^(void) {
                            [self.tableView reloadData];
                        } completion:NULL];
    }
    
}

#pragma mark POPULATE CORE DATA

- (void) populateCoreData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"lost" ofType:@"plist"];
    NSMutableArray *charactersFromPlist = [NSMutableArray arrayWithContentsOfFile:path];

    for (NSDictionary *dictionary in charactersFromPlist) {
        Character *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character"inManagedObjectContext:self.moc];
        character.actor = dictionary[@"actor"];
        character.passenger = dictionary[@"passenger"];
        character.gender = dictionary[@"gender"];
        character.age = dictionary[@"age"];
        character.seat = dictionary[@"seat"];
    }
    [self.moc save:nil];
}

#pragma mark TABLEVIEW DELEGATE AND DATASOURCE METHODS

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.characters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Character *character = [self.characters objectAtIndex:indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = character.actor;
    cell.detailTextLabel.text = character.passenger;

    return cell;
}

- (void)updateCharacter:(Character *)character atRow:(NSIndexPath *)indexPath{
//    [self.characters replaceObjectAtIndex:indexPath.row withObject:character];
    [self.tableView reloadData];
    self.title = character.actor;
//    self.subtitle = character.passenger;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
    Character *characterTapped = [self.characters objectAtIndexedSubscript:selectedIndexPath.row];

    DetailViewController *vc = segue.destinationViewController;
    [vc.characters isEqual: characterTapped];
    [vc.indexPath isEqual: selectedIndexPath];
}

- (IBAction)unwindFromDetailViewController:(UIStoryboardSegue *)segue {
    DetailViewController *vc = segue.sourceViewController;
    Character *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.moc];

//    character.actor = segue.text;
//    character.passenger = segue.text;
//    character.gender = segue.text;
    character.age = [NSNumber numberWithInt:(int) segue];
    character.seat = [NSNumber numberWithInt:(int) segue];

    [self.moc save:nil];
    [self loadCharacters];
}
@end
