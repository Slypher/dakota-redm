function getCircleDiameterFromPoints(center, points)
	local ret

	for _, a in ipairs(points) do
		local distanceToCenter = #(center - a)

		if not ret or distanceToCenter > ret then
			ret = distanceToCenter
		end
	end

	return ret
end

function createDiggingSiteVolumes()
	for diggingSiteIndex, diggingSite in ipairs(DIGGING_SITES) do

		local center = diggingSite.center

		local radius = getCircleDiameterFromPoints(center, diggingSite.positions)

		gDiggingSiteVolumeCenterAndRadius[diggingSiteIndex] = { center, radius * 1.5 }
	end
end

function drawVolumeBounds(volume)
	local volumeCenter, volumeRadius = volume[1], volume[2]

	local volumeX, volumeY, volumeZ = volumeCenter.x, volumeCenter.y, volumeCenter.z

	for i = 0, 360, 2.5 do
		i = math.rad(i)

		local X_deg0 = volumeX + (volumeRadius * math.cos(i))
		local Y_deg0 = volumeY + (volumeRadius * math.sin(i))

		local circlePoint = vec3(X_deg0, Y_deg0, volumeZ)

		Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, volumeCenter, circlePoint, 255, 0, 0, 255)
	end
end

CreateThread(function()
	createDiggingSiteVolumes()

	-- while true do
	-- 	Wait(0)

	-- 	for diggingSiteIndex, volume in ipairs(gDiggingSiteVolumeCenterAndRadius) do
	-- 		drawVolumeBounds(volume)
	-- 	end
	-- end
end)