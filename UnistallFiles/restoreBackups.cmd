for /R %%f in (*.bak) do (
    del %%~nf
    ren %%f %%~nf
)