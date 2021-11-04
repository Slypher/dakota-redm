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
	for cluster, clusterData in ipairs(DIGGING_CLUSTERS) do

		local center = clusterData.center

		local radius = getCircleDiameterFromPoints(center, clusterData.sites)

		gClusterVolumes[cluster] = { center, radius * 1.5 }
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

	if ENABLED_DEBUG then
		while true do
			Wait(0)

			for site, volume in ipairs(gClusterVolumes) do
				drawVolumeBounds(volume)
			end
		end
	end
end)