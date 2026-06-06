
@echo off
chcp 65001 > nul
echo [프로젝트 정리] 불필요한 폴더 및 하위 항목을 삭제합니다...

:: 배치파일이 있는 위치를 현재 디렉토리로 설정
cd /d "%~dp0"

:: out 폴더가 존재하면 삭제 진행
if exist "out" (
    rmdir /s /q "out"
    echo out 폴더가 성공적으로 삭제되었습니다.
) else (
    echo 삭제할 out 폴더가 존재하지 않습니다.
)

pause
