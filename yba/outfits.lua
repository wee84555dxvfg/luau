local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
_G.skinName = "skin.json"
local FOLDER = "skinz"

if not isfolder(FOLDER) then
	makefolder(FOLDER)
end

local function tC(c)
	return {
		c.R,
		c.G,
		c.B
	}
end

local function cT(t)
	return Color3.new(
		t[1],
		t[2],
		t[3]
	)
end

local function tV(v)
	return {
		v.X,
		v.Y,
		v.Z
	}
end

local function vT(t)
	return Vector3.new(
		t[1],
		t[2],
		t[3]
	)
end

local function tCF(cf)
	return {
		cf:GetComponents()
	}
end

local function cfT(t)
	return CFrame.new(
		table.unpack(t)
	)
end

local function getCharacter()
	local char =
		player.Character
		or player.CharacterAdded:Wait()

	local hum =
		char:WaitForChild("Humanoid")

	return char, hum
end

local function getRelativePath(root, obj)
	local path = {}

	local current = obj

	while current and current ~= root do
		table.insert(path, 1, current.Name)
		current = current.Parent
	end

	if current ~= root then
		return nil
	end

	return table.concat(path, "/")
end

local function findByRelativePath(root, path)
	if not path or path == "" then
		return root
	end

	local current = root

	for name in string.gmatch(path, "[^/]+") do
		current = current:FindFirstChild(name)

		if not current then
			return nil
		end
	end

	return current
end

local function saveFire(parent)

	local fire =
		parent:FindFirstChildOfClass(
			"Fire"
		)

	if not fire then
		return nil
	end

	return {
		Name =
			fire.Name,

		Color =
			tC(fire.Color),

		SecondaryColor =
			tC(fire.SecondaryColor),

		Heat =
			fire.Heat,

		Size =
			fire.Size,

		Enabled =
			fire.Enabled,

		TimeScale =
			fire.TimeScale
	}
end

local function loadFire(data, parent)

	local old =
		parent:FindFirstChildOfClass(
			"Fire"
		)

	if old then
		old:Destroy()
	end

	if not data then
		return
	end

	local fire =
		Instance.new("Fire")

	fire.Name =
		data.Name or "Fire"

	if data.Color then
		fire.Color =
			cT(data.Color)
	end

	if data.SecondaryColor then
		fire.SecondaryColor =
			cT(data.SecondaryColor)
	end

	if data.Heat ~= nil then
		fire.Heat =
			data.Heat
	end

	if data.Size ~= nil then
		fire.Size =
			data.Size
	end

	if data.Enabled ~= nil then
		fire.Enabled =
			data.Enabled
	end

	if data.TimeScale ~= nil then
		fire.TimeScale =
			data.TimeScale
	end

	fire.Parent =
		parent

	return fire
end

local function saveSurface(surface)

	if not surface then
		return nil
	end

	return {
		ColorMap =
			surface.ColorMap,

		MetalnessMap =
			surface.MetalnessMap,

		NormalMap =
			surface.NormalMap,

		RoughnessMap =
			surface.RoughnessMap,

		AlphaMode =
			surface.AlphaMode.Name
	}
end

local function loadSurface(data, parent)

	if not data then
		return
	end

	pcall(function()

		local old =
			parent:FindFirstChildOfClass(
				"SurfaceAppearance"
			)

		if old then
			old:Destroy()
		end

		local surface =
			Instance.new(
				"SurfaceAppearance"
			)

		surface.ColorMap =
			data.ColorMap or ""

		surface.MetalnessMap =
			data.MetalnessMap or ""

		surface.NormalMap =
			data.NormalMap or ""

		surface.RoughnessMap =
			data.RoughnessMap or ""

		if data.AlphaMode
			and Enum.AlphaMode[
				data.AlphaMode
			] then

			surface.AlphaMode =
				Enum.AlphaMode[
					data.AlphaMode
				]
		end

		surface.Parent =
			parent
	end)
end

local function saveSpecialMesh(sm)

	if not sm then
		return nil
	end

	return {
		MeshId =
			sm.MeshId,

		TextureId =
			sm.TextureId,

		Scale =
			tV(sm.Scale),

		Offset =
			tV(sm.Offset),

		VertexColor =
			tV(sm.VertexColor),

		MeshType =
			sm.MeshType.Name
	}
end

local function loadSpecialMesh(data, parent)

	if not data then
		return
	end

	local sm =
		Instance.new(
			"SpecialMesh"
		)

	sm.MeshId =
		data.MeshId or ""

	sm.TextureId =
		data.TextureId or ""

	if data.Scale then
		sm.Scale =
			vT(data.Scale)
	end

	if data.Offset then
		sm.Offset =
			vT(data.Offset)
	end

	if data.VertexColor then
		sm.VertexColor =
			vT(data.VertexColor)
	end

	if data.MeshType
		and Enum.MeshType[
			data.MeshType
		] then

		sm.MeshType =
			Enum.MeshType[
				data.MeshType
			]
	end

	sm.Parent =
		parent

	return sm
end

local function findTargetAttachment(
	char,
	accessory,
	name
)

	for _, obj in ipairs(
		char:GetDescendants()
	) do

		if obj:IsA("Attachment")
			and obj.Name == name
			and not obj:IsDescendantOf(
				accessory
			) then

			if obj.Parent
				and obj.Parent:IsA(
					"BasePart"
				) then

				return obj
			end
		end
	end

	return nil
end


local function saveAnimations(char)

	local result = {}

	local animate =
		char:FindFirstChild(
			"Animate"
		)

	if not animate then
		warn("Animate script not found")
		return result
	end

	for _, obj in ipairs(
		animate:GetDescendants()
	) do

		if obj:IsA("Animation") then

			local path =
				getRelativePath(
					animate,
					obj
				)

			if path then

				table.insert(
					result,
					{
						Path = path,
						Name = obj.Name,
						AnimationId =
							obj.AnimationId
					}
				)
			end
		end
	end

	return result
end

local function loadAnimations(
	char,
	animationData
)

	if not animationData then
		return
	end

	local animate =
		char:FindFirstChild(
			"Animate"
		)

	if not animate then
		warn("Animate script not found")
		return
	end

	for _, data in ipairs(
		animationData
	) do

		if data.Path
			and data.AnimationId then

			local animation =
				findByRelativePath(
					animate,
					data.Path
				)

			if animation
				and animation:IsA(
					"Animation"
				) then

				animation.AnimationId =
					data.AnimationId

				print(
					"ANIMATION LOADED:",
					data.Path,
					data.AnimationId
				)

			else

				warn(
					"Animation not found:",
					data.Path
				)
			end
		end
	end
end

function SaveSkin()

	local SKIN_PATH = FOLDER .. "/" .. _G.skinName

	local char, hum =
		getCharacter()

	local data = {

		Version = 5,

		Clothes = {},

		Face = {},

		BodyColors = {},

		Scales = {},

		BodyParts = {},

		Accessories = {},

		CharacterMeshes = {},

		Animations = {}
	}

	
	for _, obj in ipairs(
		char:GetChildren()
	) do

		if obj:IsA("Shirt") then

			data.Clothes.Shirt =
				obj.ShirtTemplate

		elseif obj:IsA("Pants") then

			data.Clothes.Pants =
				obj.PantsTemplate

		elseif obj:IsA(
			"ShirtGraphic"
		) then

			data.Clothes.Graphic =
				obj.Graphic
		end
	end

	for _, obj in ipairs(
		char:GetChildren()
	) do

		if obj:IsA(
			"CharacterMesh"
		) then

			table.insert(
				data.CharacterMeshes,
				{

					Name =
						obj.Name,

					BaseTextureId =
						obj.BaseTextureId,

					MeshId =
						obj.MeshId,

					OverlayTextureId =
						obj.OverlayTextureId,

					BodyPart =
						obj.BodyPart.Name
				}
			)
		end
	end

	local head =
		char:FindFirstChild(
			"Head"
		)

	if head then

		for _, obj in ipairs(
			head:GetChildren()
		) do

			if obj:IsA("Decal")
				or obj:IsA("Texture") then

				local fData = {

					Class =
						obj.ClassName,

					Name =
						obj.Name,

					Texture =
						obj.Texture,

					Face =
						obj.Face.Name,

					Transparency =
						obj.Transparency,

					Color =
						tC(obj.Color3)
				}

				if obj:IsA("Texture") then

					fData.StudsPerTileU =
						obj.StudsPerTileU

					fData.StudsPerTileV =
						obj.StudsPerTileV
				end

				table.insert(
					data.Face,
					fData
				)
			end
		end
	end

	local bc =
		char:FindFirstChildOfClass(
			"BodyColors"
		)

	if bc then

		data.BodyColors = {

			Head =
				tC(bc.HeadColor3),

			Torso =
				tC(bc.TorsoColor3),

			LeftArm =
				tC(bc.LeftArmColor3),

			RightArm =
				tC(bc.RightArmColor3),

			LeftLeg =
				tC(bc.LeftLegColor3),

			RightLeg =
				tC(bc.RightLegColor3)
		}
	end

	local scaleNames = {

		"BodyWidthScale",

		"BodyHeightScale",

		"BodyDepthScale",

		"HeadScale",

		"BodyTypeScale",

		"BodyProportionScale"
	}

	for _, name in ipairs(
		scaleNames
	) do

		local val =
			hum:FindFirstChild(name)

		if val
			and val:IsA(
				"NumberValue"
			) then

			data.Scales[name] =
				val.Value
		end
	end

	data.Animations =
		saveAnimations(char)

	print(
		"Animations saved:",
		#data.Animations
	)

	for _, part in ipairs(
		char:GetChildren()
	) do

		if (
			part:IsA("MeshPart")
			or part:IsA("Part")
		)
			and part.Name
				~= "HumanoidRootPart" then

			local pData = {

				ClassName =
					part.ClassName,

				Color =
					tC(part.Color),

				Material =
					part.Material.Name,

				Transparency =
					part.Transparency,

				Reflectance =
					part.Reflectance
			}

			if part:IsA(
				"MeshPart"
			) then

				pData.MeshId =
					part.MeshId

				pData.TextureID =
					part.TextureID

				pData.DoubleSided =
					part.DoubleSided

				pData.RenderFidelity =
					part.RenderFidelity.Name
			end

			local surf =
				part:FindFirstChildOfClass(
					"SurfaceAppearance"
				)

			if surf then

				pData.Surface =
					saveSurface(surf)
			end

			local sm =
				part:FindFirstChildOfClass(
					"SpecialMesh"
				)

			if sm then

				pData.SpMesh =
					saveSpecialMesh(sm)
			end

			local fire =
				saveFire(part)

			if fire then

				pData.Fire =
					fire
			end

			data.BodyParts[
				part.Name
			] = pData
		end
	end

	for _, acc in ipairs(
		char:GetChildren()
	) do

		if acc:IsA("Accessory") then

			local handle =
				acc:FindFirstChild(
					"Handle"
				)

			if handle
				and handle:IsA(
					"BasePart"
				) then

				local aData = {

					Name =
						acc.Name,

					AccessoryType =
						acc.AccessoryType.Name,

					HandleClass =
						handle.ClassName,

					Size =
						tV(handle.Size),

					Color =
						tC(handle.Color),

					Transparency =
						handle.Transparency,

					Material =
						handle.Material.Name,

					Reflectance =
						handle.Reflectance,

					Attachments = {}
				}

				for _, att in ipairs(
					handle:GetChildren()
				) do

					if att:IsA(
						"Attachment"
					) then

						table.insert(
							aData.Attachments,
							{

								Name =
									att.Name,

								CFrame =
									tCF(
										att.CFrame
									)
							}
						)
					end
				end

				if handle:IsA(
					"MeshPart"
				) then

					aData.Type =
						"MeshPart"

					aData.MeshId =
						handle.MeshId

					aData.TextureID =
						handle.TextureID

					aData.DoubleSided =
						handle.DoubleSided

					aData.RenderFidelity =
						handle.RenderFidelity.Name

				else

					local sm =
						handle:FindFirstChildOfClass(
							"SpecialMesh"
						)

					if sm then

						aData.Type =
							"SpecialMesh"

						aData.SpecialMesh =
							saveSpecialMesh(
								sm
							)

					else

						aData.Type =
							"Part"
					end
				end

				local surf =
					handle:FindFirstChildOfClass(
						"SurfaceAppearance"
					)

				if surf then

					aData.Surface =
						saveSurface(surf)
				end

				local fire =
					saveFire(handle)

				if fire then

					aData.Fire =
						fire
				end

				table.insert(
					data.Accessories,
					aData
				)
			end
		end
	end

	local success, result =
		pcall(function()

			return HttpService:JSONEncode(
				data
			)
		end)

	if not success then

		warn(
			"JSON encode error:",
			result
		)

		return false
	end

	local successWrite, err =
		pcall(function()

			writefile(
				SKIN_PATH,
				result
			)
		end)

	if not successWrite then

		warn(
			"writefile error:",
			err
		)

		return false
	end

	print(
		"SKIN SAVED:",
		SKIN_PATH,
		"Accessories:",
		#data.Accessories,
		"Animations:",
		#data.Animations
	)

	return true
end

function LoadSkin()

	local SKIN_PATH = FOLDER .. "/" .. _G.skinName

	if not isfile(SKIN_PATH) then

		return warn(
			"Skin file not found:",
			SKIN_PATH
		)
	end

	local success, data =
		pcall(function()

			return HttpService:JSONDecode(
				readfile(SKIN_PATH)
			)
		end)

	if not success then

		return warn(
			"JSON error:",
			data
		)
	end

	local char, hum =
		getCharacter()

	local head =
		char:WaitForChild(
			"Head"
		)

	print(
		"Loading skin..."
	)

	for _, obj in ipairs(
		char:GetChildren()
	) do

		if obj:IsA("Accessory")
			or obj:IsA("Shirt")
			or obj:IsA("Pants")
			or obj:IsA("ShirtGraphic")
			or obj:IsA("BodyColors")
			or obj:IsA("CharacterMesh") then

			obj:Destroy()
		end
	end

	if data.Clothes then

		if data.Clothes.Shirt then

			local shirt =
				Instance.new("Shirt")

			shirt.ShirtTemplate =
				data.Clothes.Shirt

			shirt.Parent =
				char
		end

		if data.Clothes.Pants then

			local pants =
				Instance.new("Pants")

			pants.PantsTemplate =
				data.Clothes.Pants

			pants.Parent =
				char
		end

		if data.Clothes.Graphic then

			local graphic =
				Instance.new(
					"ShirtGraphic"
				)

			graphic.Graphic =
				data.Clothes.Graphic

			graphic.Parent =
				char
		end
	end

	for _, cm in ipairs(
		data.CharacterMeshes or {}
	) do

		pcall(function()

			local mesh =
				Instance.new(
					"CharacterMesh"
				)

			mesh.Name =
				cm.Name
				or "CharacterMesh"

			mesh.BaseTextureId =
				cm.BaseTextureId

			mesh.MeshId =
				cm.MeshId

			mesh.OverlayTextureId =
				cm.OverlayTextureId

			if type(cm.BodyPart)
				== "string" then

				if Enum.BodyPart[
					cm.BodyPart
				] then

					mesh.BodyPart =
						Enum.BodyPart[
							cm.BodyPart
						]
				end

			else

				mesh.BodyPart =
					cm.BodyPart
			end

			mesh.Parent =
				char
		end)
	end

	for _, obj in ipairs(
		head:GetChildren()
	) do

		if obj:IsA("Decal")
			or obj:IsA("Texture") then

			obj:Destroy()
		end
	end

	for _, fData in ipairs(
		data.Face or {}
	) do

		if fData.Class == "Decal"
			or fData.Class == "Texture" then

			local f =
				Instance.new(
					fData.Class
				)

			f.Name =
				fData.Name or "face"

			f.Texture =
				fData.Texture or ""

			f.Transparency =
				fData.Transparency or 0

			if fData.Color then

				f.Color3 =
					cT(
						fData.Color
					)
			end

			if fData.Face
				and Enum.NormalId[
					fData.Face
				] then

				f.Face =
					Enum.NormalId[
						fData.Face
					]
			end

			if f:IsA("Texture") then

				f.StudsPerTileU =
					fData.StudsPerTileU
					or 1

				f.StudsPerTileV =
					fData.StudsPerTileV
					or 1
			end

			f.Parent =
				head
		end
	end

	if data.BodyColors
		and data.BodyColors.Head then

		local bc =
			Instance.new(
				"BodyColors"
			)

		bc.HeadColor3 =
			cT(
				data.BodyColors.Head
			)

		bc.TorsoColor3 =
			cT(
				data.BodyColors.Torso
			)

		bc.LeftArmColor3 =
			cT(
				data.BodyColors.LeftArm
			)

		bc.RightArmColor3 =
			cT(
				data.BodyColors.RightArm
			)

		bc.LeftLegColor3 =
			cT(
				data.BodyColors.LeftLeg
			)

		bc.RightLegColor3 =
			cT(
				data.BodyColors.RightLeg
			)

		bc.Parent =
			char
	end

	for name, value in pairs(
		data.Scales or {}
	) do

		local scale =
			hum:FindFirstChild(name)

		if scale
			and scale:IsA(
				"NumberValue"
			) then

			scale.Value =
				value
		end
	end

	for pName, pData in pairs(
		data.BodyParts or {}
	) do

		local target =
			char:FindFirstChild(
				pName
			)

		if target
			and target:IsA(
				"BasePart"
			) then

			if pData.Color then

				target.Color =
					cT(
						pData.Color
					)
			end

			if pData.Material
				and Enum.Material[
					pData.Material
				] then

				target.Material =
					Enum.Material[
						pData.Material
					]
			end

			target.Transparency =
				pData.Transparency or 0

			target.Reflectance =
				pData.Reflectance or 0

			if target:IsA(
				"MeshPart"
			) then

				pcall(function()

					if pData.MeshId then

						target.MeshId =
							pData.MeshId
					end

					if pData.TextureID then

						target.TextureID =
							pData.TextureID
					end

					if pData.DoubleSided
						~= nil then

						target.DoubleSided =
							pData.DoubleSided
					end

					if pData.RenderFidelity
						and Enum.RenderFidelity[
							pData.RenderFidelity
						] then

						target.RenderFidelity =
							Enum.RenderFidelity[
								pData.RenderFidelity
							]
					end
				end)
			end

			local oldSurface =
				target:FindFirstChildOfClass(
					"SurfaceAppearance"
				)

			if oldSurface then
				oldSurface:Destroy()
			end

			if pData.Surface then

				loadSurface(
					pData.Surface,
					target
				)
			end

			local oldMesh =
				target:FindFirstChildOfClass(
					"SpecialMesh"
				)

			if oldMesh then
				oldMesh:Destroy()
			end

			if pData.SpMesh then

				loadSpecialMesh(
					pData.SpMesh,
					target
				)
			end

			loadFire(
				pData.Fire,
				target
			)
		end
	end

	for _, aData in ipairs(
		data.Accessories or {}
	) do

		local successAcc, err =
			pcall(function()

				local acc =
					Instance.new(
						"Accessory"
					)

				acc.Name =
					aData.Name
					or "Accessory"

				if aData.AccessoryType
					and Enum.AccessoryType[
						aData.AccessoryType
					] then

					pcall(function()

						acc.AccessoryType =
							Enum.AccessoryType[
								aData.AccessoryType
							]
					end)
				end

				local handle =
					Instance.new(
						"Part"
					)

				handle.Name =
					"Handle"

				handle.Size =
					aData.Size
					and vT(
						aData.Size
					)
					or Vector3.new(
						1,
						1,
						1
					)

				if aData.Color then

					handle.Color =
						cT(aData.Color)
				end

				handle.Transparency =
					aData.Transparency
					or aData.Trans
					or 0

				handle.Reflectance =
					aData.Reflectance
					or 0

				if aData.Material
					and Enum.Material[
						aData.Material
					] then

					handle.Material =
						Enum.Material[
							aData.Material
						]
				end

				handle.CanCollide =
					false

				handle.CanTouch =
					false

				handle.CanQuery =
					false

				handle.Massless =
					true

				if aData.Type
					== "MeshPart" then

					local sm =
						Instance.new(
							"SpecialMesh"
						)

					sm.MeshType =
						Enum.MeshType.FileMesh

					sm.MeshId =
						aData.MeshId
						or ""

					sm.TextureId =
						aData.TextureID
						or ""

					sm.Scale =
						Vector3.new(
							1,
							1,
							1
						)

					sm.Offset =
						Vector3.new(
							0,
							0,
							0
						)

					sm.Parent =
						handle

				elseif aData.Type
					== "SpecialMesh" then

					if aData.SpecialMesh then

						loadSpecialMesh(
							aData.SpecialMesh,
							handle
						)

					else

						local sm =
							Instance.new(
								"SpecialMesh"
							)

						sm.MeshId =
							aData.MeshId
							or ""

						sm.TextureId =
							aData.TextureId
							or ""

						if aData.Scale then

							sm.Scale =
								vT(
									aData.Scale
								)
						end

						if aData.Offset then

							sm.Offset =
								vT(
									aData.Offset
								)
						end

						if type(
							aData.MeshType
						) == "string" then

							if Enum.MeshType[
								aData.MeshType
							] then

								sm.MeshType =
									Enum.MeshType[
										aData.MeshType
									]
							end
						elseif aData.MeshType then

							pcall(function()

								sm.MeshType =
									aData.MeshType
							end)
						end

						sm.Parent =
							handle
					end
				end

				if aData.Surface then

					loadSurface(
						aData.Surface,
						handle
					)
				end

				loadFire(
					aData.Fire,
					handle
				)

				local attachments = {}

				if aData.Attachments then

					for _, attData in ipairs(
						aData.Attachments
					) do

						local att =
							Instance.new(
								"Attachment"
							)

						att.Name =
							attData.Name

						if attData.CFrame then

							att.CFrame =
								cfT(
									attData.CFrame
								)
						end

						att.Parent =
							handle

						table.insert(
							attachments,
							att
						)
					end

				elseif aData.AttName
					and aData.AttName ~= ""
					and aData.AttCF then

					local att =
						Instance.new(
							"Attachment"
						)

					att.Name =
						aData.AttName

					att.CFrame =
						cfT(
							aData.AttCF
						)

					att.Parent =
						handle

					table.insert(
						attachments,
						att
					)
				end

				handle.Parent =
					acc

				acc.Parent =
					char

				local attached =
					false

				for _, att in ipairs(
					attachments
				) do

					local targetAtt =
						findTargetAttachment(
							char,
							acc,
							att.Name
						)

					if targetAtt then

						handle.CFrame =
							targetAtt.WorldCFrame
							* att.CFrame:Inverse()

						local weld =
							Instance.new(
								"WeldConstraint"
							)

						weld.Part0 =
							handle

						weld.Part1 =
							targetAtt.Parent

						weld.Parent =
							handle

						attached =
							true

						break
					end
				end

				if not attached then

					warn(
						"No matching attachment:",
						acc.Name
					)
				end
			end)

		if not successAcc then

			warn(
				"Accessory error:",
				aData.Name,
				err
			)
		end
	end

	loadAnimations(
		char,
		data.Animations
	)

	print(
		"done."
	)

	return true
end

_G.skinName = "anko.json"

--SaveSkin()
--LoadSkin()


local FOLDER = "skinz"
local CONFIG_PATH = FOLDER .. "/config.cfg"

if not isfolder(FOLDER) then
    makefolder(FOLDER)
end

local config = {
    last_selected = "",
    autoload = true
}

local function boolToString(v)
    return v and "true" or "false"
end

local function saveConfig()
    local content = "last_selected=" .. tostring(config.last_selected or "") .. "\n" .. "autoload=" .. boolToString(config.autoload)
    pcall(function()
        writefile(CONFIG_PATH, content)
    end)
end

local function loadConfig()
    if not isfile(CONFIG_PATH) then
        saveConfig()
        return
    end
    local ok, content = pcall(function()
        return readfile(CONFIG_PATH)
    end)
    if not ok then
        return
    end
    for line in tostring(content):gmatch("[^\r\n]+") do
        local key, value = line:match("^([^=]+)=(.*)$")
        if key == "last_selected" then
            config.last_selected = value
        elseif key == "autoload" then
            config.autoload = value:lower() ~= "false"
        end
    end
end

loadConfig()

if config.last_selected ~= "" then
    _G.skinName = config.last_selected
end

local oldGui = CoreGui:FindFirstChild("AD_OutfitChanger")
if oldGui then
    oldGui:Destroy()
end

if _G.AD_OutfitAutoLoad then
    _G.AD_OutfitAutoLoad:Disconnect()
    _G.AD_OutfitAutoLoad = nil
end

local COLORS = {
    Main = Color3.fromRGB(12, 12, 12),
    Main2 = Color3.fromRGB(18, 18, 18),
    Card = Color3.fromRGB(27, 27, 27),
    CardHover = Color3.fromRGB(38, 38, 38),
    Button = Color3.fromRGB(29, 29, 29),
    ButtonHover = Color3.fromRGB(42, 42, 42),
    Accent = Color3.fromRGB(235, 235, 235),
    Accent2 = Color3.fromRGB(190, 190, 190),
    Text = Color3.fromRGB(245, 245, 245),
    SubText = Color3.fromRGB(170, 170, 170),
    Muted = Color3.fromRGB(105, 105, 105),
    Good = Color3.fromRGB(225, 225, 225),
    Bad = Color3.fromRGB(170, 170, 170),
    Warn = Color3.fromRGB(195, 195, 195),
    Border = Color3.fromRGB(255, 255, 255)
}

local function new(class, props)
    local obj = Instance.new(class)
    for key, value in pairs(props or {}) do
        obj[key] = value
    end
    return obj
end

local function corner(obj, radius)
    return new("UICorner", {
        CornerRadius = UDim.new(0, radius or 8),
        Parent = obj
    })
end

local function stroke(obj, transparency, color)
    return new("UIStroke", {
        Color = color or COLORS.Border,
        Transparency = transparency or 0.9,
        Thickness = 1,
        Parent = obj
    })
end

local function padding(obj, l, r, t, b)
    return new("UIPadding", {
        PaddingLeft = UDim.new(0, l or 0),
        PaddingRight = UDim.new(0, r or 0),
        PaddingTop = UDim.new(0, t or 0),
        PaddingBottom = UDim.new(0, b or 0),
        Parent = obj
    })
end

local function tween(obj, props, duration)
    local tw = TweenService:Create(
        obj,
        TweenInfo.new(duration or 0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        props
    )
    tw:Play()
    return tw
end

local function hoverButton(button, normal, hovered)
    button.MouseEnter:Connect(function()
        tween(button, {BackgroundColor3 = hovered}, 0.13)
    end)
    button.MouseLeave:Connect(function()
        tween(button, {BackgroundColor3 = normal}, 0.13)
    end)
end

local function hoverButtonTrans(button, normalTrans, hoveredTrans)
    button.MouseEnter:Connect(function()
        tween(button, {BackgroundTransparency = hoveredTrans}, 0.13)
    end)
    button.MouseLeave:Connect(function()
        tween(button, {BackgroundTransparency = normalTrans}, 0.13)
    end)
end

local function cleanPath(path)
    path = tostring(path):gsub("\\", "/")
    return path:match("([^/]+)$") or path
end

local function getFiles()
    local files = {}
    local ok, result = pcall(function()
        return listfiles(FOLDER)
    end)
    if not ok or type(result) ~= "table" then
        return files
    end
    for _, path in ipairs(result) do
        local name = cleanPath(path)
        if name ~= "config.cfg" then
            table.insert(files, {
                path = path,
                name = name
            })
        end
    end
    table.sort(files, function(a, b)
        return a.name:lower() < b.name:lower()
    end)
    return files
end

local gui = new("ScreenGui", {
    Name = "AD_OutfitChanger",
    ResetOnSpawn = false,
    IgnoreGuiInset = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = CoreGui
})

local shadow = new("Frame", {
    Size = UDim2.fromOffset(386, 272),
    Position = UDim2.new(0.5, -193, 0.5, -134),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.78,
    BorderSizePixel = 0,
    Parent = gui
})
corner(shadow, 16)

local main = new("Frame", {
    Size = UDim2.fromOffset(380, 266),
    Position = UDim2.new(0.5, -190, 0.5, -137),
    BackgroundColor3 = Color3.fromRGB(10, 10, 10),
    BackgroundTransparency = 0.20,
    BorderSizePixel = 0,
    Parent = gui
})
UserInputService.InputBegan:Connect(function(inp,gp)
	if gp then return end
	if inp.KeyCode == Enum.KeyCode.Home then
		main.Visible = not main.Visible
		shadow.Visible = not shadow.Visible
	end
end)
corner(main, 14)
stroke(main, 0.86)

local title = new("TextLabel", {
    Size = UDim2.new(1, -100, 0, 24),
    Position = UDim2.fromOffset(20, 18),
    BackgroundTransparency = 1,
    Text = "outfit changer <3",
    TextColor3 = COLORS.Text,
    TextSize = 17,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = main
})

local subtitle = new("TextLabel", {
    Size = UDim2.new(1, -100, 0, 16),
    Position = UDim2.fromOffset(20, 40),
    BackgroundTransparency = 1,
    Text = "powered by ad",
    TextColor3 = COLORS.SubText,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = main
})

local settingsButton = new("TextButton", {
    Size = UDim2.fromOffset(36, 36),
    Position = UDim2.new(1, -54, 0, 18),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.94,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "⚙",
    TextColor3 = Color3.fromRGB(200, 200, 200),
    TextSize = 16,
    Font = Enum.Font.Gotham,
    Parent = main
})
corner(settingsButton, 9)
stroke(settingsButton, 0.91)
settingsButton.MouseEnter:Connect(function()
    tween(settingsButton, {
        BackgroundTransparency = 0.88,
        TextColor3 = Color3.fromRGB(245, 245, 245)
    }, 0.14)
end)
settingsButton.MouseLeave:Connect(function()
    tween(settingsButton, {
        BackgroundTransparency = 0.94,
        TextColor3 = Color3.fromRGB(200, 200, 200)
    }, 0.14)
end)

local separator = new("Frame", {
    Size = UDim2.new(1, -40, 0, 1),
    Position = UDim2.fromOffset(20, 68),
    BackgroundColor3 = Color3.new(1, 1, 1),
    BackgroundTransparency = 0.92,
    BorderSizePixel = 0,
    Parent = main
})

local selectLabel = new("TextLabel", {
    Size = UDim2.new(1, -40, 0, 16),
    Position = UDim2.fromOffset(20, 83),
    BackgroundTransparency = 1,
    Text = "SELECTED OUTFIT",
    TextColor3 = COLORS.Muted,
    TextSize = 10,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = main
})

local dropdown = new("TextButton", {
    Size = UDim2.new(1, -40, 0, 44),
    Position = UDim2.fromOffset(20, 104),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.94,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "",
    Parent = main
})
corner(dropdown, 9)
stroke(dropdown, 0.90)
dropdown.MouseEnter:Connect(function()
    tween(dropdown, {
        BackgroundTransparency = 0.90
    }, 0.13)
end)
dropdown.MouseLeave:Connect(function()
    tween(dropdown, {
        BackgroundTransparency = 0.94
    }, 0.13)
end)

local selectedText = new("TextLabel", {
    Size = UDim2.new(1, -55, 1, 0),
    Position = UDim2.fromOffset(14, 0),
    BackgroundTransparency = 1,
    Text = "select outfit",
    TextColor3 = COLORS.Text,
    TextSize = 13,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
    Parent = dropdown
})

local arrow = new("TextLabel", {
    Size = UDim2.fromOffset(32, 44),
    Position = UDim2.new(1, -38, 0, 0),
    BackgroundTransparency = 1,
    Text = "›",
    Rotation = 90,
    TextColor3 = Color3.fromRGB(155, 155, 155),
    TextSize = 19,
    Font = Enum.Font.Gotham,
    Parent = dropdown
})

local saveButton = new("TextButton", {
    Size = UDim2.new(0.5, -25, 0, 44),
    Position = UDim2.fromOffset(20, 166),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.94,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "save",
    TextColor3 = COLORS.Text,
    TextSize = 13,
    Font = Enum.Font.GothamMedium,
    Parent = main
})
corner(saveButton, 9)
stroke(saveButton, 0.9)

local loadButton = new("TextButton", {
    Size = UDim2.new(0.5, -25, 0, 44),
    Position = UDim2.new(0.5, 5, 0, 166),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.94,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "load",
    TextColor3 = COLORS.Text,
    TextSize = 13,
    Font = Enum.Font.GothamMedium,
    Parent = main
})
corner(loadButton, 9)
stroke(loadButton, 0.9)

for _, button in ipairs({saveButton, loadButton}) do
    button.MouseEnter:Connect(function()
        tween(button, {
            BackgroundTransparency = 0.87
        }, 0.13)
    end)
    button.MouseLeave:Connect(function()
        tween(button, {
            BackgroundTransparency = 0.94
        }, 0.13)
    end)
end

local statusDot = new("Frame", {
    Size = UDim2.fromOffset(6, 6),
    Position = UDim2.fromOffset(21, 238),
    BackgroundColor3 = COLORS.Muted,
    BackgroundTransparency = 0.3,
    BorderSizePixel = 0,
    Parent = main
})
corner(statusDot, 10)

local status = new("TextLabel", {
    Size = UDim2.new(1, -55, 0, 20),
    Position = UDim2.fromOffset(34, 231),
    BackgroundTransparency = 1,
    Text = "shii",
    TextColor3 = COLORS.SubText,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = main
})

local statusId = 0

local function showStatus(text)
    statusId += 1
    local id = statusId
    status.Text = text
    status.TextColor3 = Color3.fromRGB(175, 175, 175)
    status.TextTransparency = 0
    statusDot.BackgroundColor3 = Color3.fromRGB(210, 210, 210)
    statusDot.BackgroundTransparency = 0
    task.delay(2.6, function()
        if statusId == id then
            tween(status, {
                TextColor3 = COLORS.SubText
            }, 0.25)
            tween(statusDot, {
                BackgroundColor3 = COLORS.Muted,
                BackgroundTransparency = 0.3
            }, 0.25)
            status.Text = "shii"
        end
    end)
end

local listFrame = new("Frame", {
    Size = UDim2.fromOffset(340, 0),
    BackgroundColor3 = Color3.fromRGB(18, 18, 18),
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Visible = false,
    ZIndex = 50,
    Parent = gui
})
corner(listFrame, 12)
stroke(listFrame, 0.82)

local scrolling = new("ScrollingFrame", {
    Size = UDim2.new(1, -10, 1, -10),
    Position = UDim2.fromOffset(5, 5),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 2,
    ScrollBarImageColor3 = Color3.fromRGB(180, 180, 180),
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ZIndex = 51,
    Parent = listFrame
})
new("UIListLayout", {
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = scrolling
})

local selectedFile = nil
local dropdownOpen = false
local lastSignature = ""

local function closeDropdown()
    dropdownOpen = false
    tween(arrow, {
        Rotation = 90
    }, 0.18)
    tween(listFrame, {
        Size = UDim2.fromOffset(dropdown.AbsoluteSize.X, 0)
    }, 0.14)
    task.delay(0.14, function()
        if not dropdownOpen then
            listFrame.Visible = false
        end
    end)
end

local function selectFile(file)
    selectedFile = file.name
    _G.skinName = file.name
    config.last_selected = file.name
    saveConfig()
    selectedText.Text = file.name
    showStatus("selected " .. file.name)
    closeDropdown()
end

local function rebuildDropdown(force)
    local files = getFiles()
    local names = {}
    for _, file in ipairs(files) do
        table.insert(names, file.name)
    end
    local signature = table.concat(names, "\0")
    if not force and signature == lastSignature then
        return
    end
    lastSignature = signature
    for _, child in ipairs(scrolling:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    if #files == 0 then
        new("TextButton", {
            Size = UDim2.new(1, -2, 0, 38),
            BackgroundTransparency = 1,
            Text = "no outfits found",
            TextColor3 = COLORS.Muted,
            TextSize = 12,
            Font = Enum.Font.Gotham,
            AutoButtonColor = false,
            Active = false,
            ZIndex = 52,
            Parent = scrolling
        })
    else
        for _, file in ipairs(files) do
            local fileRef = file
            local item = new("TextButton", {
                Size = UDim2.new(1, -2, 0, 39),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0.95,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                Text = "",
                ZIndex = 52,
                Parent = scrolling
            })
            corner(item, 8)
            local dot = new("Frame", {
                Size = UDim2.fromOffset(6, 6),
                Position = UDim2.fromOffset(12, 16),
                BackgroundColor3 = file.name == selectedFile and Color3.fromRGB(225, 225, 225) or COLORS.Muted,
                BorderSizePixel = 0,
                ZIndex = 53,
                Parent = item
            })
            corner(dot, 10)
            new("TextLabel", {
                Size = UDim2.new(1, -38, 1, 0),
                Position = UDim2.fromOffset(27, 0),
                BackgroundTransparency = 1,
                Text = file.name,
                TextColor3 = COLORS.Text,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = 53,
                Parent = item
            })
            hoverButtonTrans(item, 0.95, 0.90)
            item.MouseButton1Click:Connect(function()
                selectFile(fileRef)
                rebuildDropdown(true)
            end)
        end
    end
    if selectedFile then
        local exists = false
        for _, file in ipairs(files) do
            if file.name == selectedFile then
                exists = true
                break
            end
        end
        if not exists then
            selectedFile = nil
            selectedText.Text = "select outfit"
            config.last_selected = ""
            saveConfig()
        end
    end
end

local function openDropdown()
    rebuildDropdown(true)
    dropdownOpen = true
    listFrame.Visible = true
    tween(arrow, {
        Rotation = -90
    }, 0.18)
    local pos = dropdown.AbsolutePosition
    local size = dropdown.AbsoluteSize
    listFrame.Position = UDim2.fromOffset(pos.X, pos.Y + size.Y + 6)
    listFrame.Size = UDim2.fromOffset(size.X, 0)
    local files = getFiles()
    local height = math.clamp(math.max(#files, 1) * 43 + 10, 53, 190)
    tween(listFrame, {
        Size = UDim2.fromOffset(size.X, height)
    }, 0.17)
end

dropdown.MouseButton1Click:Connect(function()
    if dropdownOpen then
        closeDropdown()
    else
        openDropdown()
    end
end)

local modalOverlay = new("TextButton", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(8, 8, 10),
    BackgroundTransparency = 1,
    Text = "",
    AutoButtonColor = false,
    Visible = false,
    ZIndex = 70,
    Parent = main
})

local saveModal = new("Frame", {
    Size = UDim2.fromOffset(326, 0),
    Position = UDim2.new(0.5, -163, 0.5, -76),
    BackgroundColor3 = Color3.fromRGB(18, 18, 18),
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 71,
    Parent = modalOverlay
})
corner(saveModal, 13)
stroke(saveModal, 0.82)

local modalTitle = new("TextLabel", {
    Size = UDim2.new(1, -32, 0, 23),
    Position = UDim2.fromOffset(16, 14),
    BackgroundTransparency = 1,
    Text = "save new outfit",
    TextColor3 = COLORS.Text,
    TextSize = 14,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 72,
    Parent = saveModal
})

local modalSub = new("TextLabel", {
    Size = UDim2.new(1, -32, 0, 18),
    Position = UDim2.fromOffset(16, 36),
    BackgroundTransparency = 1,
    Text = "write outfit name",
    TextColor3 = COLORS.SubText,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 72,
    Parent = saveModal
})

local input = new("TextBox", {
    Size = UDim2.new(1, -32, 0, 40),
    Position = UDim2.fromOffset(16, 62),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.94,
    BorderSizePixel = 0,
    ClearTextOnFocus = false,
    PlaceholderText = "outfit name",
    PlaceholderColor3 = COLORS.Muted,
    Text = "",
    TextColor3 = COLORS.Text,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 72,
    Parent = saveModal
})
corner(input, 9)
stroke(input, 0.9)
padding(input, 12, 12)

local cancelSave = new("TextButton", {
    Size = UDim2.new(0.5, -21, 0, 38),
    Position = UDim2.fromOffset(16, 113),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.94,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "cancel",
    TextColor3 = COLORS.Text,
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    ZIndex = 72,
    Parent = saveModal
})
corner(cancelSave, 9)

local proceed = new("TextButton", {
    Size = UDim2.new(0.5, -21, 0, 38),
    Position = UDim2.new(0.5, 5, 0, 113),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.88,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "proceed",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    ZIndex = 72,
    Parent = saveModal
})
corner(proceed, 9)

hoverButtonTrans(cancelSave, 0.94, 0.88)
hoverButtonTrans(proceed, 0.88, 0.82)

local modalOpen = false

local function closeSaveModal()
    modalOpen = false
    tween(saveModal, {
        Size = UDim2.fromOffset(326, 0)
    }, 0.15)
    tween(modalOverlay, {
        BackgroundTransparency = 1
    }, 0.15)
    task.delay(0.15, function()
        if not modalOpen then
            modalOverlay.Visible = false
        end
    end)
end

local function openSaveModal()
    closeDropdown()
    modalOpen = true
    modalOverlay.Visible = true
    modalOverlay.BackgroundTransparency = 1
    saveModal.Size = UDim2.fromOffset(326, 0)
    tween(modalOverlay, {
        BackgroundTransparency = 0.34
    }, 0.16)
    tween(saveModal, {
        Size = UDim2.fromOffset(326, 166)
    }, 0.18)
    task.delay(0.12, function()
        if modalOpen then
            input:CaptureFocus()
        end
    end)
end

saveButton.MouseButton1Click:Connect(function()
    input.Text = ""
    openSaveModal()
end)

cancelSave.MouseButton1Click:Connect(closeSaveModal)

local function doSave()
    local name = input.Text
    name = name:gsub("^%s+", "")
    name = name:gsub("%s+$", "")
    name = name:gsub("[/\\]", "_")
    if name == "" then
        showStatus("enter outfit name")
        return
    end
    if not name:match("%.[^%.]+$") then
        name = name .. ".json"
    end
    _G.skinName = name
    selectedFile = name
    config.last_selected = name
    saveConfig()
    selectedText.Text = name
    closeSaveModal()
    local ok, result = pcall(function()
        return SaveSkin()
    end)
    if ok and result ~= false then
        showStatus("saved • " .. name)
        task.wait(0.1)
        rebuildDropdown(true)
    else
        showStatus("save failed")
    end
end

proceed.MouseButton1Click:Connect(doSave)

input.FocusLost:Connect(function(enterPressed)
    if enterPressed and modalOpen then
        doSave()
    end
end)

loadButton.MouseButton1Click:Connect(function()
    closeDropdown()
    if not selectedFile then
        showStatus("select an outfit first")
        return
    end
    _G.skinName = selectedFile
    config.last_selected = selectedFile
    saveConfig()
    showStatus("loading...")
    local ok, result = pcall(function()
        return LoadSkin()
    end)
    if ok and result ~= false then
        showStatus("loaded • " .. selectedFile)
    else
        showStatus("load failed")
    end
end)

local settingsOverlay = new("TextButton", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(8, 8, 10),
    BackgroundTransparency = 1,
    Text = "",
    AutoButtonColor = false,
    Visible = false,
    ZIndex = 80,
    Parent = main
})

local settingsPanel = new("Frame", {
    Size = UDim2.fromOffset(328, 0),
    Position = UDim2.new(0.5, -164, 0.5, -80),
    BackgroundColor3 = Color3.fromRGB(18, 18, 18),
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 81,
    Parent = settingsOverlay
})
corner(settingsPanel, 13)
stroke(settingsPanel, 0.82)

local settingsTitle = new("TextLabel", {
    Size = UDim2.new(1, -55, 0, 24),
    Position = UDim2.fromOffset(17, 14),
    BackgroundTransparency = 1,
    Text = "settings",
    TextColor3 = COLORS.Text,
    TextSize = 15,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 82,
    Parent = settingsPanel
})

local settingsDesc = new("TextLabel", {
    Size = UDim2.new(1, -34, 0, 18),
    Position = UDim2.fromOffset(17, 38),
    BackgroundTransparency = 1,
    Text = "outfit changer preferences",
    TextColor3 = COLORS.SubText,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 82,
    Parent = settingsPanel
})

local closeSettings = new("TextButton", {
    Size = UDim2.fromOffset(28, 28),
    Position = UDim2.new(1, -42, 0, 12),
    BackgroundTransparency = 1,
    Text = "×",
    TextColor3 = COLORS.SubText,
    TextSize = 20,
    Font = Enum.Font.Gotham,
    ZIndex = 83,
    Parent = settingsPanel
})

local settingCard = new("TextButton", {
    Size = UDim2.new(1, -34, 0, 67),
    Position = UDim2.fromOffset(17, 70),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.94,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "",
    ZIndex = 82,
    Parent = settingsPanel
})
corner(settingCard, 10)
stroke(settingCard, 0.91)

local settingName = new("TextLabel", {
    Size = UDim2.new(1, -80, 0, 20),
    Position = UDim2.fromOffset(13, 11),
    BackgroundTransparency = 1,
    Text = "auto load selected",
    TextColor3 = COLORS.Text,
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 83,
    Parent = settingCard
})

local settingInfo = new("TextLabel", {
    Size = UDim2.new(1, -80, 0, 18),
    Position = UDim2.fromOffset(13, 32),
    BackgroundTransparency = 1,
    Text = "apply outfit automatically after respawn",
    TextColor3 = COLORS.SubText,
    TextSize = 9,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 83,
    Parent = settingCard
})

local toggle = new("Frame", {
    Size = UDim2.fromOffset(42, 23),
    Position = UDim2.new(1, -56, 0.5, -11),
    BackgroundColor3 = config.autoload and Color3.fromRGB(225, 225, 225) or Color3.fromRGB(70, 70, 70),
    BackgroundTransparency = config.autoload and 0 or 0.25,
    BorderSizePixel = 0,
    ZIndex = 83,
    Parent = settingCard
})
corner(toggle, 20)

local toggleCircle = new("Frame", {
    Size = UDim2.fromOffset(17, 17),
    Position = config.autoload and UDim2.fromOffset(22, 3) or UDim2.fromOffset(3, 3),
    BackgroundColor3 = config.autoload and Color3.fromRGB(25, 25, 25) or Color3.fromRGB(220, 220, 220),
    BorderSizePixel = 0,
    ZIndex = 84,
    Parent = toggle
})
corner(toggleCircle, 20)

local function updateToggle(animated)
    local bg = config.autoload and Color3.fromRGB(225, 225, 225) or Color3.fromRGB(70, 70, 70)
    local circleColor = config.autoload and Color3.fromRGB(25, 25, 25) or Color3.fromRGB(220, 220, 220)
    local transparency = config.autoload and 0 or 0.25
    local pos = config.autoload and UDim2.fromOffset(22, 3) or UDim2.fromOffset(3, 3)
    if animated then
        tween(toggle, {
            BackgroundColor3 = bg,
            BackgroundTransparency = transparency
        }, 0.17)
        tween(toggleCircle, {
            Position = pos,
            BackgroundColor3 = circleColor
        }, 0.17)
    else
        toggle.BackgroundColor3 = bg
        toggle.BackgroundTransparency = transparency
        toggleCircle.Position = pos
        toggleCircle.BackgroundColor3 = circleColor
    end
end

settingCard.MouseButton1Click:Connect(function()
    config.autoload = not config.autoload
    saveConfig()
    updateToggle(true)
    showStatus(config.autoload and "auto load enabled" or "auto load disabled")
end)

local settingsOpen = false

local function closeSettingsPanel()
    settingsOpen = false
    tween(settingsPanel, {
        Size = UDim2.fromOffset(328, 0)
    }, 0.15)
    tween(settingsOverlay, {
        BackgroundTransparency = 1
    }, 0.15)
    task.delay(0.15, function()
        if not settingsOpen then
            settingsOverlay.Visible = false
        end
    end)
end

local function openSettingsPanel()
    closeDropdown()
    settingsOpen = true
    updateToggle(false)
    settingsOverlay.Visible = true
    settingsOverlay.BackgroundTransparency = 1
    settingsPanel.Size = UDim2.fromOffset(328, 0)
    tween(settingsOverlay, {
        BackgroundTransparency = 0.34
    }, 0.15)
    tween(settingsPanel, {
        Size = UDim2.fromOffset(328, 155)
    }, 0.18)
end

settingsButton.MouseButton1Click:Connect(function()
    if settingsOpen then
        closeSettingsPanel()
    else
        openSettingsPanel()
    end
end)

closeSettings.MouseButton1Click:Connect(closeSettingsPanel)

rebuildDropdown(true)

do
    local files = getFiles()
    if config.last_selected ~= "" then
        for _, file in ipairs(files) do
            if file.name == config.last_selected then
                selectedFile = file.name
                selectedText.Text = file.name
                _G.skinName = file.name
                break
            end
        end
    end
end

task.spawn(function()
    while gui.Parent do
        task.wait(1)
        pcall(function()
            rebuildDropdown(false)
        end)
    end
end)

_G.AD_OutfitAutoLoad = player.CharacterAdded:Connect(function()
    if not config.autoload then
        return
    end
    if not selectedFile or selectedFile == "" then
        return
    end
    _G.skinName = selectedFile
    task.wait(0.7)
    local ok, err = pcall(function()
        LoadSkin()
    end)
end)

do
    local dragging = false
    local dragStart
    local startPos
    local shadowStart
    title.InputBegan:Connect(function(inputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = inputObject.Position
            startPos = main.Position
            shadowStart = shadow.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(inputObject)
        if not dragging then
            return
        end
        if inputObject.UserInputType ~= Enum.UserInputType.MouseMovement and inputObject.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
        local delta = inputObject.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        shadow.Position = UDim2.new(
            shadowStart.X.Scale,
            shadowStart.X.Offset + delta.X,
            shadowStart.Y.Scale,
            shadowStart.Y.Offset + delta.Y
        )
        if dropdownOpen then
            local pos = dropdown.AbsolutePosition
            local size = dropdown.AbsoluteSize
            listFrame.Position = UDim2.fromOffset(
                pos.X,
                pos.Y + size.Y + 6
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(inputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end
