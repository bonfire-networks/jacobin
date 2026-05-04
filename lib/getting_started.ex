defmodule Jacobin.GettingStarted do
  @moduledoc """
  Detectors for the Jacobin flavour's "Getting Started" widget.

  Wired in via flavour config — see
  `Bonfire.UI.Social.WidgetGettingStartedLive` and `config/jacobin.exs`.
  """

  alias Bonfire.Common.Utils

  @doc "True once the user follows at least `n` other accounts."
  def followed_at_least?(nil, _n), do: false

  def followed_at_least?(user, n) when is_integer(n) and n > 0 do
    case Utils.maybe_apply(
           Bonfire.Social.Graph.Follows,
           :all_by_subject,
           [user, [limit: n]],
           fallback_return: []
         ) do
      list when is_list(list) -> length(list) >= n
      _ -> false
    end
  end

  @doc "True once the user follows at least 5 other accounts."
  def followed_five?(user), do: followed_at_least?(user, 5)
end
