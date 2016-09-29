--[[
	
	version = 1.0

	auth = hehr 

　note = 生成xml消息格式数据

]]--


local _M = {}

--[[

  note : 参数message是table格式，k用作xml标签，v是值类型
				如果k值是一个table类型参数，如果有lable值用来标识嵌套xml标签，则按照lable为新标签，继续嵌套
				如果没有lable标签，则以key , value的形式去创建xml格式
			
			  ps:只支持两层嵌套
	
  example  message = {

											ToUserName = 'hehr' ,
											
											FromUserName = 'user',
											
											CreateTime = 12345678 ,
											
											MsgType = '这是一个图文消息',
											
											ArticleCount = 2 ,
											
											Articles = { 
													    { 
																	Title = '这是一个title' ,
																	Description = '描述', 
																	PicUrl = '图片链接' ,
																	url = '链接地址'
															} ,

													   {  
																	Title = '这是一个title' ,
																	Description = '描述' , 
																	PicUrl = '图片链接' ,
																	url = '链接地址' 
															} , 
													lable = 'item' }  --有lable标签形式 
										}

]]--
function  _M.generate( message )
	
	if not message then
		return  nil , 'check message'  
	end

	local str = '<?xml version="1.0" encoding="utf-8"?><xml>'

	for  k  , v  in pairs(message)  do
		
		local t = type(v)

		if 	t == 'table' then --table 
				
			if not v  or v.lable =='' then

				return nil , 'lable llegal or nil table'
			
			end
			
			str = str .. '<' .. k .. '>'
			
			if not v.lable then--没有lable标签，按照以key value形式处理
			  
				for lk , lv in pairs(v) do
					
					local nt = type(lv) 

					if nt == 'table' then
              
						break

					elseif nt == 'string' then
						
						str = str .. '<' .. lk ..'><![CDATA[' .. lv .. ']]></' .. lk .. '>'

					else
						
						str =   str .. '<' .. nk ..'>' .. nv .. '</' .. nk .. '>'

					end

				end
				
			else --　有lable标签
     	
			  local lable = v.lable
			  
				for _ , lv  in pairs(v) do
					
				  if type(lv) ==  'table' then
				 	 
					  str = str .. '<' .. lable .. '>'

					  for nk , nv in pairs( lv ) do

							 local nt = type(nv)

							 if nt == 'table' then
							 	 
								 break

							 elseif nt == 'string' then

							   str = str .. '<' .. nk ..'><![CDATA[' .. nv .. ']]></' .. nk .. '>'
								           
							 else
							         
							   str =   str .. '<' .. nk ..'>' .. nv .. '</' .. nk .. '>'
							 
							 end
							
						end
				  
					 str = str .. '</' .. lable .. '>'

          end		    	

			   end

			end

			str = str .. '</' .. k .. '>'

		elseif t == 'string' then-- 字符串加　<![CDATA[title1]]>　
			 
			str =   str .. '<' .. k ..'><![CDATA[' .. v .. ']]></' .. k .. '>'

		else
				
			str = 	str .. '<' .. k ..'>' .. v .. '</' .. k .. '>'

		end				

	end
	
	str = str .. '</xml>'

	return 	str , 'success'

end

return _M
