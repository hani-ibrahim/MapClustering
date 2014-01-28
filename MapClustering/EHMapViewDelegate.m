//
//  EHMapViewDelegate.m
//  MapClustering
//
//  Created by Hani Ibrahim on 28/1/14.
//  Copyright (c) 2014 Hani Ibrahim. All rights reserved.
//

#import "EHMapViewDelegate.h"
#import "EHMapView.h"

@interface EHMapViewDelegate ()
@property (nonatomic, weak) EHMapView *mapView;
@end

@implementation EHMapViewDelegate

#pragma mark - Initialization

- (instancetype)initWithMapView:(EHMapView *)mapView
{
	self = [super init];
	if (self) {
		self.mapView = mapView;
	}
	return self;
}


#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	if ([self.mapView.originalDelegate respondsToSelector:@selector(mapView:regionDidChangeAnimated:)]) {
		[self.mapView.originalDelegate mapView:mapView regionDidChangeAnimated:animated];
	}
	
	[self.mapView layoutAnnotations];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation
{
	MKAnnotationView *view = [self.mapView.originalDelegate mapView:mapView viewForAnnotation:annotation];
	view.alpha = 0;
	return view;
}

- (void)mapView:(MKMapView *)mapView  didAddAnnotationViews:(NSArray *)views
{
	if ([self.mapView.originalDelegate respondsToSelector:@selector(mapView:didAddAnnotationViews:)]) {
		[self.mapView.originalDelegate mapView:mapView didAddAnnotationViews:views];
	}
	
	[UIView animateWithDuration:0.5 animations:^{
		for (MKAnnotationView *view in views) {
			view.alpha = 1;
		}
	}];
}

@end
