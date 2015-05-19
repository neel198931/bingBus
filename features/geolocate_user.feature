Feature: User is geolocated via IP or GPS
	As a user not wanting to type my location in,
	turn on my gps so that the app will be able to locate me on its own
	and use my location as my starting point.

	Scenario: User opens the app and wants to be geolocated
		Given I go to the welcome page
		And I fill press "Find me!"
		Then my location should be filled in
