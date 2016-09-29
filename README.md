### xml解析和生成

##　xml解析

  ```
   local xpath = require "xpath"
	 local lom = require "lxp.lom"

	 local xmlTest =
	 [[
	 <?xml version="1.0" encoding="ISO-8859-1"?>
	 <root>
  	<element id="1" name="element1">text of the first element</element>
    <element id="2" name="element2">
		<subelement>text of the second element</subelement>
    </element>
  	</root>
		]]
	-- get all elements
	print (xpath.selectNodes(lom.parse(xmlTest),'//element'))
	-- get the subelement text
  print (xpath.selectNodes(lom.parse(xmlTest),'/root/element/subelement/text()')[1])
	-- get the first element
	print (xpath.selectNodes(lom.parse(xmlTest),'/root/element[@id="1"]'))

  ```

## xml生成

	```
	local generate = require("generate")

	local message = {ToUserName = image.user,FromUserName = image.count,CreateTime = ngx.time(),MsgType = 'news',ArticleCount=1,Articles={lable='item',{Title = image.title,Description=image.descriptioni ,  PicUrl = image.pic_url,url = image.url }}}

  local xml_str , err = generate.generate(message)

  if not xml_str then
     print ("xml generate error, error info :"  .. err )
  end

	```



