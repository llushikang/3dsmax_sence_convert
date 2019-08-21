--The scripts should always contain at least 10 functions :ScriptID, DisplaySourceName(), SourceSuperClassID(), SourceClassID(), DisplayDestinationName() DestinationSuperClassID(), DestinationClassID(), AboutText() and DefaultConversion, Conversion taking a param.
--Script ID that will append to destination
fn ScriptID = 
(
	""
)

--Return the name to be display for the source in the Scene Converter UI
fn DisplaySourceName =
(
	"vray normal"
)

--Returns the source class of the super class id 
fn SourceSuperClassID =
(
	3088 --Texture
)
--Returns the class id of the source class we use as a source for conversion
fn SourceClassID =
(
	#(1912237649L, 1912962095L) --Bitmap Texture
)

--Return the name to be display for the destination in the Scene Converter UI
fn DisplayDestinationName =
(
		"Arnold bump2d"
)

--Returns the destination class of the super class id
fn DestinationSuperClassID =
(
	3088 --Texture
)
--Returns the class id of the class we use as a destination for conversion
-- so we convert from SourceClassID() to DestinationClassID()
fn DestinationClassID =
(
	#(2121471519L, 3059701102L) --Arnold Image
)

--Validate that the source provided match with one of the SourceClass
fn VerifySource source =
(
	local ret = false	
	local src = SourceClassID()
	
	if(source == undefined) do return false
	
	if(classof src[1] == Array) then
    (
		for cd in src do
		(
			if((cd as string) == (source.ClassID as string)) do
			(
				ret = true
			)
		)
	)
    else
	(
		if((src as string) == (source.ClassID as string)) do
		(
			ret = true
		)
	)
    ret 
)
--Validate that the destination provided match with one of the DestinationClass
fn VerifyDestination destination =
(
	local ret = false	
	local dest = DestinationClassID()

	if(destination == undefined) do return false
	
	if(classof dest[1] == Array) then
    (
		for cd in dest do
		(
			if((cd as string) == (destination.ClassID as string)) do
			(
				ret = true
			)
		)
	)
    else
	(
		if((dest as string) == (destination.ClassID as string)) do
		(
			ret = true
		)
	)
    ret 
)

--Returns some information about this conversion script
fn AboutText =
(
	"About Text"
)


--Internal function that does the parameter mapping
fn ConvertFrom_vraynormaltoarnoldnormal Source Dest =
(
	if ( false == VerifySource Source or 
		 false == VerifyDestination Dest
		) do
	(
		--Not the suitable nodes
		return undefined
	)
	----- Put stuff here
	(
		Dest.bump_map_shader = Source.normal_map
	)
	----- Put stuff here
)

--This function is used as entry when the source is missing (due to a missing plugin) and cannot be completly loaded. 
--In that case the default parameters are loaded.
fn DefaultConversion source /*not used*/ =
(
	newTexture = ai_bump2d()
	
	--return the new texture
	newTexture
)

--Main entry point from this script
--This function handles the texture's creation
fn Conversion BBBitmaptexture =
(
	if (false == VerifySource BBBitmaptexture )  do
	(
		--Not the suitable node
		return undefined
	)	
	
	newTexture = ai_bump2d()
	
	--Call the parameters mapping function to convert
	ConvertFrom_vraynormaltoarnoldnormal BBBitmaptexture newTexture
	
	if (IsProperty BBBitmaptexture "name") and (undefined != BBBitmaptexture.name) and (String == classof BBBitmaptexture.name)  and (IsProperty newTexture "name") do
	(
		newTexture.name = BBBitmaptexture.name
	)
	
	--return the new texture
	newTexture
)