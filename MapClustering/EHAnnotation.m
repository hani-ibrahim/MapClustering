//
//  EHAnnotation.m
//  MapClustering
//
//  Created by Hani Ibrahim on 28/1/14.
//  Copyright (c) 2014 Hani Ibrahim. All rights reserved.
//

#import "EHAnnotation.h"

@implementation EHAnnotation

- (instancetype)initWithTitle:(NSString *)title atLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude
{
	self = [super init];
	if (self) {
		_title = title;
		_coordinate = CLLocationCoordinate2DMake(latitude, longitude);
	}
	return self;
}

@end
