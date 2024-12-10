
{{
    config(
        materialized='incremental',
        unique_key='id'
    )
}}
--select * from raw_data.raw.employee_details
select * from {{source('employee','employee_details')}}

{% if is_incremental() %}
 where received_at > (select max(received_at) from {{ this }})
{% endif %}