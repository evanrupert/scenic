#
#  Re-Created by Boyd Multerer on November 30, 2017.
#  Copyright © 2017 Kry10 Industries. All rights reserved.
#

defmodule Scenic.Primitive.Style.Font do
  use Scenic.Primitive.Style

# import IEx

  #============================================================================
  # data verification and serialization

  #--------------------------------------------------------
  def info() do
    "Style :font must be a key_or_atom\r\n" <>
    "Example: :roboto             # system font\r\n" <>
    "Example: \"w29afwkj23ry8\"   # hash key of font in the cache\r\n"
    "\r\n" <>
    "The system fonts are: :roboto, :roboto_mono, :robot_slab\r\n"
  end

  #--------------------------------------------------------
  def verify( font ) do
    try do
      normalize( font )
      true
    rescue
      _ -> false
    end
  end

  #--------------------------------------------------------
  def normalize( name ) when is_atom(name),     do: name
  def normalize( key ) when is_bitstring(key),  do: key
end