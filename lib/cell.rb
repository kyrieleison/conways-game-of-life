class Cell
  LIVE = 1
  DEAD = 0

  class << self
    def randomly_create
      status = rand(DEAD..LIVE)
      new(status)
    end
  end

  def initialize(status)
    @status = status
  end

  def live?
    @status == LIVE
  end

  def dead?
    @status == DEAD
  end

  def live!
    @status = LIVE
  end

  def dead!
    @status = DEAD
  end
end
