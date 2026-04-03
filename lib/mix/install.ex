defmodule Mix.Tasks.Jacobin.Install do
  use Igniter.Mix.Task
  alias Bonfire.Common.Mix.Tasks.Helpers

  @shortdoc "Install the Jacobin flavour into the parent app"
  @doc """
  Usage:
  `just mix jacobin.install`
  """

  @app :jacobin

  def igniter(igniter) do
    app_dir = Application.app_dir(@app)

    igniter
    # first we install Community since this flavour extends that one
    |> Igniter.compose_task(Mix.Tasks.Community.Install, [])
    # then we run custom tasks for this flavour
    |> Helpers.igniter_copy(Path.join(app_dir, "priv/templates/lib/"), "lib/")
    |> Helpers.igniter_copy(
      Path.wildcard(Path.join(app_dir, "deps.*")),
      "config/current_flavour/"
    )
    # finally we run the standard installer for this flavour
    |> Igniter.compose_task(Mix.Tasks.Bonfire.Extension.Installer, [@app])
  end
end
