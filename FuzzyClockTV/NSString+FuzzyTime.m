//
//  NSString+FuzzyTime.m
//  FuzzyClockTV
//
//  Created by Andre Hess on 29.10.15.
//  Copyright © 2015 Andre Hess. All rights reserved.
//

#import "NSString+FuzzyTime.h"

@implementation NSString (FuzzyTime)

- (id)initWithFuzzyDate:(NSDate *)date {
	self = [self init];
	if (self != nil) {
		NSString *stringValue = [self getTimeAsString:date];
		NSInteger hours = [self getHoursFromTimeAsString:stringValue];
		NSInteger minutes = [self getMinutesFromTimeAsString:stringValue];
		
		BOOL incrementHours = NO;
		BOOL swapTexts = NO;
		NSString *minutesFuzzy = [self getMinutesFuzzyStringFromMinutes:minutes incrementHours:&incrementHours swapTexts:&swapTexts];
		if (incrementHours) {
			hours++;
		}
		NSString *hoursFuzzy = [self getHoursFuzzyStringFromHours:hours];
		return [NSString stringWithFormat:@"%@%@", swapTexts ? hoursFuzzy : minutesFuzzy, swapTexts ? minutesFuzzy : hoursFuzzy]; 
	}
	return self;
}

- (NSString *)getTimeAsString:(NSDate *)date {
	NSDateFormatter *formatter = [NSDateFormatter new];
	formatter.timeStyle = NSDateFormatterMediumStyle;
	formatter.locale = [NSLocale localeWithLocaleIdentifier:@"de_DE"];
	return [formatter stringFromDate:date];
}

- (NSInteger)getHoursFromTimeAsString:(NSString *)timeString {
	NSArray *components = [timeString componentsSeparatedByString:@":"];
	NSString *hoursStringValue = components[0];
	
	return hoursStringValue.intValue;
}

- (NSInteger)getMinutesFromTimeAsString:(NSString *)timeString {
	NSArray *components = [timeString componentsSeparatedByString:@":"];
	NSString *minutesStringValue = components[1];
	
	return minutesStringValue.intValue;
}

- (NSString *)getMinutesFuzzyStringFromMinutes:(NSInteger)minutes incrementHours:(BOOL*)incHours swapTexts:(BOOL*)swapTexts {
	NSString *minutesFuzzy = @"";
	*incHours = [self shouldIncrementHours:minutes];
	*swapTexts = [self shouldSwapTextsAtMinutes:minutes];
	
	if (minutes == 0) {
		minutesFuzzy = NSLocalizedString(@"at", @"");
	}
	else if ((minutes > 0) && (minutes <= 3)) {
		minutesFuzzy = NSLocalizedString(@"short after", @"");
	}
	else if ((minutes > 3) && (minutes <= 7)) {
		minutesFuzzy = NSLocalizedString(@"five after", @"");
	}
	else if ((minutes > 7) && (minutes <= 13)) {
		minutesFuzzy = NSLocalizedString(@"ten after", @"");
	}
	else if ((minutes > 13) && (minutes <= 18)) {
		minutesFuzzy = NSLocalizedString(@"fivteen after", @"");
	}
	else if ((minutes > 18) && (minutes <= 23)) {
		minutesFuzzy = NSLocalizedString(@"twenty after", @"");
	}
	else if ((minutes > 23) && (minutes <= 28)) {
		minutesFuzzy = NSLocalizedString(@"twenty five after", @"");
	}
	else if ((minutes > 28) && (minutes <= 33)) {
		minutesFuzzy = NSLocalizedString(@"half", @"");
	}
	else if ((minutes > 33) && (minutes <= 38)) {
		minutesFuzzy = NSLocalizedString(@"twenty five before", @"");
	}
	else if ((minutes > 38) && (minutes <= 43)) {
		minutesFuzzy = NSLocalizedString(@"twenty before", @"");
	}
	else if ((minutes > 43) && (minutes <= 48)) {
		minutesFuzzy = NSLocalizedString(@"fiveteen before", @"");
	}
	else if ((minutes > 48) && (minutes <= 53)) {
		minutesFuzzy = NSLocalizedString(@"ten before", @"");
	}
	else if ((minutes > 53) && (minutes <= 58)) {
		minutesFuzzy = NSLocalizedString(@"five before", @"");
	}
	else if (minutes > 58) {
		minutesFuzzy = NSLocalizedString(@"short before", @"");
	}
	
	return minutesFuzzy;
}

- (NSString *)getHoursFuzzyStringFromHours:(NSInteger)hours {
	NSString *hoursFuzzy = @"";	
	switch (hours) {
		case 1:
		case 13:
			hoursFuzzy = NSLocalizedString(@"1", @"");
			break;
		case 2:
		case 14:
			hoursFuzzy = NSLocalizedString(@"2", @"");
			break;
		case 3:
		case 15:
			hoursFuzzy = NSLocalizedString(@"3", @"");
			break;
		case 4:
		case 16:
			hoursFuzzy = NSLocalizedString(@"4", @"");
			break;
		case 5:
		case 17:
			hoursFuzzy = NSLocalizedString(@"5", @"");
			break;
		case 6:
		case 18:
			hoursFuzzy = NSLocalizedString(@"6", @"");
			break;
		case 7:
		case 19:
			hoursFuzzy = NSLocalizedString(@"7", @"");
			break;
		case 8:
		case 20:
			hoursFuzzy = NSLocalizedString(@"8", @"");
			break;
		case 9:
		case 21:
			hoursFuzzy = NSLocalizedString(@"9", @"");
			break;
		case 10:
		case 22:
			hoursFuzzy = NSLocalizedString(@"10", @"");
			break;
		case 11:
		case 23:
			hoursFuzzy = NSLocalizedString(@"11", @"");
			break;
		default:
			hoursFuzzy = NSLocalizedString(@"12", @"");
	}
	return hoursFuzzy;	
}

- (BOOL)shouldIncrementHours:(NSInteger)minutesIntValue {
	NSLocale *currentLocale = [NSLocale currentLocale];
	NSString *currentLocaleIdentifier = currentLocale.localeIdentifier;
	if ([currentLocaleIdentifier isEqualToString:@"en_US"]) {
		return minutesIntValue > 33;
	}
	else if ([currentLocaleIdentifier isEqualToString:@"de_DE"]) {
		return minutesIntValue >= 15;
	}
	return false;
}

- (BOOL)shouldSwapTextsAtMinutes:(NSInteger)minutesIntValue {
	NSLocale *currentLocale = [NSLocale currentLocale];
	NSString *currentLocaleIdentifier = currentLocale.localeIdentifier;
	if ([currentLocaleIdentifier isEqualToString:@"en_US"]) {
		return minutesIntValue == 0;
	}
	return false;
}

@end
