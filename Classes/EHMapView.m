//
//  EHMapView.m
//  MapClustering
//
//  Created by Hani Ibrahim on 28/1/14.
//  Copyright (c) 2014 Hani Ibrahim. All rights reserved.
//

#import "EHMapView.h"
#import "EHMapViewDelegate.h"
#import "EHClusteringOperation.h"

@interface EHMapView ()
@property (nonatomic, strong) MKMapView *allAnnotationsMapView;
@property (nonatomic, strong) EHMapViewDelegate *mapDelegate;
@property (nonatomic, strong) EHClusteringOperation	*operation;
@end

@implementation EHMapView

#pragma mark - Initialization

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self initialize];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self initialize];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self initialize];
	}
	return self;
}

- (void)initialize
{
	// Set map delegate
	self.mapDelegate = [[EHMapViewDelegate alloc] initWithMapView:self];
	
	// Calling super as we are overriding the setting method
	[super setDelegate:self.mapDelegate];
	
	// Set All Annotations Map View
	self.allAnnotationsMapView = [[MKMapView alloc] init];
}


#pragma mark - Layout Annotations

- (void)layoutAnnotations
{
	[self.operation cancel];
	self.operation = [[EHClusteringOperation alloc] initWithMapView:self];
	[self.operation performSelectorInBackground:@selector(start) withObject:nil];
}


#pragma mark - Get All Annotations In Rect

- (NSSet *)getAllAnnotationsInRect:(MKMapRect)rect
{
	return [self.allAnnotationsMapView annotationsInMapRect:rect];
}


#pragma mark - Overriding Delegate Settings

- (void)setDelegate:(id<MKMapViewDelegate>)delegate
{
	self.originalDelegate = delegate;
}


#pragma mark - Annotation Methods

- (void)addEHAnnotation:(id<MKAnnotation>)annotation
{
	[self.allAnnotationsMapView addAnnotation:annotation];
	[self layoutAnnotations];
}

- (void)addEHAnnotations:(NSArray *)annotations
{
	[self.allAnnotationsMapView addAnnotations:annotations];
	[self layoutAnnotations];
}

- (void)removeEHAnnotation:(id<MKAnnotation>)annotation
{
	[self.allAnnotationsMapView removeAnnotation:annotation];
	[self layoutAnnotations];
}

- (void)removeEHAnnotations:(NSArray *)annotations
{
	[self.allAnnotationsMapView removeAnnotations:annotations];
	[self layoutAnnotations];
}

@end