
# To build the samples type "make -f win32.mak"

DMD = dmd

targets : sample.exe layout.exe topgroup.exe \
  widgets.exe menus.exe painting.exe sdialog.exe sdialog2.exe \
  idle.exe

.d.exe : 
	$(DMD) sample.def comdlg32.lib gdi32.lib ..\minwin.lib ..\app.obj -I..\.. -of$@ $< -g -version=LOG

clean:
	- del *.obj *.exe
