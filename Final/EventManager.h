//
//  EventManager.h
//  Final
//
//  Created by DetroitLabs on 8/1/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
@import EventKit;

@interface EventManager : NSObject

@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic) BOOL eventsAccessGranted;
@property (nonatomic, strong) NSString *selectedCalendarIdentifier;
@property (nonatomic, strong) NSString *selectedEventIdentifier;

-(NSArray *)getLocalEventCalendars;

-(NSString *)getStringFromDate:(NSDate *)date;

-(NSArray *)getEventsOfSelectedCalendar;

-(void)saveCustomCalendarIdentifier:(NSString *)identifier;

-(BOOL)checkIfCalendarIsCustomWithIdentifier:(NSString *)identifier;

-(void)removeCalendarIdentifier:(NSString *)identifier;

-(void)deleteEventWithIdentifier:(NSString *)identifier;

@end
