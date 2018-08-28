<?php

/**
 * dreamphp.php: Encrypt or decrypt the script with dreamphp.
 *
 * A high performance and cross-platform encrypt extension for PHP source code.
 *
 * @author:  freelyworld
 * @site:    www.freelyworld.com
 * @github:  github.com/freelyworld/php_dreamphp
 */


if (version_compare(PHP_VERSION, 7, '<'))
    die("PHP must later than version 7.0\n");
if (php_sapi_name() !== 'cli')
    die("Must run in cli mode\n");
if (!extension_loaded('dreamphp'))
    die("The extension: 'dreamphp' not loaded\n");
if ($argc <= 1)
    die("\nusage: php dreamphp.php file.php ...     encrypt the php file(s) or directory(s)\n\n");



array_shift($argv);
foreach ($argv as $fileName) {
    if (is_file($fileName)) {
        handle($fileName);
    } elseif (is_dir($fileName)) {
        $DirectoriesIt = new RecursiveDirectoryIterator($fileName, FilesystemIterator::SKIP_DOTS);
        $AllIt         = new RecursiveIteratorIterator($DirectoriesIt);
        $it            = new RegexIterator($AllIt, '/^.+\.php$/i', RecursiveRegexIterator::GET_MATCH);
        foreach ($it as $v)
            handle($v[0]);
    } else {
        echo "Unknowing file: '$fileName'\n";
    }
}


function handle($file)
{
    if ($fp = fopen($file, 'rb+') and $fileSize = filesize($file)) {
        $data = dreamphp_encode(fread($fp, $fileSize));
        if ($data !== false) {
            if (file_put_contents($file, '') !== false) {
                rewind($fp);
                fwrite($fp, $data);
            }
        }
        fclose($fp);
    }
}

