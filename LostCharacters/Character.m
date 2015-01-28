//
//  Characters.m
//  LostCharacters
//
//  Created by Kyle Magnesen on 1/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "Character.h"


@implementation Character

@dynamic passenger;
@dynamic actor;
@dynamic seat;
@dynamic age;
@dynamic gender;

- (instancetype)initWithActorName:(NSString *)actor andPassengerName:(NSString *)passenger andGender:(NSString *)gender andAge:(NSNumber *)age andSeatNumber:(NSNumber *)seat{
    
    self = [super init];
    self.actor = actor;
    self.passenger = passenger;
    self.gender = gender;
    self.age = age;
    self.seat = seat;

    return self;
}

@end
