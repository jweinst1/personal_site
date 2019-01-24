echo "updating the site"
hexo generate
hexo deploy
git add .
git commit -m "site update at `date`"
git push
echo "Finished updating the deployed site and dev site repo"
