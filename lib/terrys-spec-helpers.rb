module Terrys_spec_helpers

  def setup_variables(thing)
    f=thing.to_s
    @f=f.to_sym
    @fp=(f+'=').to_sym
  end

  def accessor_present(thing)
    describe "accessor #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
    end
  end

  def acts_as_a_list
    describe 'acts_as_list' do
      describe 'given a blank position on save' do
        before do
          @o=@thing
          @o.should be_valid
          setup_variables('position')
        end
        it 'should add itself to the list' do
          @o.send(@fp,nil)
          @o.save
          @o.send(@f).should_not be_nil
        end
      end
    end
  end

  def forbidden_string(thing,options={})
    describe "FORBIDDEN attribute #{thing} (reverse captcha)" do
      before do
        if options[:pending]
          pending options[:pending]
        end
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it "should accept a nil value" do
        @o.send(@fp,nil)
        @o.save
        @o.should be_valid
      end
      it "should accept a blank value" do
        @o.send(@fp,'')
        @o.save
        @o.should be_valid
      end
      it "should reject a non-blank value" do
        @o.send(@fp,'t')
        @o.save
        @o.should_not be_valid
      end
    end

  end

  def it_should_expose(variable)
    it "should expose the #{variable} variable" do
      controller.send(variable).should_not be_nil
    end
  end

  def it_should_return_200
    it "returns http success" do
      response.should be_success
    end
  end

  def it_should_set_flash_alert
    it "should set a flash alert" do
      flash[:alert].should_not be_nil
    end
  end

  def it_should_set_flash_notice
    it "should set a flash notice" do
      flash[:notice].should_not be_nil
    end
  end

  def mandatory_boolean(thing)
    describe "attribute #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it "should be invalid if #{thing} is not true" do
        @o.send(@fp,nil)
        @o.save.should_not be_true
      end
      it "should be valid if #{thing} is true" do
        @o.send(@fp,true)
        @o.save.should be_true
      end
    end
  end

  def mandatory_collection(thing, options={})
    describe "association #{thing}" do
      before do
        if options[:pending]
          pending options[:pending]
        end
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
    end
  end

  def mandatory_date(thing)
    describe "attribute #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
          @o.respond_to?(@f).should be_true
        end
      it "should reject a nil value" do
        @o.send(@fp,nil)
        @o.save
        @o.should_not be_valid
      end
      it "should reject a blank value" do
        @o.send(@fp,'')
        @o.save
        @o.should_not be_valid
      end
    end
  end

  def mandatory_datetime(thing,default=nil)
    describe "attribute #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
          @o.respond_to?(@f).should be_true
      end
      if default
        it "should set a nil value to the default if default exists" do
          @o.send(@fp,nil)
          @o.save
          @o.send(@f).should==default
        end
      else
        it "should reject a nil value if no default exists" do
          @o.send(@fp,nil)
          @o.save
          @o.should_not be_valid
        end
      end
      if default
        it "should set a blank value to the default if default exists" do
          @o.send(@fp,'')
          @o.save
          @o.send(@f).should==default
        end
      else
        it "should reject a blank value if no default exists" do
          @o.send(@fp,nil)
          @o.save
          @o.should_not be_valid
        end
      end
    end
  end

  def mandatory_float(thing)
    describe "attribute #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it "should reject a nil value" do
        @o.send(@fp,nil)
        @o.save
        @o.should_not be_valid
      end
      it "should reject a blank value" do
        @o.send(@fp,'')
        @o.save
        @o.should_not be_valid
      end
    end
  end

  def mandatory_integer(thing)
    describe "attribute #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it "should reject a nil value" do
        @o.send(@fp,nil)
        @o.save
        @o.should_not be_valid
      end
      it "should reject a blank value" do
        @o.send(@fp,'')
        @o.save
        @o.should_not be_valid
      end
    end
  end

  def mandatory_integer_or_default(thing,default)
    describe "attribute #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it "should set a nil value to default" do
        @o.send(@fp,nil)
        @o.save
        @o.send(@f).should==default
      end
      it "should set a blank value to default" do
        @o.send(@fp,'')
        @o.save
        @o.send(@f).should==default
      end
    end
  end

  def mandatory_string(thing,options={})
    describe "attribute #{thing}" do
      before do
        if options[:pending]
          pending options[:pending]
        end
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it "should reject a nil value" do
        @o.send(@fp,nil)
        @o.save
        @o.should_not be_valid
      end
      it "should reject a blank value" do
        @o.send(@fp,'')
        @o.save
        @o.should_not be_valid
      end
    end

  end

  def mandatory_string_or_default(thing,default)
    describe "attribute #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it "should set a nil value to default" do
        @o.send(@fp,nil)
        @o.save
        @o.send(@f).should==default
      end
      it "should set a blank value to default" do
        @o.send(@fp,'')
        @o.save
        @o.send(@f).should==default
      end
    end
  end

  def mandatory_unique_string(thing)
    describe "unique attribute #{thing}" do
      mandatory_string(thing)
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it "should reject a duplicate value" do
        z=@o.class.new(@o.attributes)
        z.send(@f).should==@o.send(@f)
        z.should_not be_valid
        z.send(@fp,'zzz')
        z.should be_valid
      end
    end

  end

  def mandatory_belongs_to(thing,options={})
    describe "belongs_to association #{thing}" do
      before do
        if options[:pending]
          pending options[:pending]
        end
        f_id=thing.to_s.downcase+'_id'
        @o=@thing
        @o.should be_valid
        setup_variables(f_id)
        if options[:class_name]
          @klass=options[:class_name]
        else
          @klass=thing
        end
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it "should reject a nil value" do
        @o.send(@fp,nil)
        @o.save
        @o.should_not be_valid
      end
      it 'should reject an invalid value' do
        @klass.find(@o.send(@f)).should_not be_nil
        @o.should be_valid
        @o.send(@fp,999999)
        @klass.find_by_id(@o.send(@f)).should be_nil
        @o.should_not be_valid
      end
    end


  end

  def optional_accessor(thing,options={})
    before do
      if options[:pending]
        pending options[:pending]
      end
      f_id=thing.to_s.downcase+'_id'
      @o=@thing
      @o.should be_valid
      setup_variables(f_id)
    end
    it 'should respond' do
      @o.respond_to?(@f).should be_true
    end
  end

  def optional_belongs_to(thing, options={})
    describe "belongs_to association #{thing}" do
      before do
        if options[:pending]
          pending options[:pending]
        end
        f_id=thing.to_s.downcase+'_id'
        @o=@thing
        @o.should be_valid
        setup_variables(f_id)
        if options[:class_name]
          @klass=options[:class_name]
        else
          @klass=thing
        end
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it 'should make an invalid value nil' do
        @o.send(@fp,999999)
        @klass.find_by_id(@o.send(@f)).should be_nil
        @o.valid?
        @o.send(@f).should be_nil
      end
    end
  end

  def optional_boolean(thing)
    describe "attribute #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
    end
  end

  def optional_date(thing)
    describe "attribute #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it "should make a blank value nil" do
        @o.send(@fp,'')
        @o.save
        @o.send(@f).should be_nil
      end
    end
  end

  def optional_datetime(thing)
    describe "attribute #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it "should make a blank value nil" do
        @o.send(@fp,'')
        @o.save
        @o.send(@f).should be_nil
      end
    end
  end

  def optional_float(thing)
    describe "attribute #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it "should make a blank value nil" do
        @o.send(@fp,'')
        @o.save
        @o.send(@f).should be_nil
      end
    end
  end

  def optional_integer(thing)
    describe "attribute #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it "should make a blank value nil" do
        @o.send(@fp,'')
        @o.save
        @o.send(@f).should be_nil
      end
    end
  end

  def optional_string(thing)
    describe "attribute #{thing}" do
      before do
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      it 'should respond' do
        @o.respond_to?(@f).should be_true
      end
      it "should make a blank value nil" do
        @o.send(@fp,'')
        @o.save
        @o.send(@f).should be_nil
      end
    end
  end

  def there_can_be_only_one(thing,options={})
    describe "there can only be one item with attribute #{thing} set to true" do
      before do
        if options[:pending]
          pending options[:pending]
        end
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      describe "where it is not the first item and #{thing} is true" do
        before do
          @z=@o.class.new(@o.attributes)
          if options[:attributes]
            @z.update_attributes(options[:attributes])
          end
          @o.send(@fp,false)
          @z.send(@fp,true)
          @z.save.should be_true
          @o.save.should be_true
          @z.send(@f).should be_true
          @o.send(@f).should be_false
        end
        it "should set to false any other items with #{thing} set to true" do
          @o.send(@fp,true)
          @o.save.should be_true
          @o.send(@f).should be_true
          @z.send(@f).should be_false
        end
      end
    end

  end

  def there_must_be_one(thing,options={})
    describe "there must be at least one item with attribute #{thing} set to true" do
      before do
        if options[:pending]
          pending options[:pending]
        end
        @o=@thing
        @o.should be_valid
        setup_variables(thing)
      end
      describe "where it is the first item and #{thing} is false" do
        before do
         (@o.class.all-[@o]).each{|o| o.delete}
          @o.class.count.should==1
          @o.send(@fp,false)
          @o.send(@f).should be_false
        end
        it "it should set #{thing} to true" do
          @o.save
          @o.send(@f).should be_true
        end
      end
      describe "where it is the last item with #{thing} set to true" do
        before do
          @o.send(@fp,true)
          @o.save.should be_true
          @o.send(@f).should be_true
        end
        it "should not be able to be destroyed" do
          @o.destroy.should be_false
        end
      end
    end
  end

end