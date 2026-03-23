@echo off
echo ========================================
echo    福利彩票查询小程序 - 自动创建脚本
echo ========================================
echo.

REM 创建目录结构
echo [1/4] 创建目录结构...
mkdir miniprogram
mkdir miniprogram\images
mkdir miniprogram\pages
mkdir miniprogram\pages\index
mkdir miniprogram\pages\scan
mkdir miniprogram\pages\result
mkdir miniprogram\pages\history
mkdir miniprogram\pages\admin
mkdir miniprogram\components
mkdir miniprogram\components\lottery-ball
mkdir cloudfunctions
mkdir cloudfunctions\ocrLottery
mkdir cloudfunctions\ocrLottery\utils
mkdir cloudfunctions\ocrLottery\libs
mkdir cloudfunctions\queryLottery
mkdir cloudfunctions\initData
mkdir cloudfunctions\getOpenId

echo [2/4] 创建配置文件...

REM 创建 project.config.json
(
echo {
echo   "description": "福利彩票中奖查询小程序",
echo   "packOptions": {
echo     "ignore": [],
echo     "include": []
echo   },
echo   "setting": {
echo     "urlCheck": true,
echo     "es6": true,
echo     "enhance": true,
echo     "postcss": true,
echo     "minified": true,
echo     "newFeature": true
echo   },
echo   "compileType": "miniprogram",
echo   "libVersion": "2.25.4",
echo   "appid": "你的AppID",
echo   "projectname": "lottery-checker",
echo   "condition": {},
echo   "cloudfunctionRoot": "cloudfunctions/"
echo }
) > project.config.json

echo [3/4] 创建小程序核心文件...

REM 创建 app.js
(
echo App({
echo   onLaunch^(^) {
echo     if ^(!wx.cloud^) {
echo       console.error^('请使用 2.2.3 或以上的基础库'^);
echo     } else {
echo       wx.cloud.init^({
echo         env: '你的环境ID',
echo         traceUser: true
echo       }^);
echo     }
echo     this.getOpenId^(^);
echo   },
echo
echo   async getOpenId^(^) {
echo     try {
echo       const res = await wx.cloud.callFunction^({
echo         name: 'getOpenId'
echo       }^);
echo       this.globalData.openid = res.result.openid;
echo     } catch ^(err^) {
echo       console.error^('获取OpenID失败:', err^);
echo     }
echo   },
echo
echo   globalData: {
echo     openid: '',
echo     lotteryTypes: {
echo       ssq: { name: '双色球', redMin: 1, redMax: 33, blueMin: 1, blueMax: 16 },
echo       dlt: { name: '大乐透', frontMin: 1, frontMax: 35, backMin: 1, backMax: 12 },
echo       qlc: { name: '七乐彩', redMin: 1, redMax: 30 }
echo     }
echo   }
echo }^);
) > miniprogram\app.js

echo [4/4] 完成！
echo.
echo ========================================
echo    项目创建成功！
echo    请使用微信开发者工具打开此目录
echo ========================================
pause
