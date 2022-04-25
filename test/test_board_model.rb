# frozen_string_literal: true

require_relative 'test_helper'
require_relative 'test_ship'
require_relative '../lib/board_model'
require 'test/unit'
require 'set'



class BoardModelTest < Test::Unit::TestCase
  def setup
    @board_chico = BoardModel.new(8, 3) # chico
  end

  def test_out_of_bounds?
    assert_false(@board_chico.out_of_bounds?(3, 1, 1, true))
  end

  def test_ship_collision
    @board_chico.board1[1][1] = 'S'
    @board_chico.board2[1][1] = 'S'
    assert_true(@board_chico.ship_collision?(3, 1, 1, true, 1))
    assert_true(@board_chico.ship_collision?(3, 1, 1, false, 1))
    assert_false(@board_chico.ship_collision?(3, 2, 2, true, 1))
  end
  
  def test_next_to_ship
		@board_chico.board1[1][1] = 'S'
		assert_true(@board_chico.next_to_ship?(3, 1, 2, true, 0))
		assert_false(@board_chico.next_to_ship?(3, 1, 3, true, 0))
  end

  def test_valid_position
    assert_false(@board_chico.valid_position(3, 20, 20, true, 1))
    assert_true(@board_chico.valid_position(3, 2, 2, true, 1))
  end

  def test_add_ship
    ship = ShipClone.new(3, 2, 2, true)
    assert_equal([[2, 2], [3, 2], [4, 2]], @board_chico.add_ship(1, ship))

    ship = ShipClone.new(3, 2, 2, false)
    assert_equal([[2, 2], [2, 3], [2, 4]], @board_chico.add_ship(1, ship))
  end

  def test_update_sink_by
    ship = ShipClone.new(3, 2, 2, true)
    assert_equal([[2, 2], [3, 2], [4, 2]], @board_chico.update_sink_by(1, ship))

    ship = ShipClone.new(3, 2, 2, false)
    assert_equal([[2, 2], [2, 3], [2, 4]], @board_chico.update_sink_by(1, ship))
  end

  def test_valid_shot
    assert_true(@board_chico.valid_shot(2, 2, 1))
  end

  def test_shot_from
    @board_chico.board1[1][1] = 'S'
    assert_equal('!', @board_chico.shot_from(1, 1, 1))
  end
  
  def test_neighbor_boxes
		# on the edge
		neighbors = [[1, 2], [2, 1], [2, 2]]
		boxes = @board.neighbor_boxes(1, 1, 1, true)
		assert_equal(neighbors.to_set, boxes.to_set)

		#on the center vertical
		neighbors = [[1, 2], [1, 3], [1, 4], [2, 2], [2, 4], [3, 2], [3, 3], [3, 4]]
		boxes = @board.neighbor_boxes(1, 2, 3, true)
		assert_equal(neighbors.to_set, boxes.to_set)

		#on the center horizontal
		neighbors = [[1, 2], [1, 3], [1, 4], [2, 2], [2, 4], [3, 2], [3, 3], [3, 4]]
		boxes = @board.neighbor_boxes(1, 2, 3, false)
		assert_equal(neighbors.to_set, boxes.to_set)
	end
end

