module Scored
  extend ActiveSupport::Concern

  def move_up
    bump_position(:up)
  end

  def move_down
    bump_position(:down)
  end

  def move_to(position)
    scored = self.class.scored
    if position <= 1
      self.score = Time.now.to_i
    elsif position >= Video.count
      self.score = scored.last.score - 1
    else
      self.score = (scored[position].score + scored[position-1].score) / 2
    end
    self.save
  end

  def best?
    self.class.where(['score>?', self.score]).count == 0
  end

  def worst?
    self.class.where(['score<?', self.score]).count == 0
  end

  def position
    self.class.scored.index(self) + 1
  end

  module ClassMethods
    def scored
      order('score desc')
    end
  end

  protected

  def bump_position(direction)
    order = direction == :up ? 'score' : 'score desc'
    condition = direction == :up ? 'score>?' : 'score<?'
    this_score = self.score.to_i
    next_item = self.class.order(order)
                    .where([condition, this_score])
                    .first
    if next_item
      next_item.score, self.score = self.score, next_item.score
      next_item.save
      self.save
    end
    self.score
  end

  def initialise_score
    self.score = Time.now.to_i
  end

end