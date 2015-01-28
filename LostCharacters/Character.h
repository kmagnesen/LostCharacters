//
//  Characters.h
//  LostCharacters
//
//  Created by Kyle Magnesen on 1/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Character : NSManagedObject <NSObject>

- (instancetype)initWithActorName:(NSString *)actor andPassengerName:(NSString *)passenger andGender:(NSString *)gender andAge:(NSNumber *)age andSeatNumber:(NSNumber *)seat;

@property (nonatomic, retain) NSString * passenger;
@property (nonatomic, retain) NSString * actor;
@property (nonatomic, retain) NSNumber * seat;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * gender;

@end
