@echo off
for /R %%f in (*.int) do (
    ren %%f "*.int.bak"
)
pause