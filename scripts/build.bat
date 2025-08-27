@echo off
REM CET138 Portfolio Build Script for Windows
REM This script validates and optimizes the portfolio before deployment

echo 🔨 Starting CET138 Portfolio Build Process...

REM 1. Validate HTML files
echo 📋 Validating HTML files...
for %%f in (*.html) do (
    echo   Checking %%f...
    findstr "<!DOCTYPE html>" "%%f" >nul
    if !errorlevel! equ 0 (
        echo   ✅ %%f has valid DOCTYPE
    ) else (
        echo   ⚠️  Warning: %%f may not have proper DOCTYPE
    )
)

REM 2. Check for broken internal links
echo 🔗 Checking internal links...
for %%f in (*.html) do (
    echo   Checking links in %%f...
    findstr "href=" "%%f" | findstr "\.html" > temp_links.txt
    for /f "tokens=2 delims=href=" %%l in (temp_links.txt) do (
        set "link=%%l"
        set "link=!link:"=!"
        if not exist "!link!" (
            echo   ⚠️  Warning: Broken link to !link! in %%f
        )
    )
)

REM 3. Validate accessibility basics
echo ♿ Checking accessibility basics...
for %%f in (*.html) do (
    echo   Checking %%f for accessibility...
    findstr "<img" "%%f" >nul
    if !errorlevel! equ 0 (
        findstr "alt=" "%%f" >nul
        if !errorlevel! neq 0 (
            echo   ⚠️  Warning: Images without alt attributes found in %%f
        )
    )
    findstr "<h1" "%%f" >nul
    if !errorlevel! equ 0 (
        echo   ✅ %%f has h1 heading
    )
)

REM 4. Check images
echo 🖼️  Checking images...
if exist "images" (
    echo   Image directory found - consider optimizing images for web
)

REM 5. Create deployment manifest
echo 📄 Creating deployment manifest...
echo CET138 Portfolio Deployment Manifest > deployment-manifest.txt
echo Generated: %date% %time% >> deployment-manifest.txt
echo Files to deploy: >> deployment-manifest.txt
for %%f in (*.html) do echo   - %%f >> deployment-manifest.txt
for %%f in (*.md) do echo   - %%f >> deployment-manifest.txt

REM 6. Check file sizes
echo 📊 Checking file sizes...
for %%f in (*.html) do (
    for %%A in ("%%f") do (
        echo   %%f: %%~zA bytes
    )
)

REM 7. Validate meta tags
echo 🏷️  Checking meta tags...
for %%f in (*.html) do (
    findstr 'name="viewport"' "%%f" >nul
    if !errorlevel! equ 0 (
        echo   ✅ %%f has viewport meta tag
    ) else (
        echo   ⚠️  Warning: %%f missing viewport meta tag
    )
    
    findstr 'charset="UTF-8"' "%%f" >nul
    if !errorlevel! equ 0 (
        echo   ✅ %%f has charset meta tag
    ) else (
        echo   ⚠️  Warning: %%f missing charset meta tag
    )
)

echo ✅ Build process completed successfully!
echo 📋 Deployment manifest created: deployment-manifest.txt
echo.
echo 🚀 Ready for deployment to:
echo    • GitHub Pages
echo    • Netlify
echo    • Vercel
echo    • Surge.sh
echo    • Firebase

REM Clean up temporary files
if exist temp_links.txt del temp_links.txt

pause
