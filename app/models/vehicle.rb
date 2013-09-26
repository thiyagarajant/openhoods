class Vehicle < ActiveRecord::Base
  belongs_to :category
  acts_as_commentable
  #paginates_per = 10

  has_many :favorites
  has_one :video

  has_attached_file :avatar, :styles => {:small => 'x50',:large => "1280x800>", :medium => "300x300>", :thumb => "100x100>" }#, :default_url => "/images/:style/missing.png"

  default_scope order('created_at desc')
  class << self
    def filter_records(params)
      @rec = Vehicle.all
      @rec = @rec.where("title like '%#{params[:title]}%'") if params[:title].present?
      if params[:search].present?
        val = params[:search]
        self.condition_search(val)
        self.price_search(val)
        self.location_search(val)
        if val.key?(:filter_car) ||val.key?(:filter_truk)||val.key?(:filter_hybird)||val.key?(:filter_sport)|| val.key?(:filter_suv)|| val.key?(:filter_wagon)
          @re = []
          val.each do |key, value|
            @re << @rec.where(:v_type => 'car') if key == 'filter_car'
            @re << @rec.where(:v_type => 'truk') if key == 'filter_truk'
            @re << @rec.where(:v_type => 'hybird') if key == 'filter_hybird'
            @re << @rec.where(:v_type => 'sport') if key == 'filter_sport'
            @re << @rec.where(:v_type => 'wegon') if key == 'filter_wagon'
            @re << @rec.where(:v_type => 'suv') if key == 'filter_suv'
          end
          @rec = @re.flatten
        end
      end
      @rec
    end

    def location_search(val)
      if val[:location_us].present? && val[:location_ua].present?
        @rec = @rec.where("location like '%us%' or location like '%ua%'")
      else
        @rec = @rec.where("location like '%us%'") if val[:location_us].present?
        @rec = @rec.where("location like '%ua%'") if val[:location_ua].present?
      end
    end

    def condition_search(val)
      if val[:condition_new] == '1' && val[:condition_used] == '1'
        @rec
      else
        @rec = @rec.where(:condition => 'new') if val[:condition_new] == '1'
        @rec = @rec.where(:condition => 'used') if val[:condition_used] == '1'
      end
    end

    def price_search(val)
      if val[:from].present? && val[:to].present?
        @rec = @rec.where("price > ? and price < ?", val[:from],val[:to])
      else
        @rec = @rec.where("price > ?", val[:from]) if val[:from].present?
        @rec = @rec.where("price < ?", val[:to]) if val[:to].present?
      end
    end
  end
end
