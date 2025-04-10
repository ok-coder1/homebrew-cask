cask "nvidia-nsight-systems" do
  arch arm: "-arm64"

  version "2025.2.1.130-3569061"
  sha256 arm:   "d0cd36f6413922d54a66baca930c3980ac1771c082d73d17947fac5f3ee90212",
         intel: "6ffa5bcca3757bb4c632174bfe9b0703db805405d73ebed08a9e69334fcb2f7a"

  url "https://developer.nvidia.com/downloads/assets/tools/secure/nsight-systems/#{version.major_minor.dots_to_underscores}/NsightSystems-macos#{arch}-public-#{version}.dmg"
  name "NVIDIA Nsight Systems"
  desc "System-wide performance analysis tool"
  homepage "https://developer.nvidia.com/nsight-systems"

  livecheck do
    url "https://developer.nvidia.com/tools-downloads.json"
    regex(/NsightSystems[._-]macos#{arch}[._-]public[._-]v?(\d+(?:[.-]\d+)+)\.dmg/i)
    strategy :json do |json, regex|
      json["downloads"]&.map do |download|
        next unless download["development_platform"]&.include?("osx")

        download["files"]&.map do |file|
          match = file["url"]&.match(regex)
          next if match.blank?

          match[1]
        end
      end&.flatten
    end
  end

  depends_on macos: ">= :high_sierra"

  app "NVIDIA Nsight Systems.app"

  zap trash: "~/Library/Saved Application State/com.nvidia.devtools.QuadD.savedState"
end
