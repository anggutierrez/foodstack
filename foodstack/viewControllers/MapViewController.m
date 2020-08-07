//
//  MapViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/28/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "EntryCell.h"
#import "ApplicationScheme.h"
#import "TimelineViewController.h"
#import "Utils.h"


@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	double latitude = _entry.entryLatitude.doubleValue;
	double longitude = _entry.entryLongitude.doubleValue;
	
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
															longitude:longitude
																 zoom:9];
	GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
	
	// Set back to Yes if I want the location dot
	mapView.myLocationEnabled = NO;
	mapView.settings.myLocationButton = NO;
	
	[self.view addSubview:mapView];

	// Creates a marker in the center of the map.
	GMSMarker *marker = [[GMSMarker alloc] init];
	marker.position = CLLocationCoordinate2DMake(latitude, longitude);
	marker.title = @"Ate here!";
	marker.snippet = @"Lasagna";
	marker.map = mapView;
}

- (IBAction)didTapBack:(id)sender {
	[self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
