#!/bin/bash

# 定义源目录和目标目录
SOURCE_DIR="articles"
TARGET_DIR="source/_posts"

# 检查目标目录是否存在，如果不存在则创建
[ ! -d "$TARGET_DIR" ] || rm $TARGET_DIR -rf
[ ! -d "$TARGET_DIR" ] && mkdir -p "$TARGET_DIR"

# 遍历源目录中的所有子目录
for dir in $SOURCE_DIR/*; do
    if [ -d "$dir" ]; then  # 确保是目录
        # 复制子目录和文件到目标目录，排除 .git 和 .github 目录
        for item in "$dir"/*; do
            # 检查是否为需要排除的目录
            if [[ "$item" =~ .*/(.git|.github)$ ]]; then
                continue
            fi
            # 确定目标路径
            base_item=$(basename "$item")
            if [ -d "$item" ]; then
                # 如果是目录，确保目标目录存在
                mkdir -p "$TARGET_DIR/$base_item"
                # 复制目录内容
                cp -r "$item"/* "$TARGET_DIR/$base_item/"
            else
                # 如果是文件，直接复制到目标目录
                cp -r "$item" "$TARGET_DIR/"
            fi
        done
    fi
done

echo "Files and subdirectories have been copied to $TARGET_DIR, excluding .git and .github directories."

