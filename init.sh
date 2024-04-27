
#!/bin/bash
npm update
npm install hexo-cli -g
npm install --save
npm i hexo -g
hexo clean
hexo generate

# 遍历所有子模块，更新至最新提交
git submodule foreach --recursive 'git checkout master && git pull origin master'

# 在主仓库中添加和提交更新后的子模块
git add .
git commit -m "Automatically update all submodules to latest commits"
git push