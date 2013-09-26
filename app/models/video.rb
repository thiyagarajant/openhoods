class Video < ActiveRecord::Base

    has_attached_file :video
    belongs_to :user
    belongs_to :vehicle

    has_attached_file :avatar, :styles => {:small => 'x50', :medium => "300x300>", :thumb => "100x100>" }

  # Paperclip Validations
  #validates_attachment :picture, :presence => true,:content_type => { :content_type => ['image/jpeg', 'image/png'] },
      #                  :size => { :less_than => 5.megabytes}

   validates_attachment_presence :video
   validates_attachment_content_type :video, :content_type => ['video/ogv','video/mp4'],:message => "Sorry, right now we only support MP4 video"


  def valid_video?
    [ 'application/x-mp4',
      'video/mpeg',
      'video/quicktime',
      'video/x-la-asf',
      'video/x-ms-asf',
      'video/x-msvideo',
      'video/x-sgi-movie',
      'video/x-flv',
      'flv-application/octet-stream',
      'video/3gpp',
      'video/3gpp2',
      'video/3gpp-tt',
      'video/BMPEG',
      'video/BT656',
      'video/CelB',
      'video/DV',
      'video/H261',
      'video/H263',
      'video/H263-1998',
      'video/H263-2000',
      'video/H264',
      'video/JPEG',
      'video/MJ2',
      'video/MP1S',
      'video/MP2P',
      'video/MP2T',
      'video/mp4',
      'video/MP4V-ES',
      'video/MPV',
      'video/mpeg4',
      'video/mpeg4-generic',
      'video/nv',
      'video/parityfec',
      'video/pointer',
      'video/raw',
      'video/rtx' ].include?(video.content_type)
  end


end
