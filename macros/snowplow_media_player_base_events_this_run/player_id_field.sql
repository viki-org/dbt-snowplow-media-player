{#
Copyright (c) 2022-present Snowplow Analytics Ltd. All rights reserved.
This program is licensed to you under the Snowplow Personal and Academic License Version 1.0,
and you may not use this file except in compliance with the Snowplow Personal and Academic License Version 1.0.
You may obtain a copy of the Snowplow Personal and Academic License Version 1.0 at https://docs.snowplow.io/personal-and-academic-license-1.0/
#}

{% macro player_id_field(youtube_player_id, media_player_id) %}
    coalesce(
      {% if var("snowplow__enable_youtube") -%}
        {{ field(
          youtube_player_id,
          col_prefix='contexts_com_youtube_youtube_1'
        ) }}
      {%- else -%}
        {% if youtube_player_id is string and target.type not in ['postgres', 'redshift'] -%}
          {{ youtube_player_id }}
        {% elif target.type not in ['postgres', 'redshift'] %}
          cast(null as {{ youtube_player_id.get('dtype', 'string') }})
        {%- else -%}
          null
        {% endif %}
      {%- endif %},
      {% if var("snowplow__enable_whatwg_media") -%}
        {{ field(
          media_player_id,
          col_prefix='contexts_org_whatwg_media_element_1'
        ) }}
      {%- else -%}
        {% if media_player_id is string and target.type not in ['postgres', 'redshift'] -%}
          {{ media_player_id }}
        {% elif target.type not in ['postgres', 'redshift'] %}
          cast(null as {{ media_player_id.get('dtype', 'string') }})
        {%- else -%}
          null
        {% endif %}
      {%- endif %}
    )
{% endmacro %}