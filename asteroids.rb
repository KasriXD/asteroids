require "gosu"

class Game < Gosu::Window
  def initialize
    super(1280, 720)
    self.caption = "Asteroids"
    @player = Gosu::Image.new("media\img\Ships\Spaceship_0.png")
    @x = 270
    @y = 180
    #@sound = Gosu::Sample.new("media/audio/omnomnom.mp3")
  end

  def update
    @x -= 5 if Gosu.button_down?(Gosu::KB_LEFT)
    @x += 5 if Gosu.button_down?(Gosu::KB_RIGHT)

    @x = @x.clamp(0, width - @llama.width)
    @y = @y.clamp(0, height - @llama.height)

  end

  def draw
    @player.draw(@x, @y, 0)
  end
end

Game.new.show