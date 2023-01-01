-- i got bored so i assigned multiple variables in one-line
if _G.RMA2ENABLED then
	error'RMA2 is already running!'
	return
end
_G.RMA2ENABLED=true
-- services
local Players=game:GetService'Players'
local UserInputService=game:GetService'UserInputService'
local TweenService=game:GetService'TweenService'
local RunService=game:GetService'RunService'
local Teams=game:GetService'Teams'
local ContentProvider=game:GetService'ContentProvider'
-- local
local LocalPlayer=Players.LocalPlayer
local CoreGui=game.CoreGui
local LPG=LocalPlayer.PlayerGui
local MG=LPG.MainGui
local Knight=Teams.Knight
local KC,UIT=Enum.KeyCode,Enum.UserInputType
local ReplicatedStorage=game.ReplicatedStorage
local JewellStand=workspace:FindFirstChild'JewelleryStand'
local Heartbeat=RunService.Heartbeat
local AllBools,Frames={},{}
--functions
local SetClip=toclipboard or setclipboard 
local IS=RunService:IsStudio()	
local function Set(Xnstance)
	return function(Parameters)
		for Parameter,Value in next,Parameters do
			if type(Parameter)=='number'then
				Value.Parent=Xnstance
			else
				Xnstance[Parameter]=Value
			end
		end
	end
end
pcall(function()
	Set(MG.VersionTag){TextSize=20,TextXAlignment=Enum.TextXAlignment.Left,Size=UDim2.new(0,360,0,40),Position=UDim2.new(0,40,1,-50),Text='v.1.436 | LOCAL MODIFIED.',TextScaled=false,TextWrapped=false,RichText=true}
end)
local function Create(Type) 	 	 --useful for lazy people
	local Xnstance=Instance.new(Type)
	return function(Parameters)
		for Parameter,Value in next,Parameters do
			if type(Parameter)=='number'then
				Value.Parent=Xnstance
			else
				Xnstance[Parameter]=Value
			end
		end
		return Xnstance
	end
end
local function Destroy(a,b,c)
	local d=a
	if not b then 
		if d then
			if typeof(d)=='RBXScriptConnection'then
				d:Disconnect()
				return
			end
			d:Destroy()
		end
		return 
	end
	d=d:FindFirstChild(b)
	if c then d=a:FindFirstChildWhichIsA(tostring(b))end
	if d then d:Destroy()return end
end
local function CreateBool(Xame,Value)
	local Bool=Create'BoolValue'{Parent=workspace,Name=Xame}
	if Value then
		Bool.Value=Value
	end
	table.insert(AllBools,Bool)
	return Bool
end
local function ClickSound()
	task.spawn(function()
		local Sound=Create'Sound'{Parent=workspace,Volume=.5,SoundId='rbxassetid://869185498'}
		Sound:Play()
		Sound.Ended:Wait()
		Sound:Destroy()
	end)
end
local function Link(button,frame)
	button.MouseButton1Click:Connect(function()
		ClickSound()
		frame.Visible=not frame.Visible
		if frame.Visible then
			for _,x in next,MG:GetChildren()do
				if string.match(x.Name,'Frame$')and x:IsA'Frame'and x~=frame then
					x.Visible=false
				end
			end
		end
	end)
end
local function Notify(Message,Duration,Warn)
	task.spawn(function()
		if not Warn then warn(Message)end
		if not Duration then Duration=5 end
		local NFrame=Create'Frame'{Parent=MG,BackgroundColor3=Color3.fromRGB(34,34,34),Name='NFrame',Position=UDim2.new(.2,0,.05,0),Size=UDim2.new(.6,0,.06,0),Style=Enum.FrameStyle.Custom}
		local Notif=Create'TextLabel'{Parent=NFrame,AutomaticSize=Enum.AutomaticSize.None,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Name='NotificationText',Position=UDim2.new(.05,0,.175,0),Size=UDim2.new(.9,0,.65,0),Font=Enum.Font.SourceSansSemibold,Text=Message,TextColor3=Color3.new(1,1,1),TextScaled=true,TextSize=14}
		local UISC=Create'UISizeConstraint'{Parent=Notif.Parent}
		local UIC=Create'UICorner'{Parent=Notif.Parent}
		local NSound=MG['Main Gui Core']:FindFirstChild'NotificationSound'
		if NSound then
			NSound:Play()
			NFrame:Destroy(task.wait(Duration-NSound.TimePosition))
			return
		end
		warn'Notif Missing, creating a new one..'
		local NewNSound=Create'Sound'{SoundId='rbxassetid://4590662766',Volume=.5,Parent=MG['Main Gui Core']}
	end)
end
local function CreateIcon(Xame,Xmage,Xosition,XnchorPoint)
	local Label=Create'ImageButton'{Parent=MG,Name=Xame,Size=UDim2.new(0,40,0,40),Position=Xosition,BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Image=Xmage,AnchorPoint=XnchorPoint or Vector2.new(0,0)}
	local UICorner=Create'UICorner'{CornerRadius=UDim.new(0,8),Parent=Label}
	return Label
end
local function CreateButton(Xame,Xarent,Xext,Xosition)
	local Button=Create'TextButton'{Parent=Xarent,AutoButtonColor=true,BackgroundColor3=Color3.fromRGB(90,90,90),Modal=false,Name=Xame..'Button',Position=Xosition,Size=UDim2.new(.5,0,.075,0),Style=Enum.ButtonStyle.Custom,Font=Enum.Font.SourceSansSemibold,LineHeight=1,Text=Xext,TextColor3=Color3.new(1,1,1),TextScaled=true,TextSize=14,TextWrapped=true}
	local UICorner=Create'UICorner'{CornerRadius=UDim.new(0,8),Parent=Button}
	return Button
end
local function CreateFrame(Xame,Heading)
	local Label=Create'Frame'{Parent=MG,Name=Xame..'Frame',Size=UDim2.new(.4,0,.5,0),Position=UDim2.new(.3,0,.25,0),BackgroundColor3=Color3.fromRGB(34,34,34),BorderSizePixel=1,Style='Custom',Visible=false}
	local LHeading=Create'TextLabel'{Parent=Label,AutomaticSize=Enum.AutomaticSize.None,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Name='Heading',Position=UDim2.new(0,0,.025,0),Size=UDim2.new(1,0,.1,0),Font=Enum.Font.SourceSansSemibold,LineHeight=1,RichText=false,Text=Heading,TextColor3=Color3.new(1,1,1),TextScaled=true,TextSize=14,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center}
	local UICorner=Create'UICorner'{Parent=Label,CornerRadius=UDim.new(0,16)}
	local CloseButton=Create'ImageButton'{Parent=Label,Name='CloseButton',Size=UDim2.new(.1,0,.15,0),Image='rbxassetid://5198838744',Position=UDim2.new(.95,0,.1,0),AnchorPoint=Vector2.new(0,1),BackgroundTransparency=1}
	CloseButton.MouseButton1Click:Connect(function()
		ClickSound()
		Label.Visible=false
	end)
	table.insert(Frames,Label)
	return Label
end
local function CreateButtonOld(Xame,Xext,Xosition,XnchorPoint)
	local Label=Create'TextButton'{Parent=MG,Name=Xame,Text=Xext,Size=UDim2.new(0,40,0,40),Position=Xosition,BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Font=Enum.Font.SourceSansSemibold,TextScaled=true,AnchorPoint=XnchorPoint or Vector2.new(0,0)}
	Label.MouseButton1Click:Connect(ClickSound)
	local UICorner=Create'UICorner'{Parent=Label,CornerRadius=UDim.new(0,8)}
	return Label
end
local function CreateDK(Xarent,Xame,Xosition,Xext,Bool,CodeOn,CodeOff)
	local Frame=Create'Frame'{Parent=Xarent,AutomaticSize=Enum.AutomaticSize.None,BackgroundTransparency=1,Name=Xame,Position=Xosition,Size=UDim2.new(.9,0,.075,0),Style=Enum.FrameStyle.Custom}
	local Value=Create'ImageButton'{Parent=Frame,AnchorPoint=Vector2.new(1,.5),BackgroundTransparency=1,Name='Value',Position=UDim2.new(1,0,.5,0),Size=UDim2.new(.1,40,1,40),Image='rbxassetid://1759563960',ImageColor3=Color3.fromRGB(90,90,90)}
	Value.MouseButton1Click:Connect(function()
		if Bool.Value then
			Bool.Value=false
			Value.ImageColor3=Color3.fromRGB(90,90,90)
			if CodeOff then
				task.spawn(CodeOff)
			end
			return
		end
		Bool.Value=true
		Value.ImageColor3=Color3.new(1,1,1)
		task.spawn(CodeOn)
	end)
	local TextL=Create'TextLabel'{Parent=Frame,AutomaticSize=Enum.AutomaticSize.None,BackgroundTransparency=1,Name='Text',Size=UDim2.new(.9,0,1,0),Font=Enum.Font.SourceSansSemibold,Text=Xext,TextColor3=Color3.new(1,1,1),TextScaled=true,TextSize=14,TextXAlignment=Enum.TextXAlignment.Left}
	return Frame
end
local function RequestSword()
	ReplicatedStorage.RequestTool:FireServer'ClassicSword'
end
local function a(p)
	local HumanoidRootPart=LocalPlayer.Character:FindFirstChild'HumanoidRootPart'
	if not HumanoidRootPart then
		Notify('Missing HumanoidRootPart.',3)
		return
	end
	local OldCFrame=HumanoidRootPart.CFrame
	JewellStand.CanCollide,HumanoidRootPart.CFrame=false,JewellStand.CFrame
	repeat
		-- small detail check lol
		if not p.Enabled then
			break
		end
		HumanoidRootPart.CFrame,HumanoidRootPart.Velocity=JewellStand.CFrame,Vector3.new(0,0,0)
		fireproximityprompt(p)
		task.wait(.1)
	until not p.Enabled
	JewellStand.CanCollide,HumanoidRootPart.CFrame=true,OldCFrame
	return true
end

--bools 
local IsAutoClaim,IsAntiProx,IsShowingDupeMenu,IsShowingDesc=CreateBool'IACK',CreateBool'IAP',CreateBool'ISDM',CreateBool'ISD'
local IsAutoRespawn,IsAntiBarrier,IsMusicEnabled=CreateBool'IAR',CreateBool'IAB',CreateBool'IME'

--guis
local Main=CreateIcon('ExploitButton','rbxassetid://10462982957',UDim2.new(0,20,.5,-80))
local Frame=CreateFrame('Custom','hi')
local Credits=Create'TextLabel'{Parent=Frame,Text='credits:\nideas:\ncryniz#5446\ncam1494#7363\nscript:\nkevinYMHGmlg#1822',Size=UDim2.new(.6,0,.9,0),AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(1.05,0,.5,0),Name='Credits',BackgroundTransparency=1,Font=Enum.Font.SourceSansBold,TextTransparency=.9,TextColor3=Color3.new(1,1,1),TextScaled=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Center,TextSize=14}
local Knights=CreateButton('Knight',Frame,'Knight Panel',UDim2.new(.05,0,.75,0))
local Worlds=CreateButton('World',Frame,'W o r l d',UDim2.new(.05,0,.65,0))
local Locals=CreateButton('Local',Frame,'Localplayer',UDim2.new(.05,0,.55,0))
local Booths=CreateButton('Booth',Frame,'Booth',UDim2.new(.05,0,.45,0))
local GuiDestroy=CreateButton('SelfDestruct',Frame,'Disconnect Gui',UDim2.new(.05,0,.85,0))
GuiDestroy.BackgroundColor3=Color3.fromRGB(150,64,27)
local WorldMenu=CreateFrame('World','s')
local WorldReturn=CreateButton('R',WorldMenu,'Return',UDim2.new(.05,0,.85,0))
Link(WorldReturn,Frame)
local KnightMenu=CreateFrame('Knight','knight panel')
local KnightReturn=CreateButton('R',KnightMenu,'Return',UDim2.new(.05,0,.55,0))
Link(KnightReturn,Frame)
local BoothMenu=CreateFrame('Booth','game.service(\'WorkSpace\',game)[\'FilteringEnabled\']=not not Instance.new\'BoolValue\'.Value')
local BoothReturn=CreateButton('R',BoothMenu,'Return',UDim2.new(.05,0,.55,0))
Link(BoothReturn,Frame)
local LocalMenu=CreateFrame('Local','workspace.FilteringEnabled=false')
local LocalReturn=CreateButton('R',LocalMenu,'Return',UDim2.new(.05,0,.55,0))
local TeleportMenu=MG.ContentMenuFrame:Clone()
Set(TeleportMenu){Parent=MG,Name='TeleportationFrame'}
table.insert(Frames,TeleportMenu)
TeleportMenu.Heading.Text='teleportations'
TeleportMenu.Subheading.Text='HumanoidRootPart.CFrame=CFrame.new(pos)*CFrame.Angles(0,ori,0)'

--linkers
Link(TeleportMenu.ReturnButton,WorldMenu)
Link(LocalReturn,Frame)
Link(Main,Frame)
Link(Worlds,WorldMenu)
Link(Knights,KnightMenu)
Link(Locals,LocalMenu)
Link(Booths,BoothMenu)


GuiDestroy.MouseButton1Click:Connect(function()
	ClickSound()
	local CountDown=5
	GuiDestroy.Text='are you sure? ('..tostring(CountDown)..')'
	local CI
	CI=GuiDestroy.MouseButton1Click:Connect(function()
		_G.RMA2ENABLED=false
		for _,x in next,AllBools do
			task.spawn(function()
				x.Value=false
				task.wait(.5)
				x:Destroy()
			end)
		end
		Main:Destroy()
		for _,x in next,Frames do
			if x then
				x:Destroy()
			end
		end
		local t={'BlockM','DupeButton','Counter','ClearS'}
		for _,x in next,MG:GetChildren()do
			if table.find(t,x.Name)then
				x:Destroy()
			end
		end
	end)
	task.spawn(function()
		for i=CountDown,0,-1 do
			CountDown,GuiDestroy.Text=i,'are you sure? ('..tostring(CountDown)..')'
			task.wait(1)
		end
		GuiDestroy.Text='Disconnect Gui'
		CI:Disconnect()
	end)
end)
local APButton=CreateDK(LocalMenu,'AP',UDim2.new(.05,0,.65,0),'Anti Proximity: ',IsAntiProx,
	function()
		local CI,CII
		task.spawn(function()
			local Humanoid=LocalPlayer.Character:FindFirstChildOfClass'Humanoid'
			if not Humanoid then return end
			task.wait(.1)
			Destroy(Humanoid.RootPart,'ProximityPrompt')
		end)
		CI=LocalPlayer.CharacterAdded:Connect(function(char)
			local Humanoid=char:FindFirstChildOfClass'Humanoid'or char:WaitForChild'Humanoid'
			task.wait(.1)
			Destroy(Humanoid.RootPart,'ProximityPrompt')
		end)
		CII=IsAntiProx:GetPropertyChangedSignal'Value':Connect(function()
			CI:Disconnect(CII:Disconnect())
		end)
	end
)
task.spawn(function()
	Set(TeleportMenu){Size=UDim2.new(.8,0,.5,0),Position=UDim2.new(.5,0,.25,0),AnchorPoint=Vector2.new(.5,0)}
	local PlaceSelectionFrame=TeleportMenu:FindFirstChild'ContentSelectionFrame'
	if not PlaceSelectionFrame then
		Notify('Weird, selection frame doesn\'t exist?',2)
		return
	end
	for _,x in next,PlaceSelectionFrame:GetChildren()do
		x:Destroy()
	end
	Set(PlaceSelectionFrame){Size=UDim2.new(.44,0,.5,0),Name='PlaceSelectionFrame'}
	local PlayerSelectionFrame=PlaceSelectionFrame:Clone()
	Set(PlayerSelectionFrame){Position=UDim2.new(.95,0,.3,0),AnchorPoint=Vector2.new(1,0),Name='PlayerSelectionFrame',CanvasSize=UDim2.new(0,0,0,2400)}
	PlayerSelectionFrame.Parent=PlaceSelectionFrame.Parent
	local UIListLayout=Create'UIListLayout'{Parent=PlayerSelectionFrame,Padding=UDim.new(0,8),HorizontalAlignment=Enum.HorizontalAlignment.Left,SortOrder=Enum.SortOrder.Name,VerticalAlignment=Enum.VerticalAlignment.Top,FillDirection=Enum.FillDirection.Vertical}
	local UIGridLayout=Create'UIGridLayout'{Parent=PlaceSelectionFrame,CellSize=UDim2.new(0,82,0,82),SortOrder=Enum.SortOrder.Name}
	local function CreateTB(Player)
		local Xame=Player.Name
		local dn=Player.DisplayName
		if Player.DisplayName==''then dn=Xame end
		local TextButton=Create'TextButton'{Parent=PlayerSelectionFrame,Name=Xame,Size=UDim2.new(1,-10,0,40),BackgroundColor3=Color3.fromRGB(163,162,165),BackgroundTransparency=.9,TextColor3=Color3.new(1,1,1),TextScaled=true,Text=dn..' (@'..Xame..')'}
		TextButton.MouseButton1Click:Connect(function()
			local Character=LocalPlayer.Character
			local TCharacter=Player.Character
			if not Character or not TCharacter then 
				Notify('Missing character either on local or target',3)
				return 
			end
			local HumanoidRootPart,THumanoidRootPart=Character:FindFirstChild'HumanoidRootPart',TCharacter:FindFirstChild'HumanoidRootPart'
			if not HumanoidRootPart or not THumanoidRootPart then
				Notify('Missing HMR either on local or target.',3)
				return
			end
			task.spawn(function()
				for i=1,7 do
					HumanoidRootPart.Velocity=Vector3.new(0,0,0)
					task.wait()
				end
			end)
			HumanoidRootPart.CFrame=THumanoidRootPart.CFrame
		end)
	end
	for _,x in next,Players:GetPlayers()do
		if x~=LocalPlayer then
			CreateTB(x)
		end
	end
	Players.PlayerAdded:Connect(function(Player)
		CreateTB(Player)
	end)
	Players.PlayerRemoving:Connect(function(Player)
		Destroy(PlayerSelectionFrame,Player.Name)
	end)
	local function CreateIB(Xame,Id,Position,y)
		local ImageButton=Create'ImageButton'{Parent=PlaceSelectionFrame,Name=Xame,BorderSizePixel=0,Image='rbxassetid://'..Id}
		ContentProvider:PreloadAsync({ImageButton})
		ImageButton.MouseButton1Click:Connect(function()
			local Character=LocalPlayer.Character
			if not Character then 
				Notify('Missing character',3)
				return 
			end
			local HumanoidRootPart=Character:FindFirstChild'HumanoidRootPart'
			if not HumanoidRootPart then
				Notify('Missing HMR',3)
				return
			end
			task.spawn(function()
				for i=1,15 do
					HumanoidRootPart.Velocity=Vector3.new(0,0,0)
					task.wait()
				end
			end)
			HumanoidRootPart.CFrame=CFrame.new(Position)*CFrame.Angles(0,math.rad(y),0)
		end)
	end
	CreateIB('LoungeTop','11833242216',Vector3.new(-5893,100,38),90)
	CreateIB('Lounge','11833242446',Vector3.new(-5900,-53,21.25),180)
	CreateIB('TreeI','11833241126',Vector3.new(60.25,38,-65.25),112.5)
	CreateIB('TreeII','11833240849',Vector3.new(56.5,38.25,72.5),46)
	CreateIB('Stand','11833241321',Vector3.new(-241.74,5,-241.74),45)
	CreateIB('Rated','11833242032',Vector3.new(-71,19,-40.74),-105.303)
	CreateIB('Shop','11833241871',Vector3.new(-64.5,3,56.25),136)
	CreateIB('Spawn','11833241670',Vector3.new(-8,10,6),90)
	CreateIB('Stage','11833241495',Vector3.new(-85,43,6),-90)
end)
TeleportMenu.CloseButton.MouseButton1Click:Connect(function()
	ClickSound()
	TeleportMenu.Visible=false
end)
local ARButton=CreateDK(LocalMenu,'AR',UDim2.new(.05,0,.85,0),'Auto Respawn: ',IsAutoRespawn,
	function()
		local Position,CI,CII
		local function CharCheck()
			local Character=LocalPlayer.Character
			local Humanoid=Character:WaitForChild'Humanoid'or Character:FindFirstChildOfClass'Humanoid'
			local Root=Character:WaitForChild'HumanoidRootPart'or Character:FindFirstChild'HumanoidRootPart'
			if not Humanoid or not Root then return end			
			if Position~=nil then
				Root.CFrame=Position
				Position=nil
			end
			local Destroying,Die,Parent
			local function yeahwhatever(Connection)
				if not IsAutoRespawn.Value then
					Destroy(Connection)
					return
				end
				if(Root and Root.Position.Y>-50000)then
					Position=Root.CFrame
				end
				ReplicatedStorage.RequestRespawn:FireServer()
			end
			Destroying=Character.ChildRemoved:Connect(function(Part)
				if Part~=Root then return end
				yeahwhatever(Destroying)
			end)
			Parent=Character:GetPropertyChangedSignal'Parent':Connect(function()
				if Character.Parent==LocalPlayer then return end
				yeahwhatever(Parent)
			end)
			Die=Humanoid.Died:Connect(function()
				yeahwhatever(Die)
			end)
		end
		CharCheck()
		CI=LocalPlayer.CharacterAdded:Connect(CharCheck)
		CII=IsAutoRespawn:GetPropertyChangedSignal'Value':Connect(function()
			CI:Disconnect(CII:Disconnect())
			Position=nil
		end)
	end
)
local CKButton=CreateButton('CK',KnightMenu,'Claim Knight',UDim2.new(.05,0,.35,0))
local RSButton=CreateButton('RS',KnightMenu,'Request Sword',UDim2.new(.05,0,.45,0))
local TPButton=CreateButton('TP',WorldMenu,'Teleportations',UDim2.new(.05,0,.75,0))
local DButton=CreateButton('D',WorldMenu,'DrawGui.lua',UDim2.new(.05,0,.65,0))
Link(TPButton,TeleportMenu)
DButton.MouseButton1Click:Connect(function()
	task.spawn(function()
		Destroy(CoreGui,'IsDrawing')
		if CoreGui:FindFirstChild'IsDrawing'then CoreGui.IsDrawing:Destroy()return end
		local Value=Create'BoolValue'{Parent=CoreGui,Name='IsDrawing',Value=true}
		local IsDrawing=Value.Value
		local IsUndoing=false
		local IsHolding=false
		local LockedWhileResetting=false --necessary
		local Character=LocalPlayer.Character
		local Gui=Create'Frame'{Parent=MG,BackgroundTransparency=.5,BackgroundColor3=Color3.fromRGB(34,34,34),Name='DrawGui',Size=UDim2.new(.25,0,.3,0),Position=UDim2.new(0,0,1,0),AnchorPoint=Vector2.new(0,1)}
		local Wait=.065
		task.spawn(function()
			local u=Create'UICorner'{Parent=Gui;CornerRadius=UDim.new(0,16)}
			local g=MG
			g=g:FindFirstChild'ProfileFrame'or g:FindFirstChild'RatingFrame'or g:FindFirstChild'TutorialFrame'
			local h=g.Heading:Clone()
			h.Parent=Gui;h.Text='how 2 use'
			local n=1
			local function s(t,p)
				local v=h:Clone()
				v.Parent=Gui
				if n==1 then
					v.Position=UDim2.new(.05,0,.2,0)
				else
					v.Position=UDim2.new(.05,0,.2+(.075*p),0)
				end
				v.Size=UDim2.new(.9,0,.075,0)
				v.Text=t
				v.Name='v'..tostring(n)
				v.TextXAlignment=Enum.TextXAlignment.Left
				n=n+1
				return v
			end
			s('Rotations = R , T , Y')
			s('Undo = G',1)
			s('Unequip/Reset = Disconnect',2)
			s('Reset All Grips = H',3)
			s('Reset Orientation = J',4)
			s('Swords: Nan/Nan',5)
			local d=s('Delay: ',6)
			d.Size=UDim2.new(.15,0,.075,0)
			local o=s('Rotation: ',7)
			o.Size=d.Size
		end)
		local Fuel=Gui.v6
		local Delay=Create'TextBox'{Parent=Gui,Name='delay',Font=Enum.Font.SourceSansSemibold,TextScaled=true,TextWrapped=true,Text='',AnchorPoint=Vector2.new(1,0),Position=UDim2.new(.95,0,.65,0),Size=UDim2.new(.75,0,.075,0),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=.7,TextColor3=Color3.new(1,1,1),PlaceholderText='delay here'}
		local rot=math.rad(-45)
		local Rotation=Delay:Clone()
		Rotation.Parent,Rotation.PlaceholderText,Rotation.Position=Delay.Parent,'rotation here',Delay.Position+UDim2.new(0,0,.075,0)
		Rotation.FocusLost:Connect(function()
			rot=tonumber(Rotation.Text)or math.rad(-45)
			Rotation.Text=tostring(rot)
		end)
		Delay.FocusLost:Connect(function()
			Wait=tonumber(Delay.Text)or.065
			Delay.Text=tostring(Wait)
		end)
		local Arm=Character:FindFirstChild'Right Arm'or Character:FindFirstChild'RightHand'
		local function SetCF(Position)
			return (Arm.CFrame*CFrame.new(0,-1,0,1,0,0,0,0,1,0,-1,0)):ToObjectSpace(Position):Inverse()
		end
		local Humanoid=Character:FindFirstChildWhichIsA"Humanoid"
		local Animator=Humanoid:FindFirstChild'Animator'
		local HAnimation=Create'Animation'{AnimationId='rbxassetid://182393478'} --Holding, not "that" animation.
		local Track=Animator:LoadAnimation(HAnimation)
		Track:Play(0)
		Track.Priority=Enum.AnimationPriority.Action
		Track:AdjustSpeed(0)
		local Placeholder=Create'Tool'{Name='equip me to disconnect',Parent=LocalPlayer.Backpack,ToolTip='OMG INSTANCE.NEW() HACK!!'}
		local Handle=Create'Part'{Parent=Placeholder,Name='Handle',Transparency=1,Size=Vector3.new(0,0,0)}
		local Orientation=CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
		local Mouse=LocalPlayer:GetMouse()
		local Pointer=Create'Part'{Parent=workspace,Transparency=.6,BrickColor=BrickColor.new(200,0,0),Material='SmoothPlastic',Anchored=true,Size=Vector3.new(1,.8,4),CanCollide=false,CFrame=CFrame.new(0,0,0)*Orientation}
		Mouse.TargetFilter=Pointer
		task.wait(1)
		local CI,CII,CIII,CIV
		local Debounce=false
		local SWR={}
		local total=0
		for _,x in next,LocalPlayer.Backpack:GetChildren()do
			if x:IsA'Tool'and x.Name=='ClassicSword'then
				local handle=x:FindFirstChild'Handle'
				if handle then
					handle.Massless=true
					total=total+1
					table.insert(SWR,x)
					continue
				end
				x:Destroy()
			end
		end
		for _,x in next,Character:GetChildren()do
			if x:IsA'Tool'and x.Name=='ClassicSword'then
				local handle=x:FindFirstChild'Handle'
				if handle then
					handle.Massless=true
					total=total+1
					table.insert(SWR,x)
					x.Parent=LocalPlayer.Backpack
					continue
				end
				x:Destroy()
			end
		end
		LocalPlayer.Character.ChildAdded:Connect(function(Child)
			if Child:IsA'Tool'and Child.Name=='ClassicSword'and Child:FindFirstChild'Handle'and not table.find(SWR,Child)then
				table.insert(SWR,Child)
				total=total+1
				Child.Handle.Massless=true
			end
		end)
		local n=0
		local InputTable={
			[KC.R]=function()Orientation=Orientation*CFrame.Angles(rot,0,0)end,
			[KC.T]=function()Orientation=Orientation*CFrame.Angles(0,rot,0)end,
			[KC.Y]=function()Orientation=Orientation*CFrame.Angles(0,0,rot)end,
			[KC.J]=function()Orientation=CFrame.Angles(math.rad(-90),0,0)end,
			[KC.H]=function()
				n=0
				LockedWhileResetting=true
				local Grouped=Character:GetChildren()
				for c,x in next,Grouped do
					if table.find(SWR,x)then
						x.Grip,x.Parent=CFrame.new(0,0,-1.7,0,0,1,1,0,0,0,1,0),LocalPlayer.Backpack
						if #Grouped/4%c==0 then
							task.wait()
						end
					end
				end
				LockedWhileResetting=false
				Fuel.Text='Swords: 0/'..tostring(total)
			end,
			[KC.G]=function()
				IsUndoing=true
				while IsUndoing and n>0 and IsDrawing do
					local a=SWR[n]
					a.Parent=LocalPlayer.Backpack
					n=n-1
					task.wait(Wait)
				end
			end
		}
		CII=UserInputService.InputBegan:Connect(function(input,input2)
			if input2 then return end
			if input.UserInputType==UIT.MouseButton1 then	
				if LockedWhileResetting then
					IsHolding=false
				end
				IsHolding=true
				CI=Heartbeat:Connect(function()
					if not IsDrawing or not IsHolding then 
						CI:Disconnect()
						return
					end
					if Debounce or n>=total then
						return
					end
					Debounce=true
					n=n+1 
					local a=SWR[n]	
					a.Parent=if a.Parent==Character then LocalPlayer.Backpack else a.Parent
					Set(a){Grip=SetCF(CFrame.new(Mouse.Hit.Position)*Orientation),Parent=LocalPlayer.Character}
					task.wait(Wait)
					Debounce=false
				end)
			elseif input.UserInputType==UIT.Keyboard then
				pcall(InputTable[input.KeyCode])
			end
		end)
		CIII=UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType==UIT.MouseButton1 then 
				IsHolding=false
			elseif(input.UserInputType==UIT.Keyboard and input.KeyCode==KC.G)then
				IsUndoing=false
			end
		end)
		local function t()
			IsDrawing=false
			HAnimation:Destroy()
		end
		Character.ChildRemoved:Connect(function(Part)
			if Part~=Placeholder then return end
			t()
		end)
		Character.Humanoid.Died:Connect(t)
		Placeholder.Equipped:Connect(function()
			HAnimation:Destroy(Track:Stop(task.wait()))
			t()
		end)
		CIV=RunService.RenderStepped:Connect(function()
			if not IsDrawing then
				Destroy(Value)
				Destroy(Gui)
				Destroy(Pointer)
				CIV:Disconnect(CIII:Disconnect(CII:Disconnect()))
				return
			end
			Fuel.Text='Swords: '..tostring(n)..'/'..tostring(total)
			Pointer.CFrame=CFrame.new(Mouse.Hit.Position)*Orientation
		end)
	end)
end)
local function CheckHandle(a,b)
	if b==1 then 
		local M=a:FindFirstChildWhichIsA'SpecialMesh'
		if M then 
			task.spawn(function()
				M:Destroy(task.wait())
			end)
		end 
		return 
	end 
	Set(a){Massless=true,CanCollide=false,CanQuery=false,CanTouch=false}
	a.Parent.Parent=LocalPlayer.Character 
end
RSButton.MouseButton1Click:Connect(function()RequestSword()if LocalPlayer.Team~=Knight then Notify('You dont have knight role, but okay')end end)
local SGButton=CreateDK(KnightMenu,'Dupe',UDim2.new(.05,0,.65,0),'Show Dupe Gui',IsShowingDupeMenu,
	function()
		if LocalPlayer.Team~=Knight then Notify('g5g5gr22r')end
		local SideI=CreateButtonOld('DupeButton','Dupe:\noff',UDim2.new(1,-20,.5,-80),Vector2.new(1,0))
		local Val=Create'BoolValue'{Parent=CoreGui,Name='dupe'}
		local SideII=CreateIcon('ClearS','rbxassetid://11993031978',UDim2.new(1,-20,.5,-30),Vector2.new(1,0))
		local SideIII=CreateButtonOld('BlockM','Clear meshes',UDim2.new(1,-20,.5,20),Vector2.new(1,0))
		local SideIV=Create'TextLabel'{Parent=MG,Name='Counter',Text='Items:\n?',Size=UDim2.new(0,40,0,40),Position=UDim2.new(1,-20,.5,70),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Font=Enum.Font.SourceSansSemibold,TextScaled=true,AnchorPoint=Vector2.new(1,0)}
		local UICorner=Create'UICorner'{Parent=SideIV,CornerRadius=UDim.new(0,8)}
		local InputTable={
			[1]=function(Tool)
				task.spawn(function()	
					Tool.Parent=LocalPlayer.Character
					task.wait(.05)
					Destroy(Tool,'LocalScript',1)
					Destroy(Tool,'Script',1)
					for _,z in next,Tool.Handle:GetChildren()do
						if not z:IsA'Attachment'then
							z:Destroy()
						end
					end
					Tool.Parent=LocalPlayer.Backpack
				end)
			end,
			[2]=function(Tool)
				task.spawn(function()					
					local Handle=Tool:FindFirstChild'Handle'
					if Handle then
						Tool.Parent=LocalPlayer.Character
						task.wait(.05)
						Destroy(Handle,'SpecialMesh',1)
						Tool.Parent=LocalPlayer.Backpack
					end
				end)
			end,
			[3]=function(Tool)
				Tool.Parent=LocalPlayer.Character
			end,
		}
		local function CheckTool(a,b)
			for _,Item in next,a:GetChildren()do 
				if Item:IsA'Tool'and Item.Name=='ClassicSword'then 
					local Handle=Item:FindFirstChild'Handle'or Item:WaitForChild('Handle',4)
					if Handle then 
						Set(Handle){Massless=true,CanCollide=false,CanQuery=false,CanTouch=false}
						InputTable[b](Item)
						continue
					end
					Item:Destroy()	
				end
			end
		end
		do
			local CI
			CI=IsShowingDupeMenu:GetPropertyChangedSignal'Value':Connect(function()
				if not IsShowingDupeMenu.Value then
					Val.Value=false
					Val:Destroy(SideI:Destroy(SideII:Destroy(SideIII:Destroy(SideIV:Destroy(CI:Disconnect())))))
				end
			end)
		end
		SideI.MouseButton1Click:Connect(function()
			Val.Value=not Val.Value
			if not Val.Value then
				return
			end
			CheckTool(LocalPlayer.Backpack,3)
			local CI,CII
			CI=LocalPlayer.Backpack.ChildAdded:Connect(function()
				CheckTool(LocalPlayer.Backpack,3)
			end)
			CII=RunService.RenderStepped:Connect(function()
				if not Val.Value then
					CI:Disconnect(CII:Disconnect())
					return
				end
				RequestSword()
			end)
		end)
		SideII.MouseButton1Click:Connect(function()
			CheckTool(LocalPlayer.Backpack,1)
			CheckTool(LocalPlayer.Character,1)
		end)
		SideIII.MouseButton1Click:Connect(function()
			CheckTool(LocalPlayer.Backpack,2)
			CheckTool(LocalPlayer.Character,2)
		end)
		Val:GetPropertyChangedSignal'Value':Connect(function()
			if Val.Value then
				SideI.Text='Dupe:\non'
				return
			end
			SideI.Text='Dupe:\noff'
		end)
	end
)
local EBButton=CreateDK(BoothMenu,'Extra Banner',UDim2.new(.05,0,.85,0),'Show Id: ',IsShowingDesc,
	function()
		local ExtraBanners={}
		for _,x in next,workspace:GetChildren()do
			if x.Name=='Booth'and x:IsA'Model'then
				local Banner=x:FindFirstChild'Banner'
				if not Banner then
					Notify('a banner is missing',1)
				end
				local Icon=Banner.SurfaceGui.Frame:FindFirstChild'Icon'
				local Description=Banner.SurfaceGui.Frame:FindFirstChild'Description'
				if not Icon then
					Notify('an icon is missing',1)
				end
				if not Description then
					Notify('a description is missing',1)
				end
				local IBanner=Banner:Clone()
				Set(IBanner){Parent=Banner.Parent,Size=Vector3.new(3.8,2.8,.4),CFrame=Banner.CFrame:ToWorldSpace(CFrame.new(6.2,0,0,1,0,0,0,1,0,0,0,1)),Name='ExtraBanner'}
				local Img=IBanner.SurfaceGui.Frame.Description
				for _,v in next,Img.Parent:GetChildren()do
					if v~=Img then
						v:Destroy()
					end
				end
				local TBanner=IBanner:Clone()
				Set(TBanner){Parent=Banner.Parent,Size=Vector3.new(3.8,1.05,.4),CFrame=Banner.CFrame:ToWorldSpace(CFrame.new(6.2,-1.925,0,1,0,0,0,1,0,0,0,1))}
				local Text=TBanner.SurfaceGui.Frame.Description
				Set(Text){Text='Copy text',Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,0,0)}
				Set(Img){RichText=true,Text='roblox.com/library/'..string.match(Icon.Image,'%d+$'),AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,0,.5,0),Size=UDim2.new(1,0,.5,0)}
				Icon:GetPropertyChangedSignal'Image':Connect(function()
					Img.Text='roblox.com/library/'..string.match(Icon.Image,'%d+$')
				end)
				IBanner:FindFirstChildWhichIsA'ClickDetector'.MouseClick:Connect(function()	
					local ID=Icon.Image
					if tonumber(ID)>10 then
						SetClip(ID)
						Notify('Copied, ID: '..ID..'.',3,'hi')
						return
					end
					Notify('This booth has no image.')
				end)
				TBanner:FindFirstChildWhichIsA'ClickDetector'.MouseClick:Connect(function()	
					local T=Description.Text
					if T~='Click here to rent this booth'then
						SetClip(T)
						Notify('Copied.',1,'hi')
						return
					end
					Notify('bruh.')
				end)
				table.insert(ExtraBanners,IBanner)
				table.insert(ExtraBanners,TBanner)
			end
		end
		local CI
		CI=IsShowingDesc:GetPropertyChangedSignal'Value':Connect(function()
			for _,x in next,ExtraBanners do
				x:Destroy()
			end
			CI:Disconnect()
		end)
	end
)
EBButton.Text.Size=UDim2.new(.75,0,1,0)
local DMButton=CreateDK(Frame,'Music',UDim2.new(.05,0,.15,0),'music',IsMusicEnabled,
	function()
		do do end do do end end do end do end end
		--GOD I DONT KNOW HOW TO MAKE TRANSITION PLEASE IGNORE BECAUSE IT'S SPAGHETTI AS HELL
		task.wait(1)
		local Tag=MG.VersionTag
		local the_ultimate_disconnector=true
		local Folder=Create'Folder'{Name='OSTs',Parent=workspace}
		local TweenValue=Create'NumberValue'{Parent=Folder};
		local function text(Name)
			local Trans=tostring(1-TweenValue.Value)
			Tag.Text='v.1.436 | LOCAL MODIFIED. | <i><b><font color="#66e3e5"><stroke color="#66965d" joins="miter" thickness="1" transparency="'..Trans..'"><u>うみとまもののこどもたち</u>  - <font transparency="'..Trans..'">'..Name..'</font></stroke></font>  ^^</b></i>'
		end
		Set(Tag){TextSize=20,TextXAlignment=Enum.TextXAlignment.Left,Size=UDim2.new(0,360,0,40),Position=UDim2.new(0,40,1,-50),TextScaled=false,TextWrapped=false,RichText=true}
		local CCXXXII
		local CXXXll=TweenService:Create(TweenValue,TweenInfo.new(1),{Value=1});CXXXll:Play()
		CXXXll.Completed:Connect(function()CCXXXII:Disconnect()end)
		CCXXXII=TweenValue:GetPropertyChangedSignal'Value':Connect(function()
			Tag.Text='v.1.436 | LOCAL MODIFIED. | <i><b><font color="#66e3e5"><stroke color="#66965d" joins="miter" thickness="1" transparency="'..tostring(1-TweenValue.Value)..'"><u>うみとまもののこどもたち</u>  - <font transparency="1">'..'.edley is great'..'</font></stroke></font>  ^^</b></i>'
		end)
		CXXXll.Completed:Wait()
		TweenValue.Value=0
		local music={
			--credits to K-san, うみとまもののこどもたち (The Children Of The Sea And The Devil)
			[1]={['タイトル']=11971802088}, --title
			[2]={['あるいていこう']=11971804906}, --let's walk!
			[3]={['はれのひ']=11971810581},--sunny day
			[4]={['ほんをよむ']=11971808229}, --reading a book
			[5]={['ちったはなびら']=11971807402}, --flower petals
			[6]={['かいていどうくつ']=11971806642}, --begin
		}
		local ignore=#music
		for i=1,ignore do
			for Counter,Id in next,music[i]do
				local OST=Create'Sound'{Volume=0,SoundId='rbxassetid://'..tostring(Id),Parent=Folder,Name=('うみとまののこどもたち - '..Counter)}
				music[i][Counter]=OST
				OST.Loaded:Wait()
			end
		end
		local function playmusic()
			if not the_ultimate_disconnector then return end
			for i=1,ignore do
				for Name,Theme in next,music[i]do
					Theme:Play()
					local CI,CII,CIII
					do
						local Ret=TweenService:Create(TweenValue,TweenInfo.new(3),{Value=1});Ret:Play()
						Ret.Completed:Connect(function()CII:Disconnect()end)
						CII=TweenValue:GetPropertyChangedSignal'Value':Connect(function()
							Theme.Volume=TweenValue.Value
							text(Name)
						end)
					end
					CI=RunService.RenderStepped:Connect(function()
						if not the_ultimate_disconnector then Destroy(CI)Destroy(CII)Destroy(CIII)return end
						if Theme.TimePosition>=Theme.TimeLength-3 then
							local Ret=TweenService:Create(TweenValue,TweenInfo.new(3),{Value=0});Ret:Play()
							Ret.Completed:Connect(function()CIII:Disconnect()end)
							CIII=TweenValue:GetPropertyChangedSignal'Value':Connect(function()
								Theme.Volume=TweenValue.Value
								text(Name)
							end)
							CI:Disconnect()
						end
					end)
					Theme.Ended:Wait()
				end
			end
			playmusic()
		end
		task.spawn(function()playmusic()end)
		IsMusicEnabled:GetPropertyChangedSignal'Value':Connect(function()
			the_ultimate_disconnector=false
			Destroy(Folder)		
			Tag.Text='v.1.436 | LOCAL MODIFIED.'
		end)
	end
)
local ABButton=CreateDK(BoothMenu,'Anti Barrier',UDim2.new(.05,0,.65,0),'Anti Barrier: ',IsAntiBarrier,
	function()
		local function set(a,b)
			if string.match(a.Name,'^BarrierFor')and a:IsA'BasePart'then
				if b then
					Set(a){CanTouch=true,CastShadow=true,BrickColor=BrickColor.new(165,0,3)}
					return
				end 
				Set(a){CanTouch=false,CanQuery=false,CastShadow=false,Transparency=.95,BrickColor=BrickColor.new(200,200,200)}
			end
		end
		for _,x in next,workspace:GetChildren()do
			set(x)
		end
		local CI
		CI=workspace.ChildAdded:Connect(function(p)
			set(p)
		end)
		IsAntiBarrier:GetPropertyChangedSignal'Value':Connect(function()
			CI:Disconnect()
			for _,v in next,workspace:GetChildren()do
				set(v,'blah blah blah')
			end
		end)
	end
)
local ACKButton=CreateDK(KnightMenu,'ACK',UDim2.new(.05,0,.85,0),'Auto Claim Knight: ',IsAutoClaim,
	function()
		if LocalPlayer.Team==Knight then
			KnightMenu.ACK.Value.ImageColor3=Color3.fromRGB(90,90,90)
			IsAutoClaim.Value=false
			Notify('you already have knight role, what do you expect.')
			return
		end
		if not JewellStand then
			Notify('There\'s no JewelleryStand, Knight Panel may not be working',5)
			return
		end
		local Prox=JewellStand:FindFirstChild'ProximityPrompt'
		if Prox.Enabled then
			local HumanoidRootPart=LocalPlayer.Character:FindFirstChild'HumanoidRootPart'
			if HumanoidRootPart then
				local OldCFrame=HumanoidRootPart.CFrame
				JewellStand.CanCollide=false
				HumanoidRootPart.CFrame=JewellStand.CFrame
				repeat
					HumanoidRootPart.CFrame=JewellStand.CFrame
					fireproximityprompt(Prox)
					task.wait()
				until not Prox or not Prox.Enabled or not IsAutoClaim.Value
				task.wait()
				JewellStand.CanCollide=true
				HumanoidRootPart.CFrame=OldCFrame
				KnightMenu.ACK.Value.ImageColor3=Color3.fromRGB(90,90,90)
				IsAutoClaim.Value=false
				return
			end
			Notify('Missing HumanoidRootPart.',3)
		else
			local CI
			CI=Prox:GetPropertyChangedSignal'Enabled':Connect(function()
				if not IsAutoClaim.Value then					
					CI:Disconnect()
					return
				end
				local Check=a(Prox)
				if Check then
					CI:Disconnect()
					KnightMenu.ACK.Value.ImageColor3=Color3.fromRGB(90,90,90)
					IsAutoClaim.Value=false
				end
			end)
		end
	end
)
CKButton.MouseButton1Click:Connect(function()
	ClickSound()
	if LocalPlayer.Team==Knight then
		Notify('you already have knight role, what do you expect.')
		return
	end
	if not JewellStand then
		Notify('There\'s no JewelleryStand, Knight Panel may not be working',5)
		return
	end
	local Prox=JewellStand:FindFirstChild'ProximityPrompt'
	if Prox then
		if not Prox.Enabled then
			Notify('Knight is not available at the moment',1)
			return
		end
		a(Prox)
	end
end)
