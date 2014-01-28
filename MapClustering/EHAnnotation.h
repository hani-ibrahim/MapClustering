//
//  EHAnnotation.h
//  MapClustering
//
//  Created by Hani Ibrahim on 28/1/14.
//  Copyright (c) 2014 Hani Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface EHAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (instancetype)initWithTitle:(NSString *)title atLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude;

@end
