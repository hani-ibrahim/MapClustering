//
//  EHViewController.m
//  MapClustering
//
//  Created by Hani Ibrahim on 28/1/14.
//  Copyright (c) 2014 Hani Ibrahim. All rights reserved.
//

#import "EHViewController.h"
#import "EHMapView.h"
#import "EHAnnotation.h"

#define DISPLAY_RANDOM_PINS NO

@interface EHViewController ()

@property (nonatomic, strong) IBOutlet EHMapView *mapView;

@end

@implementation EHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(37.33235805463153, -122.02995300292969);
	
	NSMutableArray *pins = [NSMutableArray array];
	if (DISPLAY_RANDOM_PINS) {
		for (int i=0; i<100000; i++) {
			EHAnnotation *annotation = [[EHAnnotation alloc] initWithTitle:[NSString stringWithFormat:@"Pin: %d",i] atLatitude:coordinate.latitude + (((arc4random()%RAND_MAX)/(RAND_MAX*1.0))*4-2) andLongitude:coordinate.longitude + (((arc4random()%RAND_MAX)/(RAND_MAX*1.0))*4-2)];
			[pins addObject:annotation];
		}
	} else {
		for (int i=0; i<500; i++) {
			for (int j=0; j<500; j++) {
				EHAnnotation *annotation = [[EHAnnotation alloc] initWithTitle:[NSString stringWithFormat:@"Pin: %d-%d",i,j] atLatitude:coordinate.latitude + (i * 4/500.0-2) andLongitude:coordinate.longitude + (j * 4/500.0-2)];
				[pins addObject:annotation];
			}
		}
	}
	
	[self.mapView addEHAnnotations:pins];
	MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(7, 7));
	[self.mapView setRegion:region animated:YES];
}


#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	static NSString *viewIdentifier = @"annotationView";
	MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:viewIdentifier];
	if (pinView == nil) {
		pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:viewIdentifier];
	}
	pinView.canShowCallout = YES;
	pinView.pinColor = MKPinAnnotationColorRed;
	
	return pinView;
}

@end
