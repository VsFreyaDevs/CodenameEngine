package funkin.backend.system.framerate;

import openfl.text.TextFormat;
import openfl.display.Sprite;
import openfl.text.TextField;
import funkin.backend.system.macros.GitCommitMacro;

class CodenameBuildField extends TextField {
	public function new() {
		super();
		defaultTextFormat = Framerate.textFormat;
		autoSize = LEFT;
		multiline = wordWrap = false;
		text = 'Vs. br: Retoasted v1.0 DEV/PLAYTESTER BUILD\nCodename Engine ${Main.releaseCycle}\npls dont leak pls dont leak';
		selectable = false;
	}
}
