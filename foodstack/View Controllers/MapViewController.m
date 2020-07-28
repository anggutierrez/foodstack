//
//  MapViewController.m
//  foodstack
//
//  Created by Angel Gutierrez on 7/28/20.
//  Copyright © 2020 Angel Gutierrez. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
															longitude:151.20
																 zoom:6];
	GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
	mapView.myLocationEnabled = YES;
	[self.view addSubview:mapView];

	// Creates a marker in the center of the map.
	GMSMarker *marker = [[GMSMarker alloc] init];
	marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
	marker.title = @"Sydney";
	marker.snippet = @"Australia";
	marker.map = mapView;
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
