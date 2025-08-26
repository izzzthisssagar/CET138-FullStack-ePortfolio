#!/bin/bash

# CET138 Portfolio Deployment Script
# This script updates all deployment platforms

echo "🚀 Starting CET138 Portfolio Deployment..."

# 1. Update GitHub (this triggers Netlify and Vercel)
echo "📝 Updating GitHub repository..."
git add .
git commit -m "Update portfolio content - $(date)"
git push origin main

# 2. Update Surge.sh
echo "🌊 Deploying to Surge.sh..."
surge . cet138-sagar-thapa-portfolio.surge.sh

# 3. Update Firebase
echo "🔥 Deploying to Firebase..."
firebase deploy

echo "✅ Deployment complete!"
echo ""
echo "🌐 Your portfolio is now live on:"
echo "   • GitHub Pages: https://izzzthisssagar.github.io/CET138-FullStack-ePortfolio/"
echo "   • Netlify: https://cet138-sagar-thapa.netlify.app/"
echo "   • Vercel: https://cet138-fullstack-eportfolio.vercel.app/"
echo "   • Surge.sh: https://cet138-sagar-thapa-portfolio.surge.sh/"
echo "   • Firebase: https://cet138-eportfolio.web.app/"
