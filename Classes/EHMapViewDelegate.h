//
//  EHMapViewDelegate.h
//  MapClustering
//
//  Created by Hani Ibrahim on 28/1/14.
//  Copyright (c) 2014 Hani Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class EHMapView;

@interface EHMapViewDelegate : NSObject <MKMapViewDelegate>

- (instancetype)initWithMapView:(EHMapView *)mapView;

@end
