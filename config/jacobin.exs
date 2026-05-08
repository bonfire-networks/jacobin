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
# Each entry is either a key from
# `Bonfire.UI.Social.WidgetGettingStartedLive.actions_registry/0` or a custom
# spec map (see that module's @moduledoc). Manual completion (`Mark done`)
# is always available, so steps without an auto-detector still work.
config :bonfire_ui_social, Bonfire.UI.Social.WidgetGettingStartedLive,
  actions: [
    %{
      key: :profile,
      title: "Complete your profile",
      rationale: "Letting people see who you are makes following you a real choice.",
      cta_label: "Edit your profile",
      cta_path: "/settings/",
      done?: &Bonfire.UI.Social.WidgetGettingStartedLive.profile_complete?/1
    },
    %{
      key: :first_post,
      title: "Make your first post",
      rationale: "Your voice is what makes the feed worth coming back to.",
      cta_label: "Compose a post",
      cta_kind: :composer,
      done?: &Bonfire.UI.Social.WidgetGettingStartedLive.has_posted?/1
    },
    %{
      key: :follow_five,
      title: "Follow five people",
      rationale: "Your feed comes alive once you follow a few people.",
      cta_label: "Find people",
      cta_path: "/users",
      done?: &Jacobin.GettingStarted.followed_five?/1
    },
    %{
      key: :read_coc,
      title: "Read the Code of Conduct",
      rationale: "A short read so you know what to expect from the community.",
      cta_label: "Open the Code of Conduct",
      cta_path: "/conduct"
    },
    %{
      key: :wishes,
      title: "Tell us about your wishes",
      rationale: "Help us shape what comes next — your input drives the roadmap.",
      cta_label: "Share your wishes",
      # TODO: replace placeholder with the real form URL once decided
      cta_path: "https://example.com/wishes"
    }
  ]

# Ghost webhook verification needs the raw JSON body for HMAC. BodyReader
# wraps `ActivityPub.Web.Plugs.DigestPlug.read_body/2` (so AP digests keep
# working) and stashes the raw body on JSON requests.
config :bonfire_ui_common,
       :body_reader,
       {Bonfire.Ghost.BodyReader, :read_body, []}
