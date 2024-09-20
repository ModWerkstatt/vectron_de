function data()
return {
	info = {
		minorVersion = 0,
		severityAdd = "NONE",
		severityRemove = "WARNING",
		name = _("mod_name"),
		description = _("mod_desc"),
		authors = {
		    {
		        name = "ModWerkstatt",
		        role = "CREATOR",
		    },
		},
		tags = { "europe", "train", "siemens", "vectron", "dual mode", "dual mode light", "disel electric", "diesel", "electric", "universal" },
		minGameVersion = 0,
		dependencies = { },
		url = { "" },
        params = {
			{
				key = "br247_fake",
				name = _("Fake_br247"),
				values = { "No", "Yes", },
				tooltip = _("option_fake_br247_desc"),
				defaultIndex = 0,
			},
			{
				key = "br247",
				name = _("br247_de"),
				values = { "No", "Yes", },
				tooltip = _("option_br247_desc"),				
				defaultIndex = 1,
			},
			{
				key = "br248",
				name = _("br248_dm"),
				values = { "No", "Yes", },
				tooltip = _("option_br248_desc"),				
				defaultIndex = 1,
			},
			{
				key = "br249",
				name = _("br249_dml"),
				values = { "No", "Yes", },
				tooltip = _("option_dc_br193_desc"),				
				defaultIndex = 1,
			},
			{
				key = "diesel",
				name = _("diesel_betrieb"),
				values = { "No", "Yes", },
				tooltip = _("option_diesel_desc"),				
				defaultIndex = 1,
			},
			{
				key = "elektrisch",
				name = _("elektrischer_betrieb"),
				values = { "No", "Yes", },
				tooltip = _("option_elektrisch_desc"),				
				defaultIndex = 1,
			},
        },
	},
	options = {
	},
	runFn = function (settings, modParams)
		
		local fakeFilter = function(fileName, data)		
			if data.metadata.transportVehicle and data.metadata.vectron_de and data.metadata.vectron_de.fake == true then				
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2
				--return false
			end	
			--return true
			return data
		end 
		
		local br247Filter = function(fileName, data)		
			if data.metadata.transportVehicle and data.metadata.vectron_de and data.metadata.vectron_de.br247 == true then		
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2				
			end				
			return data
		end 
		
		local br248Filter = function(fileName, data)		
			if data.metadata.transportVehicle and data.metadata.vectron_de and data.metadata.vectron_de.br248 == true then			
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2				
			end				
			return data
		end 
		
		local br249Filter = function(fileName, data)		
			if data.metadata.transportVehicle and data.metadata.vectron_de and data.metadata.vectron_de.br249 == true then			
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2				
			end				
			return data
		end
		
		local dieselFilter = function(fileName, data)		
			if data.metadata.transportVehicle and data.metadata.vectron_de and data.metadata.vectron_de.diesel == true then			
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2				
			end				
			return data
		end  
		
		local elektrischFilter = function(fileName, data)		
			if data.metadata.transportVehicle and data.metadata.vectron_de and data.metadata.vectron_de.elektrisch == true then			
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2				
			end				
			return data
		end 
		
		if modParams[getCurrentModId()] ~= nil then
			local params = modParams[getCurrentModId()]					
			if params["br247_fake"] == 0 then				
				--addFileFilter("model/transportVehicle", fakeFilter)	
				addModifier("loadModel", fakeFilter)
			end
			if params["br247"] == 0 then				
				addModifier("loadModel", br247Filter)
			end
			if params["br248"] == 0 then				
				addModifier("loadModel", br248Filter)
			end
			if params["br249"] == 0 then				
				addModifier("loadModel", br249Filter)
			end
			if params["diesel"] == 0 then				
				addModifier("loadModel", dieselFilter)
			end
			if params["elektrisch"] == 0 then				
				addModifier("loadModel", elektrischFilter)
			end
			
		else
			--addFileFilter("model/transportVehicle", fakeFilter)			
			addModifier("loadModel", br247Filter)
			addModifier("loadModel", br248Filter)
			addModifier("loadModel", br249Filter)
			addModifier("loadModel", dieselFilter)
			addModifier("loadModel", elektrischFilter)
		end			
	end
}
end
