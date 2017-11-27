-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local widget = require( "widget" )

local w,h = display.contentWidth, display.contentHeight

display.setDefault( "background", 1, 1, 1 ) 

-- Handle press events for the checkbox
local function onSwitchPress( event )
    local switch = event.target
    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
end
 
-- Create the widget
local onOffSwitch = widget.newSwitch(
    {
        left = w/2,
        top = h/5,
        style = "onOff",
        id = "onOffSwitch",
        onPress = onSwitchPress
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
local checkboxButton = widget.newSwitch(
    {
        left = w*4/5,
        top = h*2/5,
        style = "radio",
        id = "Checkbox",
        onPress = onSwitchPress
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
local checkboxButton1 = widget.newSwitch(
    {
        left = w*4/5,
        top = h*3/5,
        style = "radio",
        id = "Checkbox1",
        onPress = onSwitchPress
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
local checkboxButton2 = widget.newSwitch(
    {
        left = w*4/5,
        top = h*4/5,
        style = "radio",
        id = "Checkbox2",
        onPress = onSwitchPress
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