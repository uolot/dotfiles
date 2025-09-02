; extends

; highlight class names in class declarations as @AlabasterDefinition
(class_declaration
  name: (type_identifier) @AlabasterDefinition)

; highlight type and interface declarations as @AlabasterType
(type_alias_declaration
  name: (type_identifier) @AlabasterType)

(interface_declaration
  name: (type_identifier) @AlabasterType)

; highlight type references as @AlabasterType
(type_annotation
  (type_identifier) @AlabasterType)

(type_annotation
  (generic_type
    name: (type_identifier) @AlabasterType))

; highlight function params as @AlabasterParam (definition)
(function_declaration
  parameters: (formal_parameters
    (required_parameter
      pattern: (identifier) @AlabasterParam)))

(function_declaration
  parameters: (formal_parameters
    (optional_parameter
      pattern: (identifier) @AlabasterParam)))

(method_definition
  parameters: (formal_parameters
    (required_parameter
      pattern: (identifier) @AlabasterParam)))

(method_definition
  parameters: (formal_parameters
    (optional_parameter
      pattern: (identifier) @AlabasterParam)))

; highlight arrow function params as @AlabasterParam (definition)
(arrow_function
  parameters: (formal_parameters
    (required_parameter
      pattern: (identifier) @AlabasterParam)))

(arrow_function
  parameters: (formal_parameters
    (optional_parameter
      pattern: (identifier) @AlabasterParam)))

(arrow_function
  parameter: (identifier) @AlabasterParam)

; highlight const arrow functions as @AlabasterDefinition (same as function declarations)
(lexical_declaration
  (variable_declarator
    name: (identifier) @AlabasterDefinition
    value: (arrow_function)))

(variable_declaration
  (variable_declarator
    name: (identifier) @AlabasterDefinition
    value: (arrow_function)))

; highlight regular const/let/var with specific value types as @AlabasterVariable
(variable_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (string)))

(variable_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (number)))

(variable_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (true)))

(variable_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (false)))

(variable_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (null)))

(variable_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (undefined)))

(variable_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (object)))

(variable_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (array)))

(variable_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (identifier)))

(variable_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (call_expression)))

(lexical_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (string)))

(lexical_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (number)))

(lexical_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (true)))

(lexical_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (false)))

(lexical_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (null)))

(lexical_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (undefined)))

(lexical_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (object)))

(lexical_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (array)))

(lexical_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (identifier)))

(lexical_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    value: (call_expression)))

; handle variables without explicit values (like destructuring)
(variable_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    !value))

(lexical_declaration
  (variable_declarator
    name: (identifier) @AlabasterVariable
    !value))

<<<<<<< HEAD
; highlight class fields and object properties as @AlabasterProperty
(class_body
  (public_field_definition
    name: (property_identifier) @AlabasterProperty))

(class_body
  (method_definition
    name: (property_identifier) @AlabasterProperty))
||||||| parent of b67cff2 (neovim: Add alabaster.nvim and cleanup plugins/init.lua)
=======
; highlight class fields as @AlabasterProperty
(class_body
  (public_field_definition
    name: (property_identifier) @AlabasterProperty))

; highlight method definitions as @AlabasterMethod (function-like but italic)
(class_body
  (method_definition
    name: (property_identifier) @AlabasterMethod))
>>>>>>> b67cff2 (neovim: Add alabaster.nvim and cleanup plugins/init.lua)

; highlight method calls and property access
(member_expression
  property: (property_identifier) @AlabasterProperty)

(object
  (pair
    key: (property_identifier) @AlabasterProperty))

(object_pattern
  (shorthand_property_identifier_pattern) @AlabasterProperty)

(object_pattern
  (pair_pattern
    key: (property_identifier) @AlabasterProperty))
