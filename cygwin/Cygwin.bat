@echo off

D:
chdir D:\cygwin

start .\bin\mintty -i Cygwin.ico -h never -w full --class Cygwin .\bin\bash --login -i

