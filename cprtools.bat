@echo off
cd /d %~dp0
if "%1" == "new" (
    rem cprtools new aoj 0000
    if "%2" == "aoj" (
        if exist aoj%3 (
            rem 既にフォルダが存在
            echo error: Directory "aoj%3" already exists.
        ) else (
            mkdir AOJ%3\.vscode
            copy _template\source.cpp AOJ%3\
            copy _template\.vscode\* AOJ%3\.vscode\
            echo set CPR_TYPE=aoj>AOJ%3\settings.bat
            echo set CPR_AOJ_NUM=%3>>AOJ%3\settings.bat
            echo set CPR_SOLVED=false>>AOJ%3\settings.bat
        )
    )
)
if "%1" == "show" (
    rem cprtools show DIR [BROWSER]
    if not exist %2 (
        echo error: Directory "%2" does not exist.
    ) else (
        cd %2
        call settings.bat
        if "%CPR_TYPE%" == "aoj" (
            if "%3" == "" (
                chrome http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=%CPR_AOJ_NUM%
            ) else (
                %3 http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=%CPR_AOJ_NUM%
            )
        )
        cd %~dp0
    )
)
if "%1" == "open" (
    rem cprtools open DIR [EDITOR]
    if not exist %2 (
        echo error: Directory "%2" does not exist.
    ) else (
        cd %2
        call settings.bat
        if "%CPR_TYPE%" == "aoj" (
            if "%3" == "" (
                code .
            ) else (
                if "%3" == "code" (
                    code .
                ) else (
                    %3 source.cpp
                )
            )
        )
        cd %~dp0
    )
)
if "%1" == "cd" (
    cd %2
)
if "%1" == "mark" (
    rem cprtools mark DIR solved|unsolved
    if not exist %2 (
        echo error: Directory "%2" does not exist.
    ) else (
        cd %2
        if "%3" == "solved" (
            echo set CPR_SOLVED=true
        )
        if "%3" == "unsolved" (
            echo set CPR_SOLVED=false
        )
        cd %~dp0
    )
)