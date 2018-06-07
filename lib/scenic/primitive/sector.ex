#
#  Created by Boyd Multerer on 10/29/17.
#  Copyright © 2017 Kry10 Industries. All rights reserved.
#

defmodule Scenic.Primitive.Sector do
  use Scenic.Primitive

# alias Scenic.Primitive
#  alias Scenic.Primitive.Style


  @styles   [:hidden, :fill, :stroke]


  #============================================================================
  # data verification and serialization

  #--------------------------------------------------------
  def info(), do: "Sector should look like this: {{0,y}, radius, start, finish, h, k}\r\n" <>
  "Circle sector looks like this: {{x0,y0}, width, height, 1.0, 1.0}\r\n" <>
  "Ellipse sector looks like this: {{x0,y0}, width, height, 2.0, 1.0}"

  #--------------------------------------------------------
  def verify( data ) do
    try do
      normalize(data)
      {:ok, data}
    rescue
      _ -> :invalid_data
    end
  end


  #--------------------------------------------------------
  def normalize( {{x, y}, radius, start, finish, h, k} = data )
  when is_number(x) and is_number(y) and
  is_number(start) and is_number(finish) and is_number(radius) and
  is_number(h) and is_number(k), do: data


  #============================================================================
  def valid_styles(), do: @styles

  #--------------------------------------------------------
  def expand( {{x, y}, radius, start, finish, h, k}, width ) do
    {{x, y}, radius + width, start, finish, h, k}
  end

  #--------------------------------------------------------
  def default_pin( data ) do
    {{x, y},_,_,_,_,_} = normalize(data)
    {x,y}
  end

end