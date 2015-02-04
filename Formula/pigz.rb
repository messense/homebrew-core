class Pigz < Formula
  homepage "http://www.zlib.net/pigz/"
  url "http://www.zlib.net/pigz/pigz-2.3.3.tar.gz"
  sha1 "11252d38fe2a7b8d7a712dff22bbb7630287d00b"

  bottle do
    cellar :any
    sha1 "6eb3c6cad2d259e6a3230b9ac596a0357c54c170" => :yosemite
    sha1 "f208f507c57ab7f32d34dc9e9d5ab7d131558d33" => :mavericks
    sha1 "4348380310afb99b698813e76a4ba01e4d024a1a" => :mountain_lion
  end

  def install
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}"
    bin.install "pigz", "unpigz"
    man1.install "pigz.1"
    man1.install_symlink "pigz.1" => "unpigz.1"
  end

  test do
    test_data = "a" * 1000
    (testpath/"example").write test_data
    system bin/"pigz", testpath/"example"
    assert (testpath/"example.gz").file?
    system bin/"unpigz", testpath/"example.gz"
    assert_equal test_data, (testpath/"example").read
  end
end
