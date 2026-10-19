# /// script
# dependencies = [
#   "pymysql>=1.1.0",
# ]
# ///

from __future__ import annotations

import argparse
import sys

from _mysql_common import create_connection, load_mysql_config


def list_tables() -> str:
    config = load_mysql_config()
    connection = create_connection(config)
    try:
        with connection.cursor() as cursor:
            cursor.execute("SHOW TABLES")
            tables = cursor.fetchall()

        if not tables:
            return "数据库中没有找到任何表"

        table_names = []
        for table in tables:
            table_name = list(table.values())[0]
            table_names.append(table_name)

        all_table_names = "\n".join(table_names)
        result = f"数据库中的表:\n{all_table_names}"
        if db_note := config.get("description"):
            result = f"数据库说明: {db_note}\n\n" + result
        return result
    finally:
        connection.close()


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="列出当前 MySQL 数据库中的所有表")
    return parser.parse_args()


def main() -> int:
    parse_args()
    try:
        print(list_tables())
        return 0
    except Exception as exc:
        print(f"获取表名失败: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
