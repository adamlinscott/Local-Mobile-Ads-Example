-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local widget = require( "widget" )
local json = require( "json" )


local w,h = display.contentWidth, display.contentHeight
local lat, long = 0,0
local acc = 0
display.setDefault( "background", 1, 1, 1 ) 
local onOffSwitch = {}
local checkboxButton = {}
local checkboxButton1 = {}
local checkboxButton2 = {}

-- Handle press events for the checkbox
local function onSwitchPress()
	local string = "This user is in "
	if(onOffSwitch.isOn) then
		string = string .. "Gernealised mode\t|| user likes " 
	else
		string = string .. "Directed mode\t|| user likes " 
	end


	local pref = 0
	if(checkboxButton.isOn) then
		string = string .. "Cars\t|| User is at Lat: " .. tostring(lat) .. "\tLon: " .. tostring(long) .. "\tAcc: " .. tostring(acc) .. "m"
		pref = 1
	elseif(checkboxButton1.isOn) then
		string = string .. "Games\t|| User is at Lat: " .. tostring(lat) .. "\tLon: " .. tostring(long) .. "\tAcc: " .. tostring(acc) .. "m"
		pref = 2
	elseif(checkboxButton2.isOn) then
		string = string .. "Food\t|| User is at Lat: " .. tostring(lat) .. "\tLon: " .. tostring(long) .. "\tAcc: " .. tostring(acc) .. "m"
		pref = 3
	else
		string = string .. "nothing\t|| User is at Lat: " .. tostring(lat) .. "\tLon: " .. tostring(long) .. "\tAcc: " .. tostring(acc) .. "m"
		pref = 0
	end

	local jbody = {}
	jbody.id = system.getInfo( "deviceID" )
	jbody.lat = lat
	jbody.lon = long
	jbody.acc = acc
	jbody.prefs = pref
	jbody.mode = onOffSwitch.isOn
	jbody.time = os.time()

	print(json.prettify(json.encode(jbody)))

    print( string )


	local body = "id=" .. system.getInfo("deviceID") .. "&time=" .. os.time() .. "&mode=" .. tostring(onOffSwitch.isOn) .. "&lat=" .. tostring(lat) .. "&lon=" .. tostring(long) .. "&acc=" .. tostring(acc) .. "&prefs=" .. tostring(pref)

	
	local function networkListener( event )
 
		if ( event.isError ) then
			print( "Network error: ", event.response )
		else
			print ( "RESPONSE: " .. event.response )
		end
	end
 
 
	local params = {}
	params.headers = {}
	params.body = body
  
	network.request( "http://127.0.0.1/intdes/post.php", "POST", networkListener, params )
end
 
-- Create the widget
onOffSwitch = widget.newSwitch(
    {
        left = w/2,
        top = h/5,
        style = "onOff",
        id = "onOffSwitch",
        onRelease = onSwitchPress
    }
)

onOffSwitch.x = onOffSwitch.x - onOffSwitch.width/2

local options = 
{
    text = "Directed Ads",     
    x = w/4,
    y = h/5,
    width = w/3,
    font = native.systemFont,   
    fontSize = 18,
}
 
local myText = display.newText( options )
myText:setFillColor( 0, 0, 0 )


local options = 
{
    text = "Generalised Ads",     
    x = w*3/4,
    y = h/5,
    width = w/3,
    font = native.systemFont,   
    fontSize = 18,
}
 
local myText = display.newText( options )
myText:setFillColor( 0, 0, 0 )


local radioGroup = display.newGroup()


-- Create the widget
checkboxButton = widget.newSwitch(
    {
        left = w*4/5,
        top = h*2/5,
        style = "radio",
        id = "Checkbox",
        onRelease = onSwitchPress
    }
)
 
local myText = display.newText( 
	{
		text = "Cars",     
		x = w*2/5,
		y = h*2/5,
		width = w/2,
		font = native.systemFont,   
		fontSize = 18,
	} 
)
myText:setFillColor( 0, 0, 0 )

radioGroup:insert( checkboxButton )
 


-- Create the widget
checkboxButton1 = widget.newSwitch(
    {
        left = w*4/5,
        top = h*3/5,
        style = "radio",
        id = "Checkbox1",
        onRelease = onSwitchPress
    }
)
 
local myText = display.newText( 
	{
		text = "Games",     
		x = w*2/5,
		y = h*3/5,
		width = w/2,
		font = native.systemFont,   
		fontSize = 18,
	} 
)
myText:setFillColor( 0, 0, 0 )

radioGroup:insert( checkboxButton1 )
 


-- Create the widget
checkboxButton2 = widget.newSwitch(
    {
        left = w*4/5,
        top = h*4/5,
        style = "radio",
        id = "Checkbox2",
        onRelease = onSwitchPress
    }
)
 
local myText = display.newText( 
	{
		text = "Food",     
		x = w*2/5,
		y = h*4/5,
		width = w/2,
		font = native.systemFont,   
		fontSize = 18,
	} 
)
myText:setFillColor( 0, 0, 0 )

radioGroup:insert( checkboxButton2 )



local lastTime = os.time()
local function deltaTime()
	local D = os.time() - lastTime
	lastTime = os.time()
	return D
end

local timer = 0
local function locationHandler(event)
	timer = timer + deltaTime()
	if(timer > 30) then
		onSwitchPress()
		timer = 0
	end
	if event.errorCode then
		native.showAlert( "GPS Location Error", event.errorMessage, {"OK"} )
		print( "Location error: " .. tostring( event.errorMessage ) )
	else
		lat = event.latitude
		long = event.longitude
		acc = event.accuracy
	end
end

Runtime:addEventListener( "location", locationHandler )