typeOf = (obj) ->
	if obj == null then return "[object Null]"
	if obj == undefined or typeof obj == "undefined" then return "[object Undefined]"

	return getClass =  toClass(obj)

toClass = (obj)-> (
	str = Object.prototype.toString.call obj
	switch str
		when "[object Function]" then return ( (obj)-> 
			class_name = obj.__class__ || obj.name || "Annonymous"
			return "[class #{class_name}]"
		)(obj)
		when "[object Object]" then return ( (obj)->
			#return typeof obj
			name = obj.constructor.name || "Annonymous"
			"[object #{name}]"
		)(obj)
		
		else str
)
