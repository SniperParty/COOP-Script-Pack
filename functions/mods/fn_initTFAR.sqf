addonTFAR = false;

if ("task_force_radio" call ARTR_fnc_checkMod) then
{
	addonTFAR = true;

	call compile preprocessFileLineNumbers "\task_force_radio\functions\common.sqf";

	//General settings
	ARTR_TFAR_autoLR = false; 			//automatically add backpack radio to leader
	ARTR_TFAR_gruntUpgrade = true; 		//give personal radio to regular riflemen
	ARTR_TFAR_microDagr = false;			//give microDAGR to regular riflemen
	ARTR_TFAR_sameSW = true;				//same SW frequency for entire side
	ARTR_TFAR_sameLR = true;				//same LR frequency for entire side
	ARTR_TFAR_sameDD = true;				//same DD frequency for entire side


	//BLUFOR radios and channel settings
	tf_west_radio_code = "_blufor";
	TF_defaultWestBackpack = "tf_rt1523g";
	TF_defaultWestPersonalRadio = "tf_anprc152";
	TF_defaultWestRiflemanRadio = "tf_rf7800str";
	TF_defaultWestAirborneRadio = "tf_anarc210";

	_defaultWestRadios = [TF_defaultWestPersonalRadio,TF_defaultWestRiflemanRadio,TF_defaultWestAirborneRadio];

	//GREENFOR radios and channel settings
	tf_guer_radio_code = "_independent";
	TF_defaultGuerBackpack = "tf_anprc155";
	TF_defaultGuerPersonalRadio = "tf_anprc148jem";
	TF_defaultGuerRiflemanRadio = "tf_anprc154";
	TF_defaultGuerAirborneRadio = "tf_anarc164";

	_defaultGuerRadios = [TF_defaultGuerPersonalRadio,TF_defaultGuerRiflemanRadio,TF_defaultGuerAirborneRadio];

	//REDFOR radios and channel settings
	tf_east_radio_code = "_opfor";
	TF_defaultEastBackpack = "tf_mr3000";
	TF_defaultEastPersonalRadio = "tf_fadak";
	TF_defaultEastRiflemanRadio = "tf_pnr1000a";
	TF_defaultEastAirborneRadio = "tf_mr6000l";

	_defaultEastRadios = [TF_defaultEastPersonalRadio,TF_defaultEastRiflemanRadio,TF_defaultEastAirborneRadio];

	switch (side player) do
	{
		case west:
		{
			ARTR_TF_defaultRadios = _defaultWestRadios;
			ARTR_TF_defaultBackpack = TF_defaultWestBackpack;
		};

		case resistance:
		{
			ARTR_TF_defaultRadios = _defaultGuerRadios;
			ARTR_TF_defaultBackpack = TF_defaultGuerBackpack;
		};

		case east:
		{
			ARTR_TF_defaultRadios = _defaultEastRadios;
			ARTR_TF_defaultBackpack = TF_defaultEastBackpack;
		};

		default
		{
			ARTR_TF_defaultRadios = [];
			ARTR_TF_defaultBackpack = "";
		};
	};

	[
		"CBA_beforeSettingsInitialized",
		{
			["CBA_settings_setSettingMission", ["TF_no_auto_long_range_radio",ARTR_TFAR_autoLR,true]] call CBA_fnc_localEvent;
			["CBA_settings_setSettingMission", ["TF_give_personal_radio_to_regular_soldier",ARTR_TFAR_gruntUpgrade,true]] call CBA_fnc_localEvent;
			["CBA_settings_setSettingMission", ["TF_give_microdagr_to_soldier",ARTR_TFAR_microDagr,true]] call CBA_fnc_localEvent;
			["CBA_settings_setSettingMission", ["TF_same_sw_frequencies_for_side",ARTR_TFAR_sameSW,true]] call CBA_fnc_localEvent;
			["CBA_settings_setSettingMission", ["TF_same_lr_frequencies_for_side",ARTR_TFAR_sameLR,true]] call CBA_fnc_localEvent;
			["CBA_settings_setSettingMission", ["TF_same_dd_frequencies_for_side",ARTR_TFAR_sameDD,true]] call CBA_fnc_localEvent;
			["CBA_beforeSettingsInitialized",ARTR_TFAR_thisId] call CBA_fnc_removeEventHandler;
		},
		[]
	] call CBA_fnc_addEventHandlerArgs;

	["ARTR_receivedRadios", "OnRadiosReceived", { _this call ARTR_fnc_TFARRadiosAdded; }, player] call TFAR_fnc_addEventHandler;

	["ARTR_AIHearing", "OnSpeak", { _this call ARTR_fnc_TFARSpeaking; }, player] call TFAR_fnc_addEventHandler;

	["ARTR_TFARVolume", "OnSpeakVolume", { _this call ARTR_fnc_TFARVolumeChange; }, player] call TFAR_fnc_addEventHandler;
};
