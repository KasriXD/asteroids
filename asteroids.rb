require "gosu"

class Game < Gosu::Window
  def initialize
    super(1280, 720)
    self.caption = "Space Invaders"
    @player = Gosu::Image.new("media/img/Ships/Spaceship_0.png")
    @x = 550
    @y = 570

    @space_pressed = false
    @lazer_shot = false
    @player_lazer = Gosu::Image.new("media/img/player_laser.png")
    @lazer_x = 0
    @lazer_y = 0

    #@sound = Gosu::Sample.new("media/audio/omnomnom.mp3")
  end

  def update
    @x -= 5 if Gosu.button_down?(Gosu::KB_LEFT)
    @x += 5 if Gosu.button_down?(Gosu::KB_RIGHT)
    @x = @x.clamp(0, width - @player.width * 0.2)
    @y = @y.clamp(0, height - @player.height * 0.2)

    if @lazer_shot == true
      @lazer_y -= 8
    end


    @lazer_shot = true if @space_pressed == true
    @space_pressed = false if @space_pressed == true
  end

  def button_down(id)
    if id == Gosu::KbSpace
      @space_pressed = true
      @lazer_x = @x
      @lazer_y = @y
    end
  end

  def draw
    @player.draw(@x, @y, 1, 0.2, 0.2)

    if @lazer_shot == true
      @player_lazer.draw(@lazer_x + 15, @lazer_y, 0, 0.15, 0.15)
    end
  end
end

Game.new.show