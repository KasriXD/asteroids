require "gosu"

class Game < Gosu::Window
  def initialize
    super(1280, 720)
    self.caption = "Space Invaders"

    @game_state = :menu
    @font = Gosu::Font.new(40)
    @bakgrund = Gosu::Image.new("media/img/Bakgrund.png")

    @player = Gosu::Image.new("media/img/Ships/Spaceship_0.png")
    @x = 550
    @y = 570

    @space_pressed = false
    @lazer_shot = false
    @player_lazer = Gosu::Image.new("media/img/player_laser.png")
    @lazer_x = 0
    @lazer_y = 0

    #@sound = Gosu::Sample.new("media/audio/omnomnom.mp3")
    @enemy_image = Gosu::Image.new("media/img/Enemies/EvilEye_1.png")
    @enemies = []

    rows = 5
    columns = 10

    rows.times do |row|
      columns.times do |column|
        x = 250 + column * 75
        y = 35 + row * 55

        @enemies << [x, y]
      end
    end
  end

  def update
    case @game_state
    when :menu
    
    when :playing
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
  end

  def button_down(id)
    if id == Gosu::KbSpace
      @space_pressed = true
      @lazer_x = @x
      @lazer_y = @y
    end
    if @game_state == :menu
      if id == Gosu::KB_RETURN
        @game_state = :playing
      end
    end
  end

  def draw_menu
    @bakgrund.draw(315, 95, 0)
    @font.draw_text("Press ENTER to start", 420, 565, 1)
  end

  def draw_playing
    @player.draw(@x, @y, 1, 0.2, 0.2)

    @enemies.each do |enemy|
      @enemy_image.draw(enemy[0], enemy[1], 1, 0.15, 0.15)
    end

    if @lazer_shot == true
      @player_lazer.draw(@lazer_x + 15, @lazer_y, 0, 0.15, 0.15)
    end
  end

  def draw
    case @game_state
    when :menu  
      draw_menu
    when :playing
      draw_playing
    end
  end
end

Game.new.show