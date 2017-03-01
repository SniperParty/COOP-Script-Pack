//More info:
//https://community.bistudio.com/wiki/createDiaryRecord
//https://community.bistudio.com/wiki/createDiarySubject

//Add main diary subject
player createDiarySubject ["Diary", "Diary"];

_teamSuffix = if (side player == west) then { "Blu.txt"; } else { "Red.txt"; };

_signal = "";
if ( addonTFAR ) then { _signal = "SignalTFAR"; };
if ( addonACRE ) then { _signal = "SignalACRE"; };

_signal = _signal+_teamSuffix;
_intel = "Intel"+_teamSuffix;
_mission = "Mission"+_teamSuffix;
_situation = "Situation"+_teamSuffix;

//Add new diary pages with ARTR_fnc_briefingFile.
//If including variables, add them as a list to the end of the parameters list: ["ExampleSubject", "ExampleName", "ExampleFile", [ExampleParams]]
if ( addonTFAR || addonACRE ) then { ["Diary", "Signal", _signal] call ARTR_fnc_briefingFile; };
["Diary", "Intel", _intel,[missionNamespace getVariable "trucks_start",missionNamespace getVariable "uav_end"]] call ARTR_fnc_briefingFile;
["Diary", "Mission", _mission,[missionNamespace getVariable "trucks_start"]] call ARTR_fnc_briefingFile;
["Diary", "Situation", _situation,[missionNamespace getVariable "trucks_start"]] call ARTR_fnc_briefingFile;
["Diary", "Background", "Background.txt"] call ARTR_fnc_briefingFile;

//Add diary subject and entries for gameplay logic
player createDiarySubject ["Info", "Scenario Info"];

_extraUAVInfo = "";
if (missionNamespace getVariable ["extendedUAV",false]) then
{
	if (playersNumber east > 1) then
	{
		_extraUAVInfo = "The Extended UAV Info parameter was set: ";
	} else {
		_extraUAVInfo = "Since there is only one infiltrator, Extended UAV Info is on: ";
	};

	_extraUAVInfo = _extraUAVInfo + "The UAV has additional graphical information to mark tracked defender locations. It tracks visible defenders and marks both their locations and the locations where it lost vision on hidden defenders.";
};

["Info", "Mission Mechanics", "Mechanics.txt",[[missionNamespace getVariable "trucks_start",missionNamespace getVariable "uav_end"],_extraUAVInfo]] call ARTR_fnc_briefingFile;
if (addonTFAR) then
{
	["Info", "Setup logic", "TFARHearing.txt"] call ARTR_fnc_briefingFile;
};
