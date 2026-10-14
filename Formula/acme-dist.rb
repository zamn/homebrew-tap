class AcmeDist < Formula
  desc "Sandbox CLI for DIST-VERIFY"
  homepage "https://github.com/zamn/acme-cli-dist-test"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zamn/acme-cli-dist-test/releases/download/v0.1.3/acme-dist-aarch64-apple-darwin.tar.gz"
      sha256 "7d4309916c035c8ef92b015e2695d0d2e86f1bd844481a3135ac5a3624ae7b98"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zamn/acme-cli-dist-test/releases/download/v0.1.3/acme-dist-x86_64-apple-darwin.tar.gz"
      sha256 "ee16e9be1b0d661f8cfd369c0a38c5e095e5cb9750fe8e08ea04f95cb6933d17"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zamn/acme-cli-dist-test/releases/download/v0.1.3/acme-dist-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8618c82daf0f3510736938f2ece613952acf5edbf74948274d0722b0ee15c37c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zamn/acme-cli-dist-test/releases/download/v0.1.3/acme-dist-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0605a2a686eb3739836968043b8f8a068f2764156463db583f8105a12a06ea00"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "acme-dist"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "acme-dist"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "acme-dist"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "acme-dist"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
