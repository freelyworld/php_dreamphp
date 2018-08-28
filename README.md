## 介绍

一个简洁、高性能、跨平台的 PHP7 代码加密扩展，当前版本为 0.2.2

## 特点

- 简单快速，经实测，几乎不影响性能
- 兼容 OPcache、Xdebug 等其他扩展
- 兼容 Linux、macOS、Windows 等系统
- 兼容 Apache、Nginx + PHP-fpm、命令行等运行模式
- 加密算法较简单，这是出于速度考虑，但仍不易解密
- 若项目的 php 文件很多，建议只加密部分重要代码文件
- 要求 PHP >= 7.0

**加密前记得备份!!!**

## 安装

编译前请在 core.h 中做如下修改:
```c
/* 这里定制你的加密特征头，不限长度，十六进制哦 */
const u_char tonyenc_header[] = {
        0x66, 0x88, 0xff, 0x4f,
        0x68, 0x86, 0x00, 0x56,
        0x11, 0x16, 0x16, 0x18,
};

/* 这里指定密钥，长一些更安全 */
const u_char tonyenc_key[] = {
        0x9f, 0x49, 0x52, 0x00,
        0x58, 0x9f, 0xff, 0x21,
        0x3e, 0xfe, 0xea, 0xfa,
        0xa6, 0x33, 0xf3, 0xc6,
};
```

#### 在 Linux、macOS 上编译
```
git clone https://github.com/freelyworld/php_dreamphp.git
cd php_dreamphp
phpize
./configure
make
```
将编译好的文件 modules/php_dreamphp.so 加入到配置项 extension=php_dreamphp.so，重启 PHP 服务

#### 在 Windows 上编译

vs2015 迅雷下载链接（ed2k://|file|cn_visual_studio_community_2015_x86_dvd_6847368.iso|4013920256|EB7F6605EDE67509E218E29173AC6574|/
）

已编译了以下模块，可供测试（这里的密钥与源代码中的不同，需要安装有 [VC14 运行库](https://www.microsoft.com/zh-CN/download/details.aspx?id=48145)）:
```bash
# php7.0 64位 线程安全版
php_dreamphp_php70_ts_VC14_x64.dll
# php7.0 64位 线程非安全版
php_dreamphp_php70_nts_VC14_x64.dll
```
===============================================================
环境准备

PHP7 是由 VC14（也就是 Visual Studio 2015） 编译的，所以运行它之前需要安装 VC14 运行库，编译它则需要安装 Visual Studio 2015。

需要从 官网 下载 PHP7 的源代码包和已编译的 PHP 程序，再分别解压，得到两个目录(假设在 C 盘)：

C:\php7-src
C:\php7-Win32-VC14-x64-ts
如何编译

1）拿到要编译的代码
  1.1、在 VS 2015 菜单中选择「文件」-「新建」-「从现有代码创建项目」。
  1.2、然后在弹出窗口中选择你要编译的代码，类型选择「动态库(dll)」。

2）此时 VS 2015 打开了项目，
  2.1、把工具栏中的「Debug」改为「Release」，
  2.2、在菜单中选择「项目」-「属性」。然后在弹出窗口的左侧「常规」栏目下，「配置类型」选择为「动态库(.dll)」：


3）然后在左侧「C/C++」-「常规」栏目下，「附加包含目录」中，加入：

C:\php7-src\php-7.1.21-src
C:\php7-src\php-7.1.21-src\main
C:\php7-src\php-7.1.21-src\TSRM
C:\php7-src\php-7.1.21-src\Zend
4）接着在左侧「C/C++」-「预处理器」栏目下，「预处理器定义」中，加入：

ZEND_DEBUG=0
PHP_EXTENSION
PHP_WIN32
ZEND_WIN32
HAVE_XXX=1
COMPILE_DL_XXX
ZTS

注意:
  1、要把上面的 XXX 改为大写的扩展名 (如扩展叫 dreamphp 就把 XXX 改成 DREAMPHP)，否则 PHP 将无法识别扩展。
  2、ZTS用于告诉编译器开启线程安全（如果去掉就是不开启）。
  3、线程安全的开启与否，取决于前面下载到的 C:\php7-Win32-VC14-x64-ts，它也是启用了线程安全编译，所以这里开启线程安全。

5）在左侧「连接器」-「输入」栏目下，「附加依赖项目」中，加入：C:\php7-Win32-VC14-x64-ts\dev\php7ts.lib，即前面下载得到的已编译的 PHP 程序。

6）点确定，然后菜单中选择「生成」-「生成解决方案」，恭喜你，编译器报错：无法打开包括文件 ../main/config.w32.h，这时把 C:\php7-Win32-VC14-x64-ts\win32\build\config.w32.h.in 复制到 C:\php7-Win32-VC14-x64-ts\main\config.w32.h (注意没有了后面的 in)，然后在 config.w32.h 中加入：

#define PHP_COMPILER_ID "VC14"
这将指明运行库是 VC14，与前面下载到的已编译 PHP 程序匹配，重新生成下解决方案，这样就能成功编译了！

===============================================================

## 加密

代码中的 `dreamphp.php` 是加密工具:
```bash
php dreampphp.php example.php dir/
```
这样即可加密 `example.php` 和 `dir` 目录下的所有 php 文件，PHP 在运行它们时会自动解密，够简单吧！

## 版权

允许转载、修改、商用，请注明原作者及网址：参照 Tony (http://htmln.com/)

这是我开发的第一个扩展，如有不足欢迎指正 :)
