local firebase = require("plugin.firebase")
local widget = require("widget")
local json = require("json")

-- setup
firebase.myUrl = "myUrl"
firebase.myKey = "myKey"
firebase.databaseSecret = "databaseSecret"
--
local arrowFile= "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_arrow_png"

local timerInfoChange
local activateLogin
local signOutStuff

local loginType = display.newText( "Create Account", display.contentCenterX, display.contentCenterY-200, native.systemFont, 15 )

local currentSegement = 1

local emailText = display.newText( "Email", display.contentCenterX, display.contentCenterY-140, native.systemFont, 20 )
local email = native.newTextField( display.contentCenterX, display.contentCenterY-100, 300, 50 )
local emailPos = {emailText.x, emailText.x+100000000, email.x, email.x+100000000,}

local passwordText = display.newText( "Password", display.contentCenterX, display.contentCenterY-40, native.systemFont, 20 )
local password = native.newTextField( display.contentCenterX, display.contentCenterY, 300, 50 )
local passwordPos= {passwordText.x, passwordText.x+100000000, password.x, password.x+100000000,}
password.isSecure = true

local submitButton = display.newGroup( )
submitButton.box = display.newRect( submitButton, 0,0, 100, 50 )
submitButton.myText = display.newText(submitButton, "Submit", 0, 0, native.systemFont, 15 )
submitButton.myText:setFillColor( 0 )
submitButton.box:addEventListener( "tap", function (  )
	local function lis( e )
		if (e.response == "logined") then
			activateLogin()
		elseif e.response ~= nil then --create account
			local storeText= loginType.text
			loginType.text = e.error
			timerInfoChange = timer.performWithDelay( 2000, function (  )
				loginType.text = storeText
			end )
		else
			local storeText= loginType.text
			loginType.text = e.error
			timerInfoChange = timer.performWithDelay( 2000, function (  )
				loginType.text = storeText
			end )
		end
	end
	if (currentSegement == 2) then
		firebase.login(email.text,password.text, lis, true)
	elseif (currentSegement == 1) then
		firebase.createAccount(email.text,password.text, lis, true, false)
	elseif (currentSegement == 3) then
		firebase.resetPassword(email.text,lis)
	end
end )
submitButton.x, submitButton.y = display.contentCenterX, display.contentCenterY+100

local signOut = display.newGroup()
signOut.box = display.newRect( signOut, 0,0, 100, 50 )
signOut.myText = display.newText(signOut, "Sign Out", 0, 0, native.systemFont, 15 )
signOut.myText:setFillColor( 0 )
signOut.alpha = 0
signOut.box:addEventListener( "tap", function (  )
	firebase.signOut(function ( e )
		if (not e.error) then
			signOutStuff()
		end
	end)
end )

signOut.x, signOut.y = display.contentCenterX, display.contentCenterY+150
--[[
local signInWithSocial = display.newRect( 200, 50, 260, 58 )
signInWithSocial:scale( .5, .5 )
signInWithSocial.x, signInWithSocial.y = display.contentCenterX, display.contentCenterY+170
-- note before using set up in console> auth>sign method 
signInWithSocial:addEventListener( "tap", function (  )
	firebase.loginWithSocial( "access_token", "google.com, facebook.com, github.com or twitter.com", function ( e )
		if (not e.error) then
			activateLogin(  )
		else
			local storeText= loginType.text
			loginType.text = "Could not sign in"
			timerInfoChange = timer.performWithDelay( 2000, function (  )
				loginType.text = storeText
			end )
		end
	end)
end )

signInWithSocial.alpha = 1
]]--

local getMyInfo = display.newGroup()
getMyInfo.box = display.newRect( getMyInfo, 0,0, 100, 50 )
getMyInfo.myText = display.newText(getMyInfo, "Get my Info", 0, 0, native.systemFont, 15 )
getMyInfo.myText:setFillColor( 0 )
getMyInfo.alpha = 0
getMyInfo.box:addEventListener( "tap", function (  )
	firebase.getAccountInfo(function ( e )
		if (not e.error) then
			print( "Account Info" )
			print( "---------------------" )
			print( json.encode( e.response ) )
			print( "---------------------" )
		end
	end)
end )

getMyInfo.x, getMyInfo.y = display.contentCenterX+110, display.contentCenterY+150

local setMyInfo = display.newGroup()
setMyInfo.box = display.newRect( setMyInfo, 0,0, 100, 50 )
setMyInfo.myText = display.newText(setMyInfo, "Set my Info", 0, 0, native.systemFont, 15 )
setMyInfo.myText:setFillColor( 0 )
setMyInfo.alpha = 0
local myName = "Bill"
setMyInfo.box:addEventListener( "tap", function (  )
	firebase.setAccountInfo(myName, nil, nil,function ( e )
		if (not e.error) then
			print( "Account info updated" )
		end
	end)
end )

setMyInfo.x, setMyInfo.y = display.contentCenterX+110, display.contentCenterY+90

local getMyData = display.newGroup()
getMyData.box = display.newRect( getMyData, 0,0, 100, 50 )
getMyData.myText = display.newText(getMyData, "Get User Info", 0, 0, native.systemFont, 15 )
getMyData.myText:setFillColor( 0 )
getMyData.alpha = 0
getMyData.box:addEventListener( "tap", function (  )
	firebase.getUserData(function ( e )
		if (not e.error) then
			print( "User Info" )
			print( "---------------------" )
			print( json.encode( e.response ) )
			print( "---------------------" )
		end
	end)
end )

getMyData.x, getMyData.y = display.contentCenterX-110, display.contentCenterY+30

local sendMyData = display.newGroup()
sendMyData.box = display.newRect( sendMyData, 0,0, 100, 50 )
sendMyData.myText = display.newText(sendMyData, "Send User Info", 0, 0, native.systemFont, 15 )
sendMyData.myText:setFillColor( 0 )
sendMyData.alpha = 0
local theData = {name= "hello", test= "corona"}
sendMyData.box:addEventListener( "tap", function (  )
	firebase.uploadUserData(theData, function ( e )
		if (not e.error) then
			print("data sent")
		end
	end)
end )

sendMyData.x, sendMyData.y = display.contentCenterX, display.contentCenterY-30

local updateMyData = display.newGroup()
updateMyData.box = display.newRect( updateMyData, 0,0, 100, 50 )
updateMyData.myText = display.newText(updateMyData, "Update User Info", 0, 0, native.systemFont, 13 )
updateMyData.myText:setFillColor( 0 )
updateMyData.alpha = 0
local theData2 = {name= "hello bob"}
updateMyData.box:addEventListener( "tap", function (  )
	firebase.updateUserData(theData2, function ( e )
		if (not e.error) then
			print("data updated")
		end
	end)
end )

updateMyData.x, updateMyData.y = display.contentCenterX+110, display.contentCenterY-30

local deleteMyData = display.newGroup()
deleteMyData.box = display.newRect( deleteMyData, 0,0, 100, 50 )
deleteMyData.myText = display.newText(deleteMyData, "Delete User Info", 0, 0, native.systemFont, 13 )
deleteMyData.myText:setFillColor( 0 )
deleteMyData.alpha = 0
deleteMyData.box:addEventListener( "tap", function (  )
	firebase.deleteUserData(function ( e )
		if (not e.error) then
			print("data deleted")
		end
	end)
end )

deleteMyData.x, deleteMyData.y = display.contentCenterX-110, display.contentCenterY-30

local deleteMyAccount = display.newGroup()
deleteMyAccount.box = display.newRect( deleteMyAccount, 0,0, 100, 50 )
deleteMyAccount.myText = display.newText(deleteMyAccount, "Delete Account", 0, 0, native.systemFont, 13 )
deleteMyAccount.myText:setFillColor( 0 )
deleteMyAccount.alpha = 0
deleteMyAccount.box:addEventListener( "tap", function (  )
	firebase.deleteUserData(function ( e )
		if (not e.error) then
			print("data deleted")
		end
	end)
end )

deleteMyAccount.x, deleteMyAccount.y = display.contentCenterX-110, display.contentCenterY+150

local getData = display.newGroup()
getData.box = display.newRect( getData, 0,0, 100, 50 )
getData.myText = display.newText({parent = getData, text="Get Data From database", x=0, y=10, width=100,height=50 ,font=native.systemFont, fontSize=11, align = "center"} )
getData.myText:setFillColor( 0 )
getData.alpha = 0
getData.box:addEventListener( "tap", function (  )
	firebase.getData("test1", function ( e )
		if (not e.error) then
			print( "Data From database" )
			print( "---------------------" )
			print( json.encode( e.response ) )
			print( "---------------------" )
		end
	end)
end )

getData.x, getData.y = display.contentCenterX, display.contentCenterY+90

local sendData = display.newGroup()
sendData.box = display.newRect( sendData, 0,0, 100, 50 )
sendData.myText = display.newText({parent = sendData, text="Send to Data to database", x=0, y=10, width=100,height=50 ,font=native.systemFont, fontSize=11, align = "center"} )
sendData.myText:setFillColor( 0 )
sendData.alpha = 0
local data3 = {here= "is some data", pi = 3.14}
sendData.box:addEventListener( "tap", function (  )
	firebase.uploadData("test1", data3, function ( e )
		if (not e.error) then
			print( "data sent" )
		end
	end)
end )

sendData.x, sendData.y = display.contentCenterX-110, display.contentCenterY+90


local updateData = display.newGroup()
updateData.box = display.newRect( updateData, 0,0, 100, 50 )
updateData.myText = display.newText({parent = updateData, text="Update to Data to database", x=0, y=10, width=100,height=50 ,font=native.systemFont, fontSize=11, align = "center"} )
updateData.myText:setFillColor( 0 )
updateData.alpha = 0
local data3 = {here= "is some good data", iAmNum= 1}
updateData.box:addEventListener( "tap", function (  )
	firebase.updateData("test1", data3, function ( e )
		if (not e.error) then
			print( "data sent" )
		end
	end)
end )

updateData.x, updateData.y = display.contentCenterX+110, display.contentCenterY+30

local deleteData = display.newGroup()
deleteData.box = display.newRect( deleteData, 0,0, 100, 50 )
deleteData.myText = display.newText({parent = deleteData, text="Delete data in database", x=0, y=10, width=100,height=50 ,font=native.systemFont, fontSize=11, align = "center"} )
deleteData.myText:setFillColor( 0 )
deleteData.alpha = 0
deleteData.box:addEventListener( "tap", function (  )
	firebase.deleteData("test1", function ( e )
		if (not e.error) then
			print( "data deleted" )
		end
	end)
end )

deleteData.x, deleteData.y = display.contentCenterX, display.contentCenterY+30

local encodeFile = display.newGroup()
encodeFile.box = display.newRect( encodeFile, 0,0, 100, 50 )
encodeFile.myText = display.newText({parent = encodeFile, text="encode file", x=0, y=15, width=100,height=50 ,font=native.systemFont, fontSize=15, align = "center"} )
encodeFile.myText:setFillColor( 0 )
encodeFile.alpha = 0

encodeFile.box:addEventListener( "tap", function (  )
	print( "file encoded" )
	print( "------------------" )
	print(firebase.encodeFile("imageFolder/imageFolder2/arrow.png", system.ResourceDirectory, "arrow.png"))
	print( "------------------" )
end )

encodeFile.x, encodeFile.y = display.contentCenterX, display.contentCenterY-90

local decodeFile = display.newGroup()
decodeFile.box = display.newRect( decodeFile, 0,0, 100, 50 )
decodeFile.myText = display.newText({parent = decodeFile, text="decode file", x=0, y=15, width=100,height=50 ,font=native.systemFont, fontSize=15, align = "center"} )
decodeFile.myText:setFillColor( 0 )
decodeFile.alpha = 0

decodeFile.box:addEventListener( "tap", function (  )
	print(firebase.decodeFile(arrowFile, system.TemporaryDirectory))
end )

decodeFile.x, decodeFile.y = display.contentCenterX+110, display.contentCenterY-90

local changeModeAccount = widget.newSegmentedControl( {
	segments = { "Create", "Login", "Reset Pass" },
	defaultSegment = 1,
	segmentWidth = 100,
	onPress= function ( e )
		if (timerInfoChange) then
			timer.cancel( timerInfoChange )
			timerInfoChange = nil
		end
		if e.target.segmentNumber == 2 then
			loginType.text = "Login"
			currentSegement = 2
			passwordText.x = passwordPos[1]
			password.x = passwordPos[3]
		elseif e.target.segmentNumber == 1 then
			loginType.text = "Create Account"
			currentSegement = 1
			passwordText.x = passwordPos[1]
			password.x = passwordPos[3]
		elseif e.target.segmentNumber == 3 then
			loginType.text = "Forgot Password"
			currentSegement = 3
			passwordText.x = passwordPos[2]
			password.x = passwordPos[4]
		end
	end
} )
changeModeAccount.x, changeModeAccount.y = display.contentCenterX, display.contentCenterY-170
function activateLogin(  )
	passwordText.x = passwordPos[2]
	password.x = passwordPos[4]
	emailText.x = emailPos[2]
	email.x = emailPos[4]
	changeModeAccount.alpha = 0
	submitButton.alpha = 0
	loginType.text = "Logined In"
	signOut.alpha = 1
	getMyInfo.alpha = 1
	getMyData.alpha = 1
	sendMyData.alpha = 1
	updateMyData.alpha = 1
	deleteMyData.alpha = 1
	deleteMyAccount.alpha = 1
	setMyInfo.alpha =1
	getData.alpha = 1
	sendData.alpha = 1
	updateData.alpha = 1
	deleteData.alpha = 1
	encodeFile.alpha = 1
	decodeFile.alpha = 1
end
function signOutStuff(  )
	passwordText.x = passwordPos[1]
	password.x = passwordPos[3]
	emailText.x = emailPos[1]
	email.x = emailPos[3]
	changeModeAccount.alpha = 1
	submitButton.alpha = 1
	currentSegement = 1
	loginType.text = "Create Account"
	signOut.alpha = 0
	getMyInfo.alpha = 0
	getMyData.alpha = 0
	sendMyData.alpha = 0
	updateMyData.alpha = 0
	deleteMyData.alpha = 0
	deleteMyAccount.alpha = 0
	setMyInfo.alpha =0
	getData.alpha = 0
	sendData.alpha = 0
	updateData.alpha = 0
	deleteData.alpha = 0
	encodeFile.alpha = 0
	decodeFile.alpha = 0
	changeModeAccount:setActiveSegment(1)
end
firebase.quickLogin(function ( e )
	if (e.response == "logined") then
		activateLogin()
	end
end)
