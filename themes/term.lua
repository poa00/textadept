-- Copyright 2007-2020 Mitchell mitchell.att.foicica.com. See LICENSE.
-- Terminal theme for Textadept.
-- Contributions by Ana Balan.

local view = view
local property, property_int = view.property, view.property_int

-- Normal colors.
property['color.black'] = 0x000000
property['color.red'] = 0x000080
property['color.green'] = 0x008000
property['color.yellow'] = 0x008080
property['color.blue'] = 0x800000
property['color.magenta'] = 0x800080
property['color.cyan'] = 0x808000
property['color.white'] = 0xC0C0C0

-- Light colors. (16 color terminals only.)
-- These only apply to 16 color terminals. For other terminals, set the
-- style's `bold` attribute to use the light color variant.
property['color.light_black'] = 0x404040
property['color.light_red'] = 0x0000FF
property['color.light_green'] = 0x00FF00
property['color.light_yellow'] = 0x00FFFF
property['color.light_blue'] = 0xFF0000
property['color.light_magenta'] = 0xFF00FF
property['color.light_cyan'] = 0xFFFF00
property['color.light_white'] = 0xFFFFFF

-- Predefined styles.
property['style.default'] = 'fore:$(color.white),back:$(color.black)'
property['style.linenumber'] = 'fore:$(color.black),bold'
property['style.bracelight'] = 'fore:$(color.black),back:$(color.white)'
--property['style.controlchar'] =
--property['style.indentguide'] =
property['style.calltip'] = '$(style.default)'
property['style.folddisplaytext'] = 'fore:$(color.black),bold'

-- Token styles.
property['style.class'] = 'fore:$(color.yellow)'
property['style.comment'] = 'fore:$(color.black),bold'
property['style.constant'] = 'fore:$(color.red)'
property['style.embedded'] = '$(style.keyword),back:$(color.black)'
property['style.error'] = 'fore:$(color.red),bold'
property['style.function'] = 'fore:$(color.blue)'
property['style.identifier'] = ''
property['style.keyword'] = 'fore:$(color.white),bold'
property['style.label'] = 'fore:$(color.red),bold'
property['style.number'] = 'fore:$(color.cyan)'
property['style.operator'] = 'fore:$(color.yellow)'
property['style.preprocessor'] = 'fore:$(color.magenta)'
property['style.regex'] = 'fore:$(color.green),bold'
property['style.string'] = 'fore:$(color.green)'
property['style.type'] = 'fore:$(color.magenta),bold'
property['style.variable'] = 'fore:$(color.blue),bold'
property['style.whitespace'] = ''

-- Multiple Selection and Virtual Space
--view.additional_sel_fore =
--view.additional_sel_back =
--view.additional_caret_fore =

-- Caret and Selection Styles.
--view:set_sel_fore(true, property_int['color.white'])
--view:set_sel_back(true, property_int['color.black'])
--view.caret_fore = property_int['color.black']
--view.caret_line_back =

-- Fold Margin.
--view:set_fold_margin_colour(true, property_int['color.white'])
--view:set_fold_margin_hi_colour(true, property_int['color.white'])

-- Markers.
local MARK_BOOKMARK = textadept.bookmarks.MARK_BOOKMARK
view.marker_back[MARK_BOOKMARK] = property_int['color.blue']
view.marker_back[textadept.run.MARK_WARNING] = property_int['color.yellow']
view.marker_back[textadept.run.MARK_ERROR] = property_int['color.red']

-- Indicators.
view.indic_fore[ui.find.INDIC_FIND] = property_int['color.yellow']
local INDIC_HIGHLIGHT = textadept.editing.INDIC_HIGHLIGHT
view.indic_fore[INDIC_HIGHLIGHT] = property_int['color.yellow']
local INDIC_PLACEHOLDER = textadept.snippets.INDIC_PLACEHOLDER
view.indic_fore[INDIC_PLACEHOLDER] = property_int['color.magenta']

-- Call tips.
view.call_tip_fore_hlt = property_int['color.blue']

-- Long Lines.
view.edge_colour = property_int['color.red']
