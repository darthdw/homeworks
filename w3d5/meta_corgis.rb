class SnackBox
  SNACK_BOX_DATA = {
    1 => {
      "bone" => {
        "info" => "Phoenician rawhide",
        "tastiness" => 20
      },
      "kibble" => {
        "info" => "Delicately braised hamhocks",
        "tastiness" => 33
      },
      "treat" => {
        "info" => "Chewy dental sticks",
        "tastiness" => 40
      }
    },
    2 => {
      "bone" => {
        "info" => "An old dirty bone",
        "tastiness" => 2
      },
      "kibble" => {
        "info" => "Kale clusters",
        "tastiness" => 1
      },
      "treat" => {
        "info" => "Bacon",
        "tastiness" => 80
      }
    },
    3 => {
      "bone" => {
        "info" => "A steak bone",
        "tastiness" => 64
      },
      "kibble" => {
        "info" => "Sweet Potato nibbles",
        "tastiness" => 45
      },
      "treat" => {
        "info" => "Chicken bits",
        "tastiness" => 75
      }
    }
  }
  def initialize(data = SNACK_BOX_DATA)
    @data = data
  end

  def get_bone_info(box_id)
    @data[box_id]["bone"]["info"]
  end

  def get_bone_tastiness(box_id)
    @data[box_id]["bone"]["tastiness"]
  end

  def get_kibble_info(box_id)
    @data[box_id]["kibble"]["info"]
  end

  def get_kibble_tastiness(box_id)
    @data[box_id]["kibble"]["tastiness"]
  end

  def get_treat_info(box_id)
    @data[box_id]["treat"]["info"]
  end

  def get_treat_tastiness(box_id)
    @data[box_id]["treat"]["tastiness"]
  end
end

class CorgiSnacks

  def initialize(snack_box, box_id)
    @snack_box = snack_box
    @box_id = box_id
  end

  def bone
    info = @snack_box.get_bone_info(@box_id)
    tastiness = @snack_box.get_bone_tastiness(@box_id)
    result = "Bone: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

  def kibble
    info = @snack_box.get_kibble_info(@box_id)
    tastiness = @snack_box.get_kibble_tastiness(@box_id)
    result = "Kibble: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

  def treat
    info = @snack_box.get_treat_info(@box_id)
    tastiness = @snack_box.get_treat_tastiness(@box_id)
    result = "Treat: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

end


class MetaCorgiSnacks
  def initialize(snack_box, box_id)
    @snack_box = snack_box
    @box_id = box_id
  end

  # Had to look at the solution. I can puzzle out what this is doing, but I'm not
  # sure that making something this unexpressive is really worth the 'DRYness' in
  # this case (or the potential headache from Method Missing being overwritten.)

  def method_missing(name, *args)
    info = @snack_box.send("get_#{name}_info", @box_id)
    tastiness = @snack_box.send("get_#{name}_tastiness", @box_id)
    name = "#{name.to_s.split('_').map(&:capitalize).join(' ')}"
    result = "#{name}: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

  # Changed the variables around so that I could wrap my head around exactly what 
  # is happening here. It looks like the Hash is being used to simply generate the
  # different methods that have been produced. I think this one makes a lot more
  # sense (maybe because I've been thinking with databases recently) compared to the
  # other version of the code. Constructed this version using the previous one,
  # which was taken from the solution to get me started. This is going a little
  # over my head... Hoping for solid lecture tomorrow.

  def self.define_snack(name)
    define_method(name) do
      def_info = @snack_box.send("get_#{name}_info", @box_id)
      def_name = "#{name.to_s.split('_').map(&:capitalize).join(' ')}"
      def_resu = "#{def_name}: #{def_info}: #{tastiness} "
      if tastiness > 30
        "* #{def_resu} "
      else
        def_resu
      end
    end
  end
end
