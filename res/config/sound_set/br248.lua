local audioutil = require "audioutil"
local soundeffectsutil = require "soundeffectsutil"

function data()
return {
	tracks = {
		{ name = "vehicle/train/br247/idle.wav", refDist = 25.0 },
		{ name = "vehicle/train/br247/anfahrt.wav", refDist = 25.0 },
		{ name = "vehicle/train/br247/fahren.wav", refDist = 25.0 },
		{ name = "vehicle/train/br247/schnell.wav", refDist = 25.0 },
		{ name = "vehicle/train/br247/train_speed_noise.wav", refDist = 25.0 },		
		
		{ name = "vehicle/train/br247/kurve.wav", refDist = 25.0 },
		{ name = "vehicle/train/br247/bremsen.wav", refDist = 25.0 },
	},
	
	events = {
		horn = { names = { "vehicle/train/br247/horn.wav" }, refDist = 50.0 },
	},

	updateFn = function (input)
		local axleRefWeight = 10.0
		
		return {
			tracks = {
				{ 
				--Idle
					gain = soundeffectsutil.sampleCurve({
						{ 0.0, 1.0 },
						{ 1.0, 1.1 },		
					}, input.speed01),
					pitch = soundeffectsutil.sampleCurve({
						{ 0.0, 1.0 },
						{ 1.0, 1.1 },		
					}, input.speed01)
				},
				{ 
				--Anfahrt
					gain = soundeffectsutil.sampleCurve({
						{ 0.0, 0.0 },
						{ 0.01, 1.0 },
						{ 0.08, 1.1 },
						{ 0.3, 0.0 },
						{ 1.0, 0.0 },		
					}, input.speed01),
					pitch = soundeffectsutil.sampleCurve({
						{ 0.0, 1.0 },
						{ 0.04, 1.0 },
						{ 0.12, 1.6 },
						{ 0.3, 1.8 },
						{ 1.0, 1.8 },	
					}, input.speed01)
				},
				{
				--Fahren
					gain = soundeffectsutil.sampleCurve({
						{ 0.0, 0.0 },
						{ 0.15, 1.0 },
						{ 0.4, 1.3 },
						{ 0.7, 0.5 },
						{ 1.0, 0.2 },		
					}, input.speed01),
					pitch = soundeffectsutil.sampleCurve({
						{ 0.0, 0.8 },
						{ 0.4, 1.2 },
						{ 0.4001, 1.13 },
						{ 0.43, 1.15 },
						{ 0.5, 1.25 },
						{ 1.0, 1.35 },	
					}, input.speed01)
				},
				{
				--Schnell
					gain = soundeffectsutil.sampleCurve({
						{ 0.0, 0.0 },
						{ 0.4, 0.0 },
						{ 0.6, 1.3 },
						{ 1.0, 0.8 },		
					}, input.speed01),
					pitch = soundeffectsutil.sampleCurve({
						{ 0.0, 1.0 },
						{ 0.1, 1.0 },
						{ 1.0, 1.2 },	
					}, input.speed01)
				},
				{ 
				--Train Speed Noise
					gain = soundeffectsutil.sampleCurve({
						{ 0.0, 0.0 },
						{ 1.0, 1.0 },							
					}, input.speed01),
					pitch = soundeffectsutil.sampleCurve({
						{ 0.0, 0.8 },
						{ 1.0, 1.2 },
					}, input.speed01)
				},
				soundeffectsutil.squeal(input.speed, input.sideForce, input.maxSideForce),
				soundeffectsutil.brake(input.speed, input.brakeDecel, 0.5)
			},
			events = {
				horn = { gain = 1.0, pitch = 1.0 }
			}
		}
	end
}
end