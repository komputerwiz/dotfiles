# VS Code Shell Integration
test --query code
and string match --quiet "$TERM_PROGRAM" "vscode"
and source (code --locate-shell-integration-path fish)
