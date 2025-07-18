// sync-notes.js
import fs from 'fs-extra'; // 使用 fs-extra 库可以方便地复制文件夹，需要先安装：npm install fs-extra
import path from 'path';
import { fileURLToPath } from 'url';

// 获取当前文件的目录路径（ES Module 中 __dirname 不可用）
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const notesSourceDir = 'D:\\曦\\个人图书馆'; // <-- **请修改为你的Obsidian笔记目录的绝对路径**
const quartzContentDir = path.join(__dirname, 'content'); // Quartz 项目中的 content 目录

async function syncNotes() {
    console.log('--- 开始同步 Obsidian 笔记到 Quartz 项目 ---');

    try {
        // 1. 清空 Quartz 的 content 目录（可选但推荐，防止旧文件残留）
        if (fs.existsSync(quartzContentDir)) {
            console.log(`清空 ${quartzContentDir}...`);
            await fs.emptyDir(quartzContentDir);
        } else {
            console.log(`创建 ${quartzContentDir}...`);
            await fs.mkdir(quartzContentDir, { recursive: true });
        }

        // 2. 复制 Obsidian 笔记到 Quartz 的 content 目录
        console.log(`从 ${notesSourceDir} 复制到 ${quartzContentDir}...`);
        await fs.copy(notesSourceDir, quartzContentDir, {
            filter: (src, dest) => {
                // 排除 Obsidian 自身的配置文件，例如 .obsidian 文件夹和 .git 文件夹
                return !src.includes('.obsidian') && !src.includes('.git');
            }
        });
        console.log('--- 笔记同步成功！ ---');
    } catch (err) {
        console.error('--- 笔记同步失败！ ---', err);
        process.exit(1); // 失败时退出，防止 Quartz 构建旧内容
    }
}

syncNotes();