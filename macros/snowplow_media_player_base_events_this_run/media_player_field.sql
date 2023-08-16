{% macro media_player_field(v1, v2, default='null') %}
    coalesce(
      {% if var("snowplow__enable_media_player_v2") -%}
        {{ field(
          v2,
          col_prefix='contexts_com_snowplowanalytics_snowplow_media_player_2'
        ) }}
      {%- else -%}
        null
      {%- endif %},
      {%- if v1 is not none and var("snowplow__enable_media_player_v1") -%}
        {{ field(
          v1,
          col_prefix='contexts_com_snowplowanalytics_snowplow_media_player_1'
        ) }}
      {%- else -%}
        null
      {%- endif %},
      {{ default }}
    )
{% endmacro %}
