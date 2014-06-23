

Plugin.create(:urawaza) {
  @大技林 = []

  Urawaza = Struct.new(:key_combi, :index, :proc)

  defdsl(:urawaza){ |key_combi, &proc|
    @大技林 << Urawaza.new(key_combi, 0, proc)
  }

  on_urawaza_key_input { |key|
    @大技林.each { |ura|
      # キー入力整合
      if ura.key_combi[ura.index] == key
        ura.index += 1

        # コマンド入力完了！
        if ura.index == ura.key_combi.length
          ura.proc.call
          ura.index = 0
        end

      # キー入力不整合
      else
        ura.index = 0
      end
    }
  }

  command(:A_Button, name: "Aボタン", condition: lambda { |opt| true }, visible: true, role: :window) { |opt|
    Plugin.call(:urawaza_key_input, :A)
  }

  command(:B_Button, name: "Bボタン", condition: lambda { |opt| true }, visible: true, role: :window) { |opt|
    Plugin.call(:urawaza_key_input, :B)
  }

  command(:UP_Button, name: "上キー", condition: lambda { |opt| true }, visible: true, role: :window) { |opt|
    Plugin.call(:urawaza_key_input, :UP)
  }

  command(:LEFT_Button, name: "左キー", condition: lambda { |opt| true }, visible: true, role: :window) { |opt|
    Plugin.call(:urawaza_key_input, :LEFT)
  }

  command(:RIGHT_Button, name: "右キー", condition: lambda { |opt| true }, visible: true, role: :window) { |opt|
    Plugin.call(:urawaza_key_input, :RIGHT)
  }

  command(:DOWN_Button, name: "下キー", condition: lambda { |opt| true }, visible: true, role: :window) { |opt|
    Plugin.call(:urawaza_key_input, :DOWN)
  }

  UserConfig[:shortcutkey_keybinds][39391] = {:key => "Shift + A", :name => "Aボタン", :slug => :A_Button}
  UserConfig[:shortcutkey_keybinds][39392] = {:key => "Shift + B", :name => "Bボタン", :slug => :B_Button}
  UserConfig[:shortcutkey_keybinds][39393] = {:key => "Shift + Up", :name => "上キー", :slug => :UP_Button}
  UserConfig[:shortcutkey_keybinds][39394] = {:key => "Shift + Left", :name => "左キー", :slug => :LEFT_Button}
  UserConfig[:shortcutkey_keybinds][39395] = {:key => "Shift + Right", :name => "右キー", :slug => :RIGHT_Button}
  UserConfig[:shortcutkey_keybinds][39396] = {:key => "Shift + Down", :name => "下キー", :slug => :DOWN_Button}

  on_boot { |service|
    urawaza([:UP, :UP, :DOWN, :DOWN, :LEFT, :RIGHT, :LEFT, :RIGHT, :B, :A]) {
      timeline(:home_timeline) << Message.new(:system => true, :message => "すぴーどあっーっぷ！")
      timeline(:home_timeline) << Message.new(:system => true, :message => "みさいるー！")
      timeline(:home_timeline) << Message.new(:system => true, :message => "れーざー！")
      timeline(:home_timeline) << Message.new(:system => true, :message => "おぷしょん！")
      timeline(:home_timeline) << Message.new(:system => true, :message => "ばりあー！")
    }
  }
}
