# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"


###*
# Sets the cursor blink period on the given editor
#
# @param  {TextEditor} editor Editor on which to set blink period
# @param  {integer}    period Cursor blink period (in milliseconds)
# @return {boolean}            True if the cursor blink period was set successfully
###
setCursorBlinkPeriod = (editor, period) ->
    editorView = atom.views.getView(editor)
    editorPresenter = editorView?.component?.presenter
    return false unless editorPresenter?
    editorPresenter.stopBlinkingCursors(true)
    editorPresenter.cursorBlinkPeriod = period
    editorPresenter.startBlinkingCursors()
    true


atom.workspace.observeTextEditors (editor) ->
  setCursorBlinkPeriod(editor, 1000)
