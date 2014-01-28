//
//  EHMapView.h
//  MapClustering
//
//  Created by Hani Ibrahim on 28/1/14.
//  Copyright (c) 2014 Hani Ibrahim. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface EHMapView : MKMapView

@property (nonatomic, assign) MKMapRect previousMapRect;
@property (nonatomic, weak) id <MKMapViewDelegate> originalDelegate;

// Annotations Methods
// Use these methods instead of the MKMapView methods
- (void)addEHAnnotation:(id<MKAnnotation>)annotation;
- (void)addEHAnnotations:(NSArray *)annotations;
- (void)removeEHAnnotation:(id<MKAnnotation>)annotation;
- (void)removeEHAnnotations:(NSArray *)annotations;

// Cluster the annotations
// This is methods is automatically called when an annotation is added or removed
- (void)layoutAnnotations;

// Get all the annotation that is supposed to be displayed in the given rect
// This method is used by EHClusteringOperation
- (NSSet *)getAllAnnotationsInRect:(MKMapRect)rect;

@end
