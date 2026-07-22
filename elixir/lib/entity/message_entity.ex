# Thesmsworks SDK Message entity
#
# Per-entity module. Generic construction/data/match operations delegate to
# EntityBase; each active op (load/list/create/update/remove) builds a ctx
# and drives it through Thesmsworks.Pipeline.run_op.

defmodule Thesmsworks.Entity.Message do
  alias Voxgig.Struct, as: S
  alias Thesmsworks.Helpers, as: H
  alias Thesmsworks.{EntityBase, Context, Pipeline}

  def new(client, entopts \\ nil) do
    EntityBase.construct(__MODULE__, client, "message", entopts)
  end

  def get_name(ent), do: EntityBase.get_name(ent)
  def make(ent), do: EntityBase.make(ent)
  def data_set(ent, args \\ nil), do: EntityBase.data_set(ent, args)
  def data_get(ent), do: EntityBase.data_get(ent)
  def match_set(ent, args \\ nil), do: EntityBase.match_set(ent, args)
  def match_get(ent), do: EntityBase.match_get(ent)

  # Streaming operation (see EntityBase.stream): runs `action` through the
  # pipeline and returns a lazy Stream over result items.
  def stream(ent, action, args \\ nil, callopts \\ nil),
    do: EntityBase.stream(ent, action, args, callopts)

  
  def load(ent, reqmatch \\ nil, ctrl \\ nil) do
    reqmatch = if reqmatch == nil, do: S.jm([]), else: reqmatch

    ctx =
      Context.new(
        S.jm([
          "opname", "load",
          "ctrl", ctrl,
          "match", S.getprop(ent, "_match"),
          "data", S.getprop(ent, "_data"),
          "reqmatch", reqmatch
        ]),
        S.getprop(ent, "_entctx")
      )

    post_done = fn ->
      result = S.getprop(ctx, "result")

      if result != nil do
        rm = S.getprop(result, "resmatch")
        if rm != nil, do: S.setprop(ent, "_match", rm)
        rd = S.getprop(result, "resdata")
        if rd != nil, do: S.setprop(ent, "_data", H.or_(H.to_map(S.clone(rd)), S.jm([])))
      end
    end

    Pipeline.run_op(ctx, post_done)
  end



  

  
  def create(ent, reqdata, ctrl \\ nil) do
    ctx =
      Context.new(
        S.jm([
          "opname", "create",
          "ctrl", ctrl,
          "match", S.getprop(ent, "_match"),
          "data", S.getprop(ent, "_data"),
          "reqdata", reqdata
        ]),
        S.getprop(ent, "_entctx")
      )

    post_done = fn ->
      result = S.getprop(ctx, "result")

      if result != nil do
        rd = S.getprop(result, "resdata")
        if rd != nil, do: S.setprop(ent, "_data", H.or_(H.to_map(S.clone(rd)), S.jm([])))
      end
    end

    Pipeline.run_op(ctx, post_done)
  end



  

  
  def remove(ent, reqmatch \\ nil, ctrl \\ nil) do
    reqmatch = if reqmatch == nil, do: S.jm([]), else: reqmatch

    ctx =
      Context.new(
        S.jm([
          "opname", "remove",
          "ctrl", ctrl,
          "match", S.getprop(ent, "_match"),
          "data", S.getprop(ent, "_data"),
          "reqmatch", reqmatch
        ]),
        S.getprop(ent, "_entctx")
      )

    post_done = fn ->
      result = S.getprop(ctx, "result")

      if result != nil do
        rm = S.getprop(result, "resmatch")
        if rm != nil, do: S.setprop(ent, "_match", rm)
        rd = S.getprop(result, "resdata")
        if rd != nil, do: S.setprop(ent, "_data", H.or_(H.to_map(S.clone(rd)), S.jm([])))
      end
    end

    Pipeline.run_op(ctx, post_done)
  end


end
