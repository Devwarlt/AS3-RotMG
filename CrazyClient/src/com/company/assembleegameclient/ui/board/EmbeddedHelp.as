package com.company.assembleegameclient.ui.board
{
	import mx.core.*;

	[Embed(source="EmbeddedHelp.dat", mimeType="application/octet-stream")]
	public class EmbeddedHelp extends mx.core.ByteArrayAsset
	{
		public function EmbeddedHelp()
		{
			super();
			return;
		}
	}
}