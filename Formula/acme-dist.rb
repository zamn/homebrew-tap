class AcmeDist < Formula
  desc "Sandbox CLI for DIST-VERIFY"
  homepage "https://github.com/zamn/acme-cli-dist-test"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zamn/acme-cli-dist-test/releases/download/v0.1.0/acme-dist-aarch64-apple-darwin.tar.gz"
      sha256 "fe908c3487135c3905ef86b0c87b001fb28bf71ea993eac2f1f6d776788d284b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zamn/acme-cli-dist-test/releases/download/v0.1.0/acme-dist-x86_64-apple-darwin.tar.gz"
      sha256 "1fa7a64f8ad9870605dd482038914dfec55b7779e730588e18cc8fb9f3368111"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zamn/acme-cli-dist-test/releases/download/v0.1.0/acme-dist-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7c6897e866b2e1de156201c3836857d27a6677d52258974c0a17186db0200ae9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zamn/acme-cli-dist-test/releases/download/v0.1.0/acme-dist-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9976c268512a6cf162f50b34b8ff90f80df9719d04b718ba3bbdba89c6ab8413"
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
