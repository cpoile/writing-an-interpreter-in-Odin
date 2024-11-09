@echo off

if not exist c:\Users\Chris\git\odin\writing_an_interpreter\build mkdir c:\Users\Chris\git\odin\writing_an_interpreter\build

odin build c:\Users\Chris\git\odin\writing_an_interpreter\ -out:c:\Users\Chris\git\odin\writing_an_interpreter\build\interpreter.exe -o:none -debug
