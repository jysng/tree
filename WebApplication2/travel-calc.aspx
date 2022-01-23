<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="travel-calc.aspx.cs" Inherits="WebApplication2.travel_calc" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.tailwindcss.com"></script>
    <title>travel planner</title>
    <script type="text/javascript" id="tailwind">
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        clifford: '#da373d',
                    }
                }
            }
        }
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places&key=AIzaSyBfJVPs5D4KEuB8CWVIN1V81w-_yOhd23c"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script>
        var searchInputOrigin = 'origin';
        var searchInputDestination = 'destination';
        var apikey = "AIzaSyBfJVPs5D4KEuB8CWVIN1V81w-_yOhd23c";
        var comma = "%2C";
       // var axios = require('axios');
        function getDistanceFromLatLong(origin_lat, origin_long, dest_lat, dest_long) {
            const matrix = new google.maps.DistanceMatrixService();

            matrix.getDistanceMatrix({
                origins: [new google.maps.LatLng(origin_lat,origin_long)],
                destinations: [new google.maps.LatLng(dest_lat,dest_long)],
                travelMode: google.maps.TravelMode.DRIVING,
            }, function (response, status) {
                document.getElementById("tktt").value = Math.round(response.rows[0].elements[0].distance.value / 1000);
            });
        }


        $(document).ready(function () {
            var autocompleteOrigin;
            autocompleteOrigin = new google.maps.places.Autocomplete((document.getElementById(searchInputOrigin)), {
                types: ['geocode'],
            });

            google.maps.event.addListener(autocompleteOrigin, 'place_changed', function () {
                var near_place = autocompleteOrigin.getPlace();
                document.getElementById('lat_origin').innerHTML = near_place.geometry.location.lat();
                document.getElementById('long_origin').innerHTML= near_place.geometry.location.lng();

                //document.getElementById('latitude_view').innerHTML = near_place.geometry.location.lat();
                //document.getElementById('longitude_view').innerHTML = near_place.geometry.location.lng();
            });


            var autocompleteDestination;
            autocompleteDestination = new google.maps.places.Autocomplete((document.getElementById(searchInputDestination)), {
                types: ['geocode'],
            });

            google.maps.event.addListener(autocompleteDestination, 'place_changed', function () {
                var near_place = autocompleteDestination.getPlace();
                document.getElementById('lat_dest').innerHTML = near_place.geometry.location.lat();
                document.getElementById('long_dest').innerHTML = near_place.geometry.location.lng();

                //document.getElementById('latitude_view').innerHTML = near_place.geometry.location.lat();
                //document.getElementById('longitude_view').innerHTML = near_place.geometry.location.lng();
            });


            document.getElementById(searchInputDestination).addEventListener("blur", function () {
                if (document.getElementById('lat_dest').innerHTML != "" && document.getElementById('lat_origin').innerHTML != "") {
                    origin_lat = document.getElementById('lat_origin').innerHTML;
                    origin_long = document.getElementById('long_origin').innerHTML;
                    dest_lat = document.getElementById('lat_dest').innerHTML;
                    dest_long = document.getElementById('long_dest').innerHTML;
                    getDistanceFromLatLong(origin_lat, origin_long, dest_lat, dest_long);
                }
            })
        });

        

    </script>
</head>

<body>
    <input type="hidden" id="loc_lat" />
    <input type="hidden" id="loc_long" />
    <div class="container mx-auto">
        <div class="max-w-xl p-5 mx-auto my-10 bg-white rounded-md shadow-sm">
            <div class="text-center">
                <h1 class="my-3 text-3xl font-semibold text-gray-700">travel expense planner</h1>
                <p class="text-gray-400">fill all the details to calculate.</p>
            </div>
            <div>
                <form runat="server">
                    <div class="mb-6">
                        <label for="origin" class="block mb-2 text-sm text-gray-600">
                            origin</label>
                        <input 
                            type="text" runat="server"
                            name="origin"
                            id="origin"
                            placeholder="lucknow"
                            required
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300" />
                        <span id="lat_origin"></span>
                        <span id="long_origin"></span>
                    </div>
                    <div class="mb-6">
                        <label for="destination" class="block mb-2 text-sm text-gray-600">
                            destination</label>
                        <input
                            type="text" runat="server"
                            name="destination"
                            id="destination"
                            placeholder="spiti"
                            required
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300" />
                        <span id="lat_dest"></span>
                        <span id="long_dest"></span>
                    </div>

                    <div class="mb-6">
                        <label for="tktt" class="text-sm text-gray-600">total km to travel</label>
                        <input
                            type="number"
                            runat="server"
                            name="tktt"
                            id="tktt"
                            placeholder="1000"
                            required
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300" />
                    </div>

                    <div class="mb-6">
                        <label for="nod" class="text-sm text-gray-600">no. of days</label>
                        <input
                            type="number"
                            runat="server"
                            name="nod"
                            id="nod"
                            placeholder="9"
                            required
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300" />
                    </div>
                    <div class="mb-6">
                        <label for="nop" class="text-sm text-gray-600">no. of persons</label>
                        <input
                            type="number"
                            runat="server"
                            name="nop"
                            id="nop"
                            placeholder="5"
                            required
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300" />
                    </div>
                    <div class="mb-6">
                        <label for="vehicle-mileage" class="text-sm text-gray-600">vehicle mileage (km/lt)</label>
                        <input
                            type="number"
                            runat="server"
                            name="vehicle-mileage"
                            id="vehicle_mileage"
                            placeholder="30"
                            required
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300" />
                    </div>
                    <div class="mb-6">
                        <label for="adfe" class="text-sm text-gray-600">average daily fooding expenditure (INR)</label>
                        <input
                            type="number"
                            runat="server"
                            name="adfe"
                            id="adfe"
                            placeholder="1000"
                            required
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300" />
                    </div>
                    <div class="mb-6">
                        <label for="adle" class="text-sm text-gray-600">average daily logging expenditure (INR)</label>
                        <input
                            type="number"
                            runat="server"
                            name="adle"
                            id="adle"
                            placeholder="1000"
                            required
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300" />
                    </div>
                    
                    <%--<div class="mb-6">
                        <label for="message" class="block mb-2 text-sm text-gray-600">
                            Your Message</label>

                        <textarea
                            rows="5"
                            name="message"
                            placeholder="Your Message"
                            class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md  focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300"
                            required></textarea>
                    </div>--%>
                    <div class="mb-6">
                        <asp:Button Text="estimate travel"
                            ID="btnSave" OnClick="btnSave_Click"
                            runat="server"
                            class="w-full px-2 py-4 text-white bg-indigo-500 rounded-md  focus:bg-indigo-600 focus:outline-none"></asp:Button>

                    </div>

                    <div class="w-full max-w-lg overflow-hidden rounded-lg shadow-lg sm:flex">
                        <div class="w-full sm:w-1/3">
                            <img class="object-cover w-full h-48" src="https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg?auto=compress&cs=tinysrgb&h=650&w=940" alt="Flower and sky" />
                        </div>
                        <div class="flex-1 px-6 py-4">
                            <h4 class="mb-3 text-xl font-semibold tracking-tight text-gray-800">Total Food Expenditure</h4>
                            <p class="leading-normal text-xl text-gray-700" id="pFood" runat="server"></p>
                        </div>
                    </div>

                    <div class="w-full max-w-lg overflow-hidden rounded-lg shadow-lg sm:flex">
                        <div class="w-full sm:w-1/3">
                            <img class="object-cover w-full h-48" src="https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg?auto=compress&cs=tinysrgb&h=650&w=940" alt="Flower and sky" />
                        </div>
                        <div class="flex-1 px-6 py-4">
                            <h4 class="mb-3 text-xl font-semibold tracking-tight text-gray-800">Total Transport Expenditure</h4>
                            <p class="leading-normal text-xl text-gray-700" id="pTransport" runat="server"></p>
                        </div>
                    </div>

                    <div class="w-full max-w-lg overflow-hidden rounded-lg shadow-lg sm:flex">
                        <div class="w-full sm:w-1/3">
                            <img class="object-cover w-full h-48" src="https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg?auto=compress&cs=tinysrgb&h=650&w=940" alt="Flower and sky" />
                        </div>
                        <div class="flex-1 px-6 py-4">
                            <h4 class="mb-3 text-xl font-semibold tracking-tight text-gray-800">Total Lodge Expenditure</h4>
                            <p class="leading-normal text-xl text-gray-700" id="pLodge" runat="server"></p>
                        </div>
                    </div>

                    <div class="w-full max-w-lg overflow-hidden rounded-lg shadow-lg sm:flex">
                        <div class="w-full sm:w-1/3">
                            <img class="object-cover w-full h-48" src="https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg?auto=compress&cs=tinysrgb&h=650&w=940" alt="Flower and sky" />
                        </div>
                        <div class="flex-1 px-6 py-4">
                            <h4 class="mb-3 text-xl font-semibold tracking-tight text-gray-800">Total Expenditure</h4>
                            <p class="leading-normal text-xl text-gray-700" id="pTotal" runat="server"></p>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
