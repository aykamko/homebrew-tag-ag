HOMEBREW_TAG_VERSION="v1.4.0".freeze
class TagAg < Formula
  desc "Instantly jump to your ag or ripgrep matches."
  homepage "https://github.com/aykamko/tag"
  url "https://github.com/aykamko/tag/releases/download/#{HOMEBREW_TAG_VERSION}/tag_darwin_amd64.zip"
  sha256 "d5cfe843e0953e1f440a82e488d54b0a9f51671a70bba74f7417107c788f1796"

  version HOMEBREW_TAG_VERSION
  head "https://github.com/aykamko/tag.git", :branch => "master"

  depends_on "the_silver_searcher" => :build
  if build.head?
    depends_on "hg" => :build
    depends_on "go" => :build
  end

  def install
    go_build if build.head?
    bin.install "tag"
  end

  def go_build
    ENV["GOPATH"] = buildpath
    system "go", "get", "github.com/fatih/color"
    mkdir_p buildpath/"src/github.com/aykamko"
    ln_s buildpath, buildpath/"src/github.com/aykamko/tag"
    system "go", "build", "-o", "tag"
  end

  test do
  end
end
