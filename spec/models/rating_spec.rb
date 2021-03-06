require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'rating'

describe Rating do
  
  context "Associations" do
    it { should belong_to :user }
    it { should belong_to :presentation }
  end

  context "Validations" do
    it { should validate_uniqueness_of :user_id, :scope => :presentation_id }
  end



  before(:each) do
    @user = User.create(:login => "face", :password => "face", :password_confirmation => "face", :email => "tsnydermtg@gmail.com")
    @rating = @user.ratings.new
    @rating.save
  end

  it "should rate a presentation positively" do
    preso = Presentation.create(:title=>"foo")
    preso.rate_thumbs_up(@user)
    preso.positive_ratings.should == 1
  end

  it "should rate a presentation negatively" do
    preso = Presentation.create(:title=>"foo")
    preso.rate_thumbs_down(@user)
    preso.negative_ratings.should == 1
  end
end
