[![early-release]][tracker-classificiation] [![License][license-image]][license] [![Discourse posts][discourse-image]][discourse]

![snowplow-logo](https://raw.githubusercontent.com/snowplow/dbt-snowplow-utils/main/assets/snowplow_logo.png)

# dbt-snowplow-media-player

A fully incremental model that transforms media player event data into derived tables for easier querying generated by the Snowplow [JavaScript tracker][javascript-tracker] in combination with media tracking specific plugins such as the [Media Tracking plugin][media-tracking] or the [YouTube Tracking plugin][youtube-tracking]. The package is built on top of the [dbt-snowplow-web package][dbt-snowplow-web] taking that as a basis to carry out the incremental update. It is therefore designed to be run together with the web model very similar to how a custom module would run.

Please refer to the [doc site][snowplow-media-player-docs] for a full breakdown of the package.

### Adapter Support

The snowplow-media-player v0.4.2 package currently supports the following adapters:

|                       Warehouse                      |     dbt versions    | snowplow-web version | snowplow-media-player version |
|:----------------------------------------------------:|:-------------------:|:--------------------:|:-----------------------------:|
| BigQuery, Databricks, Postgres, Redshift & Snowflake |  >=1.3.0 to <2.0.0  |  >=0.13.0 to <0.14.0 |              0.4.2            |
| BigQuery, Databricks, Postgres, Redshift & Snowflake |  >=1.0.0 to <1.3.0  |  >=0.10.0 to <0.12.0 |              0.3.4            |
|                   Redshift & Postgres                | >=0.20.0 to <1.1.0  |  >=0.6.0 to <0.7.0   |              0.1.0            |


### Requirements

- A dataset of media-player web events from the [Snowplow JavaScript tracker][tracker-docs] must be available in the database. In order for this to happen at least one of the JavaScript based media tracking plugins need to be enabled: [Media Tracking plugin][media-tracking] or [YouTube Tracking plugin][youtube-tracking]
- Have the [`webPage` context][webpage-context] enabled.
- Have the [media-player event schema][media-player-event-schema] enabled.
- Have the [media-player context schema][media-player-context-schema] enabled.
- Depending on the plugin / intention have all the relevant contexts from below enabled:
  - in case of embedded YouTube tracking: Have the [YouTube specific context schema][youtube-specific-context-schema] enabled.
  - in case of HTML5 audio or video tracking: Have the [HTML5 media element context schema][html5-media-element-context-schema] enabled.
  - in case of HTML5 video tracking: Have the [HTML5 video element context schema][html5-video-element-context-schema] enabled.

### Installation

Check dbt Hub for the latest installation instructions, or read the [dbt docs][dbt-package-docs] for more information on installing packages.

### Configuration & Operation

Please refer to the [doc site][snowplow-media-player-docs] for extensive details on how to configure and run the package.

### Models

The package contains multiple staging models however the mart models are as follows:

| Model                                    | Description                                                                                |
|------------------------------------------|--------------------------------------------------------------------------------------------|
| snowplow_media_player_base               | A table summarising media player events by media and pageview including impressions.       |
| snowplow_media_player_plays_by_pageview  | A view summarising media plays by media on a pageview level.                               |
| snowplow_media_player_media_stats        | An aggregated table of media metrics on a media_id level.                                  |

Please refer to the [dbt doc site][snowplow-media-player-docs-dbt] for details on the model output tables.

# Join the Snowplow community

We welcome all ideas, questions and contributions!

For support requests, please use our community support [Discourse][discourse] forum.

If you find a bug, please report an issue on GitHub.

# Copyright and license

The snowplow-media-player package is Copyright 2022-2023 Snowplow Analytics Ltd.

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[license]: http://www.apache.org/licenses/LICENSE-2.0
[license-image]: http://img.shields.io/badge/license-Apache--2-blue.svg?style=flat
[tracker-classificiation]: https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/tracker-maintenance-classification/
[early-release]: https://img.shields.io/static/v1?style=flat&label=Snowplow&message=Early%20Release&color=014477&labelColor=9ba0aa&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAeFBMVEVMaXGXANeYANeXANZbAJmXANeUANSQAM+XANeMAMpaAJhZAJeZANiXANaXANaOAM2WANVnAKWXANZ9ALtmAKVaAJmXANZaAJlXAJZdAJxaAJlZAJdbAJlbAJmQAM+UANKZANhhAJ+EAL+BAL9oAKZnAKVjAKF1ALNBd8J1AAAAKHRSTlMAa1hWXyteBTQJIEwRgUh2JjJon21wcBgNfmc+JlOBQjwezWF2l5dXzkW3/wAAAHpJREFUeNokhQOCA1EAxTL85hi7dXv/E5YPCYBq5DeN4pcqV1XbtW/xTVMIMAZE0cBHEaZhBmIQwCFofeprPUHqjmD/+7peztd62dWQRkvrQayXkn01f/gWp2CrxfjY7rcZ5V7DEMDQgmEozFpZqLUYDsNwOqbnMLwPAJEwCopZxKttAAAAAElFTkSuQmCC

[tracker-docs]: https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/

[webpage-context]: https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/javascript-trackers/javascript-tracker/javascript-tracker-v3/tracker-setup/initialization-options/#Adding_predefined_contexts

[media-player-event-schema]: https://github.com/snowplow/iglu-central/blob/master/schemas/com.snowplowanalytics.snowplow/media_player_event/jsonschema/1-0-0
[media-player-context-schema]: https://github.com/snowplow/iglu-central/blob/master/schemas/com.snowplowanalytics.snowplow/media_player/jsonschema/1-0-0
[youtube-specific-context-schema]: https://github.com/snowplow/iglu-central/blob/master/schemas/com.youtube/youtube/jsonschema/1-0-0
[html5-media-element-context-schema]: https://github.com/snowplow/iglu-central/blob/master/schemas/org.whatwg/media_element/jsonschema/1-0-0
[html5-video-element-context-schema]: https://github.com/snowplow/iglu-central/blob/master/schemas/org.whatwg/video_element/jsonschema/1-0-0

[media-tracking]: https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/javascript-trackers/javascript-tracker/javascript-tracker-v3/plugins/media-tracking/

[javascript-tracker]: https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/javascript-trackers/javascript-tracker/javascript-tracker-v3

[youtube-tracking]: https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/javascript-trackers/javascript-tracker/javascript-tracker-v3/plugins/youtube-tracking/

[dbt-package-docs]: https://docs.getdbt.com/docs/building-a-dbt-project/package-management

[discourse-image]: https://img.shields.io/discourse/posts?server=https%3A%2F%2Fdiscourse.snowplow.io%2F
[discourse]: http://discourse.snowplow.io/

[dbt-snowplow-web]: https://hub.getdbt.com/dbt-labs/snowplow/latest/

[snowplow-media-player-docs-dbt]: https://snowplow.github.io/dbt-snowplow-media-player/#!/overview/snowplow_media_player
[snowplow-media-player-docs]: https://docs.snowplow.io/docs/modeling-your-data/modeling-your-data-with-dbt/
