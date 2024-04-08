# AuroraCommanded

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


## Instrucciones 

Ejecutar `mix deps.get`
Correr instancia DB 
`docker run --env=POSTGRES_PASSWORD=aurora -p 4500:5432 --name=aurora-commanded -d postgres:latest`

Comprobar configuración de DBs (son 2) `config/config.exs`

Inicializar eventstore DB (donde se guardan los eventos)
`mix do event_store.create`
`mix do event_store.init`

Inicializar projector DB (donde se projecta la data)
`mix ecto.create`
`mix ecto.migrate`

Utilizar `iex -S mix phx.server`

Visitar [`localhost:4000`](http://localhost:4000)

### Enviar comandos

Crear unidad organizacional
`:ok = Aurora.CommandedApplication.dispatch(%CreateUO{uo_id: "aurora", uo_name: "MetaEstado"})`

