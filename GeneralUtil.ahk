GetParentDir(dir) {
    return SubStr(dir, 1, InStr(SubStr(dir,1,-1), "\", 0, 0)-1)
}

PrintDirectory(dir) {
    FileList := ""  ; Initialize an empty string to store the file names

    Loop, %dir%\*.*
    {
        FileList .= A_LoopFileName . "`n"  ; Concatenate each file name with a newline character
    }

    MsgBox % "Files in " . dir . "`n`n" . FileList  ; Display all file names in a single MsgBox
}

PrintIncludedFiles(arrFiles) {
    Loop, % arrFiles.MaxIndex()
    {
        filePath := arrFiles[A_Index]
        FileRead, fileContents, %filePath%
        MsgBox % "File: " filePath "`nContents:`n" fileContents
    }
}
