#!/bin/bash

# CET138 Portfolio Build Script
# This script validates and optimizes the portfolio before deployment

echo "🔨 Starting CET138 Portfolio Build Process..."

# Create scripts directory if it doesn't exist
mkdir -p scripts

# 1. Validate HTML files
echo "📋 Validating HTML files..."
for file in *.html; do
    if [ -f "$file" ]; then
        echo "  Checking $file..."
        # Basic HTML validation (you can add more sophisticated validation later)
        if grep -q "<!DOCTYPE html>" "$file"; then
            echo "  ✅ $file has valid DOCTYPE"
        else
            echo "  ⚠️  Warning: $file may not have proper DOCTYPE"
        fi
    fi
done

# 2. Check for broken internal links
echo "🔗 Checking internal links..."
for file in *.html; do
    if [ -f "$file" ]; then
        echo "  Checking links in $file..."
        # Extract internal links and check if files exist
        grep -o 'href="[^"]*\.html"' "$file" | sed 's/href="//;s/"//' | while read link; do
            if [ ! -f "$link" ]; then
                echo "  ⚠️  Warning: Broken link to $link in $file"
            fi
        done
    fi
done

# 3. Validate accessibility basics
echo "♿ Checking accessibility basics..."
for file in *.html; do
    if [ -f "$file" ]; then
        echo "  Checking $file for accessibility..."
        # Check for alt attributes on images
        if grep -q "<img" "$file" && ! grep -q "alt=" "$file"; then
            echo "  ⚠️  Warning: Images without alt attributes found in $file"
        fi
        # Check for proper heading structure
        if grep -q "<h1" "$file"; then
            echo "  ✅ $file has h1 heading"
        fi
    fi
done

# 4. Optimize images (if you have any)
echo "🖼️  Checking images..."
if [ -d "images" ]; then
    echo "  Image directory found - consider optimizing images for web"
fi

# 5. Create deployment manifest
echo "📄 Creating deployment manifest..."
cat > deployment-manifest.txt << EOF
CET138 Portfolio Deployment Manifest
Generated: $(date)
Files to deploy:
$(ls *.html | sed 's/^/  - /')
$(ls *.md 2>/dev/null | sed 's/^/  - /' || echo "  - No markdown files")
EOF

# 6. Check file sizes
echo "📊 Checking file sizes..."
for file in *.html; do
    if [ -f "$file" ]; then
        size=$(wc -c < "$file")
        echo "  $file: ${size} bytes"
    fi
done

# 7. Validate meta tags
echo "🏷️  Checking meta tags..."
for file in *.html; do
    if [ -f "$file" ]; then
        if grep -q '<meta name="viewport"' "$file"; then
            echo "  ✅ $file has viewport meta tag"
        else
            echo "  ⚠️  Warning: $file missing viewport meta tag"
        fi
        
        if grep -q '<meta charset="UTF-8"' "$file"; then
            echo "  ✅ $file has charset meta tag"
        else
            echo "  ⚠️  Warning: $file missing charset meta tag"
        fi
    fi
done

echo "✅ Build process completed successfully!"
echo "📋 Deployment manifest created: deployment-manifest.txt"
echo ""
echo "🚀 Ready for deployment to:"
echo "   • GitHub Pages"
echo "   • Netlify"
echo "   • Vercel"
echo "   • Surge.sh"
echo "   • Firebase"
