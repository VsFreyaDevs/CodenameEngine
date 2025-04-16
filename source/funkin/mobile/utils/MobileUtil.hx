package funkin.mobile.utils;

#if android
import android.os.Build.VERSION;
import android.os.Environment;
import android.Permissions;
import android.Settings;
#end

import lime.system.System;
import lime.app.Application;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

/** 
* @author MaysLastPlay, MarioMaster (MasterX-39)
* @version: 0.2.0
**/

class MobileUtil {
  public static var currentDirectory:String = null;

  /**
   * Get the directory for the application. (External for Android Platform and Internal for iOS Platform.)
   */

  public static function getDirectory():String {
   #if android
   currentDirectory = Environment.getExternalStorageDirectory() + '/.' + Application.current.meta.get('file');
   #elseif ios
   currentDirectory = System.applicationStorageDirectory;
   #end
  return currentDirectory;
  }

    #if android

  /**
   * Requests Storage Permissions on Android Platform.
   */

    public static function getPermissions():Void
    {
    if(VERSION.SDK_INT >= 33){
	   if (!Environment.isExternalStorageManager()) {
	     Settings.requestSetting('MANAGE_APP_ALL_FILES_ACCESS_PERMISSION');
	   }
      } else {
        Permissions.requestPermissions(['READ_EXTERNAL_STORAGE', 'WRITE_EXTERNAL_STORAGE']);
	  }

    try {
      if(!FileSystem.exists(MobileUtil.getDirectory()))
        FileSystem.createDirectory(MobileUtil.getDirectory());
     } catch (e:Dynamic) {
    trace(e);
  if(!FileSystem.exists(MobileUtil.getDirectory())) {
    Application.current.window.alert("Seems like you didnt enabled permissions requested to run the game/didnt put assets to your storage. Please enable them/put assets/mods folders to .CodenameEngine folder to be able to run the game. \n Press OK to close the game.", 'Uncaught Error');
    FileSystem.createDirectory(MobileUtil.getDirectory());
     System.exit(0);
     }
    }
  }

  /**
   * Saves a file to the external storage.
   */

	public static function save(fileName:String = 'Ye', fileExt:String = '.json', fileData:String = 'you didnt cooked, try again!')
	{
	  var savesDir:String = MobileUtil.getDirectory() + 'saved-content/';

		if (!FileSystem.exists(savesDir))
			FileSystem.createDirectory(savesDir);

		File.saveContent(savesDir + fileName + fileExt, fileData);
	}
  #end
}