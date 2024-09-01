defmodule BBBcntr.Release do
  @app :bbbcntr

  def migrate(opts \\ [all: true]) do
    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, opts))
    end
  end

  def rollback(repo, version) do
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.load(@app)
    IO.inspect Application.fetch_env!(@app, :ecto_repos)
    Application.fetch_env!(@app, :ecto_repos)
  end

  @doc """
  Print the migration status for configured Repos' migrations.
  """
  def migration_status do
    print_migrations_for(Bbbcntr.Repo)
  end

  defp print_migrations_for(repo) do
    paths = repo_migrations_path(repo)

    {:ok, repo_status, _} =
      Ecto.Migrator.with_repo(repo, &Ecto.Migrator.migrations(&1, paths))

    IO.puts(
      """
      Repo: #{inspect(repo)}
        Status    Migration ID    Migration Name
      --------------------------------------------------
      """ <>
        Enum.map_join(repo_status, "\n", fn {status, number, description} ->
          "  #{pad(status, 10)}#{pad(number, 16)}#{description}"
        end) <> "\n"
    )
  end

  defp repo_migrations_path(repo) do
    config = repo.config()
    priv = config[:priv] || "priv/#{repo |> Module.split() |> List.last() |> Macro.underscore()}"
    IO.inspect config |> Keyword.fetch!(:otp_app) |> Application.app_dir() |> Path.join(priv)
    config |> Keyword.fetch!(:otp_app) |> Application.app_dir() |> Path.join(priv)
  end

  defp pad(content, pad) do
    content
    |> to_string
    |> String.pad_trailing(pad)
  end


  @doc """
  Migrate data in the database. Defaults to migrating to the latest, `[all: true]`
  Also accepts `[step: 1]`, or `[to: 20200118045751]`
  """
  def migrate_data(opts \\ [all: true]) do
    # for repo <- repos() do
    #   path = Ecto.Migrator.migrations_path(repo, "data_migrations")
    #   {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, path, :up, opts))
    # end
    path = Application.app_dir(@app, "priv/repo/migrations")
    Ecto.Migrator.run(Bbbcntr.Repo, path, :up, all: true)
  end

end

