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

# Ghost webhook verification needs the raw JSON body for HMAC. BodyReader
# wraps `ActivityPub.Web.Plugs.DigestPlug.read_body/2` (so AP digests keep
# working) and stashes the raw body on JSON requests.
config :bonfire_ui_common,
       :body_reader,
       {Bonfire.Ghost.BodyReader, :read_body, []}
