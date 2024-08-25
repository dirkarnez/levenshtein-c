levenshtein-c
=============
From [juanmirocks/Levenshtein-MySQL-UDF: General Levenshtein algorithm and k-bounded Levenshtein distance in linear time and constant space. Implementation in C as UDFs for MySQL🐬 and MariaDB🦭](https://github.com/juanmirocks/Levenshtein-MySQL-UDF)

### TODOs
- [ ] split to modules with CMake
- [ ] check what version range is supported, and do matrix-build
    - old version do `apt install libmariadb3 libmariadb-dev` instead of build [mariadb-corporation/mariadb-connector-c](https://github.com/mariadb-corporation/mariadb-connector-c) from source
- [ ] run test case
- [ ] Make more modules (string functions)
- [ ] Windows built
- [ ] php eloquent sample
- [ ] go gorm sample

### Notes
- **DO NOT COMPILE .SO IN PRODUCTION DATABASE. USE DOCKER / VMs THAT HAS SAME VERSION OF DB TO BUILD**

### UDF templates
- [UDF Repository for MySQL](https://github.com/mysqludf)
    - [mysqludf/lib_mysqludf_ta: MySQL udf library for technical analysis](https://github.com/mysqludf/lib_mysqludf_ta)
    - [mysqludf/lib_mysqludf_preg: Use PCRE regular expressions directly in MySQL](https://github.com/mysqludf/lib_mysqludf_preg)
    - [mysqludf/lib_mysqludf_sys: A UDF library with functions to interact with the operating system. These functions allow you to interact with the execution environment in which MySQL runs.](https://github.com/mysqludf/lib_mysqludf_sys)
    - [**mysqludf/lib_mysqludf_skeleton: MySQL UDF skeleton project**](https://github.com/mysqludf/lib_mysqludf_skeleton)

### Tutorials
- [Configuring MariaDB Connector/C with Option Files - MariaDB Knowledge Base](https://mariadb.com/kb/en/configuring-mariadb-connectorc-with-option-files/#plugin-dir)
- [Server System Variables - MariaDB Knowledge Base](https://mariadb.com/kb/en/server-system-variables/#plugin_dir)
- [MySQL的GRANT命令（创建用户） - 选择了就坚持 - 博客园](https://www.cnblogs.com/perseverancevictory/p/4223867.html)
- [CREATE FUNCTION UDF - MariaDB Knowledge Base](https://mariadb.com/kb/en/create-function-udf/)
- [mariadb - Mysql sys_exec Can't open shared library 'lib_mysqludf_sys.so' (errno: 11, wrong ELF class: ELFCLASS32) - Stack Overflow](https://stackoverflow.com/questions/55241615/mysql-sys-exec-cant-open-shared-library-lib-mysqludf-sys-so-errno-11-wrong)
- [mysql udf提权 - 浅易深 - 博客园](https://www.cnblogs.com/02SWD/p/15858250.html)
- [处理mysql报错: Can't open shared library 和 No paths allowed for shared library-CSDN博客](https://blog.csdn.net/ohaozy/article/details/106079699) 
### MariaDB 10
- No need to build [mariadb-corporation/mariadb-connector-c](https://github.com/mariadb-corporation/mariadb-connector-c) from source. Just do `apt install libmariadb3 libmariadb-dev`
- Compilation should be: `gcc -DHAVE_DLOPEN -DSTANDARD -o levenshtein.so -shared -fPIC levenshtein.c `/usr/bin/mariadb_config --include`
- `stdlib.h` is added in [levenshtein.c](./levenshtein.c)
- If root-installed MariaDB, run:
  - ```sh
    cp levenshtein.so `/usr/bin/mariadb_config --plugindir` # You may need sudo
    ```
- If non-root-installed MariaDB, run:
  - ```sql
    show variables like 'plugin_dir'
    ```
    to check plugin location, normally it is `/usr/lib/mysql/plugin/`
    - `cp levenshtein.so /usr/lib/mysql/plugin/`
- From [Unable to create function after compiling library: Error: Can't find symbol 'levenshtein' in library · Issue #20 · juanmirocks/Levenshtein-MySQL-UDF](https://github.com/juanmirocks/Levenshtein-MySQL-UDF/issues/20)
- Grant rights if needed
  - `GRANT INSERT, DELETE, DROP ROUTINE, CREATE ROUTINE, ALTER ROUTINE, EXECUTE ON mysql.* TO 'user'@'%';`
    - may not work for non-root users (does not work in dockerized MariaDB 10 at least)
    - need more Googling
### Reference
- [MySQL :: MySQL 8.4 Reference Manual :: 6.7.1 mysql_config — Display Options for Compiling Clients](https://dev.mysql.com/doc/refman/8.4/en/mysql-config.html)
- [Install MariaDB Connector/C — MariaDB Documentation](https://mariadb.com/docs/server/connect/programming-languages/c/install/#Install_on_Debian,_Ubuntu)
