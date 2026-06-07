import Config

#### Extension-specific compile-time configuration goes here, everything else should be in `Jacobin.RuntimeConfig`

# Please note that most of these are defaults meant to be overridden by instance admins in Settings rather than edited here
config :bonfire, :ui,
  hide_app_switcher: true,
  auth: [
    email_theme: [
      primary: "#e63027",
      primary_content: "#ffffff",
      body_bg: "#fbf3e9",
      body_text: "#0a0a0a",
      muted: "#5c5c5c"
    ]
  ],
  font_family: "Lateral",
  font_families: [
    "Lateral",
    "Inter (Latin Languages)",
    "Inter (More Languages)",
    "Noto Sans (Latin Languages)",
    "Noto Sans (More Languages)",
    "Luciole",
    "OpenDyslexic"
  ],
  feed_object_extension_preloads_disabled: false,
  smart_input_activities: [
    category: "Create a topic",
    label: "New label"
  ],
  themes_light: [
    "jacobin"
  ],
  themes_dark: [
    "jacobin-dark"
  ]

config :bonfire_social, Bonfire.Social.Pins, modularity: true
config :bonfire_ui_reactions, Bonfire.UI.Reactions.PinActionLive, modularity: true

# enable marking comment as answer?
config :bonfire_social, Bonfire.Social.Answers, modularity: :disabled

# Getting-started checklist shown to new users in the sidebar widget.
# Each entry is a key from
# `Bonfire.UI.Social.WidgetGettingStartedLive.actions_registry/0`; the copy
# and completion detectors live there (in code) so they stay translatable.
# Instance-specific URLs are passed here. Manual completion (`Mark done`) is
# always available, so steps without an auto-detector still work.
config :bonfire_ui_social, Bonfire.UI.Social.WidgetGettingStartedLive,
  actions: [:profile, :first_post, :first_follow, :read_coc, :wishes],
  code_of_conduct_path: "/conduct",
  # TODO: replace placeholder with the real form URL once decided
  wishes_url: "https://example.com/wishes"

# Ghost webhook verification needs the raw JSON body for HMAC. BodyReader
# wraps `ActivityPub.Web.Plugs.DigestPlug.read_body/2` (so AP digests keep
# working) and stashes the raw body on JSON requests.
config :bonfire_ui_common,
       :body_reader,
       {Bonfire.Ghost.BodyReader, :read_body, []}
