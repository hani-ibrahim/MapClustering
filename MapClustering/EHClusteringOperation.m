//
//  EHClusteringOperation.m
//  MapClustering
//
//  Created by Hani Ibrahim on 28/1/14.
//  Copyright (c) 2014 Hani Ibrahim. All rights reserved.
//

#import "EHClusteringOperation.h"
#import "EHMapView.h"

#define GRID_STEP 50 /* px */
#define MAP_MARGIN 4.0 /* 4 means that the pins will be displayed over 1.25 of the map visible rect */

@interface EHClusteringOperation ()
@property (nonatomic, weak) EHMapView *mapView;
@end

@implementation EHClusteringOperation

#pragma mark - Initialization

- (instancetype)initWithMapView:(EHMapView *)mapView
{
	self = [super init];
	if (self) {
		self.mapView = mapView;
	}
	return self;
}


#pragma mark - Main Method

- (void)main
{
	@autoreleasepool {
		MKMapRect actualVisibleRect = [self.mapView visibleMapRect];
		MKMapRect visibleRect = MKMapRectInset(actualVisibleRect, -actualVisibleRect.size.width/MAP_MARGIN, -actualVisibleRect.size.height/MAP_MARGIN);
		NSMutableSet *newAnnotations = [NSMutableSet set];
		
		// Check if region is zoomed or not
		BOOL sameWidth = fabs(visibleRect.size.width - self.mapView.previousMapRect.size.width) < 1e-6;
		BOOL sameHeight = fabs(visibleRect.size.height - self.mapView.previousMapRect.size.height) < 1e-6;
		BOOL sameZoomLevel = sameWidth && sameHeight;
		if (sameZoomLevel) {
			// Display all the previously displayed annotation for the current region, If the zoom level is not changed
			NSSet *currentAnnotation = [self.mapView annotationsInMapRect:visibleRect];
			[newAnnotations unionSet:currentAnnotation];
		}
		
		// Divide the visibleRect into grids
		CGFloat xGridCount = self.mapView.frame.size.width / GRID_STEP;
		CGFloat yGridCount = self.mapView.frame.size.height / GRID_STEP;
		double xGridStepSize = visibleRect.size.width / xGridCount;
		double yGridStepSize = visibleRect.size.height / yGridCount;
		
		// Loop On each grid
		for (int xStep = 0; xStep < xGridCount; xStep++) {
			for (int yStep = 0; yStep < yGridCount; yStep++) {
				// Return if operatino is cancelled
				if ([self isCancelled]) {return;}
				
				// Get the Map Rect for the grid
				MKMapRect gridRect = MKMapRectMake(visibleRect.origin.x + xStep * xGridStepSize, visibleRect.origin.y + yStep * yGridStepSize, xGridStepSize, yGridStepSize);
				
				// Get Grid Annotations to be display
				// We will select only one Annotation to be displayed
				NSSet *gridAnnotations = [self.mapView getAllAnnotationsInRect:gridRect];
				
				// Display the annotation only if the grid rect is not displayed before at the same zoom level
				if (gridAnnotations.count > 0 && !(sameZoomLevel && MKMapRectIntersectsRect(self.mapView.previousMapRect, gridRect))) {
					[newAnnotations addObject:[gridAnnotations anyObject]];
				}
			}
		}
		
		// Get Current Annotations to remove
		NSMutableSet *currentAnnotations = [NSMutableSet setWithArray:self.mapView.annotations];
		[currentAnnotations minusSet:newAnnotations];
		
		// Add the Annotation to the map View
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.mapView removeAnnotations:[currentAnnotations allObjects]];
			[self.mapView addAnnotations:[newAnnotations allObjects]];
			self.mapView.previousMapRect = visibleRect;
		});
	}
}

@end
