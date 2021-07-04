/* 2> nul:
@echo off

rem   C sharp scripting batch file
rem   This script generates a .exe file which will launch a batch file with the same name
rem   Purpose is to avoid temporary flash of the console window when runnning batch files

setlocal
set CURRENTPATH=%CD%
set CSBIN=rename_me.exe
set CSCOMPILER=unknown

rem # try getting latest version of compiler
cd /d C:\Windows\Microsoft.NET\Framework\v4* 2> nul:
if exist csc.exe set CSCOMPILER=%CD%\csc.exe
if exist csc.exe goto GOT_COMPILER

cd /d C:\Windows\Microsoft.NET\Framework\v3* 2> nul:
if exist csc.exe set CSCOMPILER=%CD%\csc.exe
if exist csc.exe goto GOT_COMPILER

cd /d C:\Windows\Microsoft.NET\Framework\v2* 2> nul:
if exist csc.exe set CSCOMPILER=%CD%\csc.exe

:GOT_COMPILER
cd /d %CURRENTPATH%
if not exist %CSCOMPILER% echo Dot net frameworks 4,3 and 2 does not exist!
if not exist %CSCOMPILER% goto :EOF

for /F %%i in ('DIR /B /O:D %~n0.*') do set NEWEST=%%i
if /I "%NEWEST%"=="%CSBIN%" goto GOT_EXE

%CSCOMPILER% /target:winexe /nologo /out:%CSBIN% %0
if NOT %ERRORLEVEL%==0 goto :EOF

:GOT_EXE
rem %CSBIN%
goto :eof

*/


using System;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;

class Program
{
  public static void launchBatch(string batchFile, string arguments)
  {
    Process p = new Process();
    string args = "/c " + batchFile + " " + arguments;

    p.StartInfo.UseShellExecute = false;
    p.StartInfo.RedirectStandardOutput = false;
    p.StartInfo.CreateNoWindow = true;
    p.StartInfo.FileName = "cmd.exe";
    p.StartInfo.Arguments = args;
    p.Start();
  }

  public static void Main()
  {
    string appName = System.Diagnostics.Process.GetCurrentProcess().MainModule.FileName;
    string arguments = Environment.CommandLine;
    string batchName = appName.Substring(0, appName.Length - 4) + ".cmd";

    Console.WriteLine("RUNNING: " + appName + "-> \n" + batchName);
    if (File.Exists(batchName)) {
      launchBatch(batchName, arguments);
    } else {
      MessageBox.Show("ERROR file does not exist:\n" + batchName);
    };

    // string intext = Console.ReadLine();
  }
}
