{% macro athena__get_tables_by_pattern_sql(schema_pattern, table_pattern, exclude='', database=target.database, schema=target.schema) %}
        select distinct
            table_schema as "table_schema",
            table_name as "table_name",
            case table_type
                when 'BASE TABLE' then 'table'
                when 'EXTERNAL TABLE' then 'external'
                when 'MATERIALIZED VIEW' then 'materializedview'
                else lower(table_type)
            end as "table_type"
        from {{ database }}.information_schema.tables
        where table_schema = '{{ schema }}'
        and table_name like '{{ table_pattern }}'
        and table_name not like '{{ exclude }}'
{% endmacro %}
