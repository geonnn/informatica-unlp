unlp() {

	local REPO="$HOME/Documents/Repos/informatica-unlp"

	if [ $# -eq 0 ]; then
		cd "$REPO" || return
		return
	fi

	local DEST
	DEST=$(find "$REPO" -type d -name "$1" -print -quit)

	if [ -n "$DEST" ]; then
		cd "$DEST" || return
	else
		echo "No se encontró el directorio '$1'."
	fi
}
