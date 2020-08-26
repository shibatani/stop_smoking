class ImageUploader < CarrierWave::Uploader::Base
  #リサイズ、画像形式を変更に必要
  include CarrierWave::RMagick

version :resized do
    process :crop
    process resize_to_fill: [600, 600]
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

  private

    def crop
      return if [model.image_x, model.image_y, model.image_w, model.image_h].all?
      manipulate! do |img|
        crop_x = model.image_x.to_i
        crop_y = model.image_y.to_i
        crop_w = model.image_w.to_i
        crop_h = model.image_h.to_i
        img.crop "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}"
        img = yield(img) if block_given?
        img
      end
    end
end
