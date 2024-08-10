-- Copyright 2020-2024 Mitchell. See LICENSE.

test('macro.record should record keyboard macros', function()
	local _<close> = test.mock(keys, 'ctrl+,', textadept.macros.record)
	local _<close> = test.mock(keys, 'ctrl+.', textadept.macros.play)
	local _<close> = test.mock(keys, 'ctrl+shift+right', buffer.word_right_end_extend)
	local _<close> = test.mock(keys, 'home', buffer.vc_home)
	buffer:append_text(test.lines{'word', 'word'})

	test.type('ctrl+,') -- record
	test.type('ctrl+shift+right')
	test.type('replacement')
	test.type('home')
	test.type('down')
	textadept.macros.record() -- stop record (cannot use test.type() here)

	test.type('ctrl+.') -- play

	test.assert_equal(buffer:get_text(), test.lines{'replacement', 'replacement'})
end)

local function record(f)
	textadept.macros.record()
	f()
	textadept.macros.record()
end

test('macro.record should store the previously recorded macro in register 0', function()
	record(function() test.type(' ') end)
	record(function() test.type('overwrite') end)
	buffer:close(true)

	textadept.macros.play('0')

	test.assert_equal(buffer:get_text(), ' ')
end)

test('macro.record should record menu selections', function()
	record(function() events.emit(events.MENU_CLICKED, 1) end) -- simulate File > New
	buffer:close()

	textadept.macros.play()

	test.assert_equal(#_BUFFERS, 2)
end)

test('macro.record should record find/replace', function()
	local find = 'find'
	local replace = find:upper()
	buffer:append_text(test.lines{find, find})

	record(function()
		ui.find.find_entry_text = find
		ui.find.replace_entry_text = replace
		ui.find.find_next()
		ui.find.replace()
		test.type('right')
		test.log(buffer:get_text())
	end)

	textadept.macros.play()

	test.assert_equal(buffer:get_text(), test.lines{replace, replace})
end)

test('macros.play should load and play the macro from a given filename', function()
	local filename, _<close> = test.tempfile()
	record(function() test.type(' ') end)
	textadept.macros.save(filename)

	textadept.macros.play(filename)

	test.assert_equal(buffer:get_text(), '  ')
end)

test('macros.save should save macros to a given filename in the macro directory', function()
	local macro_file = 'macro_file'
	local _<close> = test.defer(function() os.remove(macro_file) end)
	record(function() test.type(' ') end)

	textadept.macros.save(macro_file)

	test.assert(lfs.attributes(_USERHOME .. '/macros/' .. macro_file), 'should have saved macro')
end)

test('macros.save should prompt for a filename if none was given', function()
	local filename, _<close> = test.tempfile()
	os.remove(filename) -- should not exist yet
	local select_filename = test.stub(filename)
	local _<close> = test.mock(ui.dialogs, 'save', select_filename)

	record(function() test.type(' ') end)

	textadept.macros.save()

	test.assert(lfs.attributes(filename), 'should have saved macro')
	test.assert(select_filename.args[1].dir:match('[/\\]macros$'), 'should have prompted in macro dir')
end)

test('macros.load should load (not run) macro from a given filename', function()
	record(function() test.type(' ') end)
	buffer:undo()
	textadept.macros.save('load')
	local _<close> = test.defer(function() os.remove(_USERHOME .. '/macros/load') end)

	textadept.macros.load('load')

	test.assert_equal(buffer.length, 0)
end)

test('macros.load should prompt for a filename if none was given', function()
	local filename, _<close> = test.tempfile()
	local select_filename = test.stub(filename)
	local _<close> = test.mock(ui.dialogs, 'open', select_filename)

	textadept.macros.load()

	test.assert(select_filename.args[1].dir:match('[/\\]macros$'), 'should have prompted in macro dir')
end)

test('macros.load should store previous macro in register 0', function()
	local filename, _<close> = test.tempfile()
	record(function() test.type(' ') end)

	textadept.macros.load(filename)

	textadept.macros.play('0')

	test.assert_equal(buffer:get_text(), '  ')
end)
