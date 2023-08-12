#SingleInstance, force

debug(variable) {
    FileAppend %variable%`n, Debug.txt
    if !WinExist("Debug - Notepad")
        Run Debug.txt
}

/*
EXAMPLES

infile := FileOpen(A_Desktop "\Debug.txt", "r")
list := StrSplit(infile.read(), "`n")

path := A_ScriptDir "\Settings.txt"
FileAppend, sometext, %path%
run % path

*/