// MAP intialization script
// ***************************
// there are 2 searchboxes added in the map, each one adds a marker only if the other one is not defined, if is defined the route is created
//

var directionsService = new google.maps.DirectionsService();
var directionsDisplay = new google.maps.DirectionsRenderer();
directionsDisplay.suppressMarkers = true;

handler = Gmaps.build('Google');
handler.buildMap({
	provider: {
		disableDefaultUI: true,
		center: new google.maps.LatLng(-33.4575978, -70.6428367)
	},
	internal: {
		id: 'map'
	}
});

directionsDisplay.setMap(handler.getMap());

/* setting initial route */
//var origin = new google.maps.LatLng( <%= @delivery.lat_start %>,  <%= @delivery.long_start %>);
//var destination = new google.maps.LatLng(<%= @delivery.lat_finish %>,  <%= @delivery.long_finish %>);
var request = {
	origin: origin,
	destination: destination,
	travelMode: google.maps.DirectionsTravelMode.WALKING
};

directionsService.route(request, function(response, status) {
//Check if request is successful.
    if (status == google.maps.DirectionsStatus.OK) {
        console.log(status);
        directionsDisplay.setDirections(response); //Display the directions result
    }


// Create the search box and link it to the UI element.
    var input = (document.getElementById('route-start'));
    var input2 = (document.getElementById('route-end'));

    /* creating searchboxes */
    var options = {
        componentRestrictions: {country: "cl"}
    };

    var searchBox = new google.maps.places.Autocomplete(input, options);
    var searchBox2 = new google.maps.places.Autocomplete(input2, options);

    /* creating markers */
    var originMarker;
    var destinationMarker;

    /* routeOn is a boolean to indicate wether the route has been made before or not */
    var routeOn = false;
});

/* origin searchbox listener */
google.maps.event.addListener(searchBox, 'place_changed', function() {
	var place = searchBox.getPlace();

	var destinationLat = $('#finish-lat').val();
	var destinationLng = $('#finish-lng').val();

	/* if theres is a destination marker or there has been a route made */
	if ((destinationMarker && destinationLat && destinationLng) || (routeOn && destinationLat && destinationLng)){
		console.log('making route with the new origin');

		/* removing origin marker */
		if(originMarker){
			originMarker.isAdded=false;
		}

		/* reseting map directions */
		directionsDisplay.setMap(null);
		directionsDisplay.setMap(handler.getMap());

		/* getting origin */
		var origin = "";
		var origin = new google.maps.LatLng( place.geometry.location.G,  place.geometry.location.K);

		/* setting destination */
		var destination = new google.maps.LatLng(destinationLat,  destinationLng);

		var request = {
			origin: origin,
			destination: destination,
			travelMode: google.maps.DirectionsTravelMode.WALKING
		};


        directionsService.route(request, function(response, status) {
            if (status == google.maps.DirectionsStatus.OK) {
                $('#km ').val( parseFloat(response.routes[0].legs[0].distance.value/1000).toFixed(1));
                $('#eta ').val(parseInt(response.routes[0].legs[0].duration.value/60/4));
                directionsDisplay.setDirections(response); //Display the directions result
            }
        });

		/* setting corresponding form values */
		$('#start-lat').val(place.geometry.location.G);
		$('#start-lng').val(place.geometry.location.K);
		$('#comuna-start').val(place.address_components[3].short_name);
		routeOn = true;
	}
	else{
		console.log('creating origin');
		/* if theres no destination marker created  */
		originMarker = handler.addMarkers([
			{
				"lat": place.geometry.location.G,
				"lng": place.geometry.location.K
			}
		]);

		handler.bounds.extendWith(originMarker);
		handler.fitMapToBounds();

		/* setting corresponding form values */
		$('#start-lat').val(place.geometry.location.G);
		$('#start-lng').val(place.geometry.location.K);
		$('#comuna-start').val(place.address_components[3].short_name);
	}

});


/* destination searchbox listener */
google.maps.event.addListener(searchBox2, 'place_changed', function() {
	var place = searchBox2.getPlace();

	var startLat = $('#start-lat').val();
	var startLng = $('#start-lng').val();
	if ((originMarker && startLat && startLng) || (routeOn && startLat && startLng)){
		console.log('making route with the new destination');

		/* removing destination marker */
		if(destinationMarker){
			destinationMarker.isAdded=false;
		}
		/* reseting map directions */
		directionsDisplay.setMap(null);
		directionsDisplay.setMap(handler.getMap());

		/* getting destination */
		var destination = "";
		var destination = new google.maps.LatLng( place.geometry.location.G,  place.geometry.location.K);

		/* setting origin */
		var origin = new google.maps.LatLng(startLat,startLng);

		var request = {
			origin: origin,
			destination: destination,
			travelMode: google.maps.DirectionsTravelMode.WALKING
		};

		directionsService.route(request, function(response, status) {
		    if (status == google.maps.DirectionsStatus.OK) {
		    	console.log(response);
                $('#km ').val( parseFloat(response.routes[0].legs[0].distance.value/1000).toFixed(1));
                $('#eta ').val(parseInt(response.routes[0].legs[0].duration.value/60/4));
			    directionsDisplay.setDirections(response); //Display the directions result
			}
		});

		$('#finish-lat').val(place.geometry.location.G);
		$('#finish-lng').val(place.geometry.location.K);
		$('#comuna-finish').val(place.address_components[3].short_name);
		routeOn = true;
	}
	else{

		console.log('creating destinations');
		destinationMarker = handler.addMarkers([
		{
			"lat": place.geometry.location.G,
			"lng": place.geometry.location.K
		}
		]);
		handler.bounds.extendWith(destinationMarker);
		handler.fitMapToBounds();
		$('#finish-lat').val(place.geometry.location.G);
		$('#finish-lng').val(place.geometry.location.K);
		$('#comuna-finish').val(place.address_components[3].short_name);
	}


});


$("form").on("keypress", function (e) {
	if (e.keyCode == 13) {
		return false;
	}
});
