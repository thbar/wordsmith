require File.expand_path "../test_helper", __FILE__

context "wordsmith generate tests" do

  def wordsmith
    Wordsmith.new
  end

  test "fails without files" do
    assert_raise RuntimeError do
      wordsmith.generate
    end
  end

  %w(epub html pdf).each do |format|
    test "generates book.#{format}" do
      in_temp_dir do
        wordsmith.init "book"
        Dir.chdir("book") { wordsmith.generate [format] }
      end
    end
  end

  # mobi requires epub
  test "generates book.mobi" do
    in_temp_dir do
      wordsmith.init "book"
      Dir.chdir("book") { wordsmith.generate ["epub", "mobi"] }
    end
  end

  test "generates all" do
    in_temp_dir do
      wordsmith.init "book"
      Dir.chdir("book") { wordsmith.generate }
    end
  end

end
