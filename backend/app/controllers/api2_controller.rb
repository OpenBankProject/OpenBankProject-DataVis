
class Api2Controller < ApplicationController

  def index
    cats = read_categorization_files
    puts cats.inspect

    # cats[transaction.holder] =>
  end

  protected

  def read_categorization_files
    root_dir = Rails.root.to_s + '/Categorisation/*'
    cat_files = Dir.glob(root_dir)

    cats = Hash.new
    cat_files.each do |file|
      cat = file.split("/").last

      File.open(file, "r").each_line do |line|
        holder = line.delete("\n")
        cats[holder] = cat unless holder.empty?
      end
    end

    cats
  end

end
