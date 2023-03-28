function Captcha()
{
	this.Width;
	this.Height;
	this.ReloadImageText;
	this.ValidationResult;

	// Databinding for property ValidationResult
	this.GetValidationResult = function()
	{
		///UserCodeRegionStart:[GetValidationResult] (do not remove this comment.)
		return this.ValidationResult;
		///UserCodeRegionEnd: (do not remove this comment.)
	}

	// Databinding for property ValidationResult
	this.SetValidationResult = function(data)
	{
		///UserCodeRegionStart:[SetValidationResult] (do not remove this comment.)
		this.ValidationResult = data;
		///UserCodeRegionEnd: (do not remove this comment.)
	}

	this.show = function()
	{
		///UserCodeRegionStart:[show] (do not remove this comment.)
		var imgdir = gx.util.resourceUrl(gx.basePath + gx.staticDirectory + 'Captcha/images/', true);
		if(!this.IsPostBack)
		{
			var anum = (Math.floor(Math.random()*191))+1;
			var imgid = parseInt(anum);
			var imagetext = cword[anum-1];
			var buffer = new gx.text.stringBuffer();
			buffer.clear();
			buffer.append('<div id="captchaImage">');
			buffer.append('<img src="' + imgdir + anum + '.jpg" width=150 height=39 border=0 alt=""><br><a href="#" style="color: #004080" onClick="' + this.me() + '.ReloadImage();">' + this.ReloadImageText + '</a><br />');
			buffer.append('<input type="text" class="AttributeLoginCaptcha" name="cfield" id="_cfield" maxlength=15 width=140 value="" onblur="' + this.me() + '.CaptchaValidation(\'' + imagetext + '\');"/>');
			buffer.append('</div>');
			this.setHtml(buffer.toString());
		}
		///UserCodeRegionEnd: (do not remove this comment.)
	}
	///UserCodeRegionStart:[User Functions] (do not remove this comment.)
	mThis = this;
	this.CaptchaValidation = function(imagetext)
	{
		var uword = document.getElementById("_cfield").value;
		var userword = hex_md5(uword);
		if(userword==imagetext){
			mThis.ValidationResult = 1;
		}
		else{
			mThis.ValidationResult = 0;
		}
	}
	this.ReloadImage = function()
	{
		var imgdir = gx.util.resourceUrl(gx.basePath + gx.staticDirectory + 'Captcha/images/', true);
		var anum = (Math.floor(Math.random()*191))+1;
		var imgid = parseInt(anum);
		var imagetext = cword[anum-1];
		
		var buffer = new gx.text.stringBuffer();
		buffer.clear();
		buffer.append('<div id="captchaImage" style="vertical-align:bottom;">');
		buffer.append('<img src="' + imgdir + anum + '.jpg" width=150 height=39 border=0 alt=""><br><a href="#" style="color: #004080" onClick="' + this.me() + '.ReloadImage();">' + this.ReloadImageText + '</a><br />');
		buffer.append('<input type="text" class="AttributeLoginCaptcha" name="cfield" id="_cfield" maxlength=15 width=100 value="" onblur="' + this.me() + '.CaptchaValidation(\'' + imagetext + '\');"/>');
		buffer.append('</div>');
		this.setHtml(buffer.toString());
	}
	///UserCodeRegionEnd: (do not remove this comment.):
}