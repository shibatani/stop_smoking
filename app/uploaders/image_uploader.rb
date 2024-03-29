class ImageUploader < CarrierWave::Uploader::Base
  #リサイズ、画像形式を変更に必要
  include CarrierWave::RMagick

#上限変更
  process :resize_to_limit => [100, 100]

#JPGで保存
  process :convert => 'jpg'

#サムネイルを生成
  version :thumb do
    process :resize_to_limit => [50, 50]
  end

# jpg,jpeg,gif,pngのみ
  def extension_white_list
    %w(jpg jpeg gif png)
  end

#ファイル名を変更し拡張子を同じにする
  def filename
    super.chomp(File.extname(super)) + '.jpg' 
  end

#日付で保存
  def filename
    if original_filename.present?
      time = Time.now
      name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
      name.downcase
    end
  end

  storage :file
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
