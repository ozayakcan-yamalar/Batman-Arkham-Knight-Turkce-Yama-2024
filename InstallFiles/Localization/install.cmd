for /R %%f in (*.tr) do (
    ren %%~nf *.int.bak
    ren %%f %%~nf
)