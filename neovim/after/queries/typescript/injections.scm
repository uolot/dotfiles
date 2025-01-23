; extends

(
 (call_expression
   function: (member_expression
               property: (property_identifier) @_name (#eq? @_name "addSql"))
   arguments:
   (arguments
     (string) @injection.content)
   (#offset! @injection.content 0 1 0 -1)
   (#set! injection.include-children)
   (#set! injection.language "sql"))
 )


(
 (call_expression
   function: (member_expression
               property: (property_identifier) @_name (#eq? @_name "addSql"))
   arguments:
   (arguments
     (template_string) @injection.content)
   (#offset! @injection.content 0 1 0 -1)
   (#set! injection.include-children)
   (#set! injection.language "sql"))
 )
