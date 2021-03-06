# encoding: utf-8
require File.join(File.dirname(__FILE__), "../spec_helper.rb")

describe ActiveService::Model::HTTP do
  context "binding a model with an API" do
    let(:api1) { ActiveService::API.new :url => "https://api1.example.com" }
    let(:api2) { ActiveService::API.new :url => "https://api2.example.com" }

    before do
      ActiveService::API.setup :url => "https://api.example.com"
      spawn_model "User"
      spawn_model "Comment"
    end

    context "when binding a model to an instance of ActiveService::API" do
      before { User.uses_api api1 }
      subject { User.api }
      its(:base_uri) { should == "https://api1.example.com" }
    end

    context "when binding a model directly to ActiveService::API" do
      before { spawn_model "User" }
      subject { User.api }
      its(:base_uri) { should == "https://api.example.com" }
    end

    context "when using a proc for uses_api" do
      before do
        User.uses_api lambda { ActiveService::API.new :url => 'http://api-lambda.example.com' }
      end

      specify { expect(User.api.base_uri).to eq 'http://api-lambda.example.com' }
    end

    context "when binding two models to two different instances of ActiveService::API" do
      before do
        User.uses_api api1
        Comment.uses_api api2
      end

      specify { expect(User.api.base_uri).to eq "https://api1.example.com" }
      specify { expect(Comment.api.base_uri).to eq "https://api2.example.com" }
    end

    context "binding one model to ActiveService::API and another one to an instance of ActiveService::API" do
      before { Comment.uses_api api2 }
      specify { expect(User.api.base_uri).to eq "https://api.example.com" }
      specify { expect(Comment.api.base_uri).to eq "https://api2.example.com" }
    end

    context "when binding a model to its superclass' api" do
      before do
        spawn_model "Superclass"
        Superclass.uses_api api1
        Subclass = Class.new(Superclass)
      end
      after { Object.send(:remove_const, :Subclass) }
      specify { expect(Subclass.api).to eq Superclass.api }
    end

    context "when changing api without changing the parent class' api" do
      before do
        spawn_model "Superclass"
        Subclass = Class.new(Superclass)
        Superclass.uses_api api1
        Subclass.uses_api api2
      end
      after { Object.send(:remove_const, :Subclass) }
      specify { expect(Subclass.api).to_not eq Superclass.api }
    end
  end

  context "making HTTP requests" do
    before do
      api = ActiveService::API.new :url => "https://api.example.com" do |builder|
        builder.use ActiveService::Middleware::ParseJSON
        builder.adapter :test do |stub|
          stub.get("/users") { |env| ok! [{ :id => 1 }] }
          stub.get("/users/1") { |env| [200, {}, { :id => 1 }.to_json] }
          stub.post("/users") { |env| ok! :id => 1 }
          stub.post("/posts") { |env| ok! :id => 1 }
          stub.get("/users/popular") do |env|
            if env[:params]["page"] == "2"
              ok! [{ :id => 3 }, { :id => 4 }]
            else
              ok! [{ :id => 1 }, { :id => 2 }]
            end
          end
          stub.post("/comments") { |env| error! body: ["can't be blank"] }
        end
      end

      spawn_model "User" do
        use_api api
      end

      spawn_model "Comment" do
        use_api api
        attribute :body
      end
    end

    describe :get do
      subject { User.get(:popular) }
      its(:length) { should == 2 }
      specify { expect(subject.first.id).to be 1 }
    end

    describe :get_raw do
      context "with a block" do
        specify do
          User.get_raw("/users") do |response|
            expect(response.body).to eq [{ :id => 1 }]
          end
        end
      end

      context "with a return value" do
        subject { User.get_raw("/users") }
        specify { expect(subject.body).to eq [{ :id => 1 }] }
      end
    end

    describe :get_collection do
      context "with a String path" do
        subject { User.get_collection("/users/popular") }
        its(:length) { should == 2 }
        specify { expect(subject.first.id).to be 1 }
      end

      context "with a Symbol" do
        subject { User.get_collection(:popular) }
        its(:length) { should == 2 }
        specify { expect(subject.first.id).to be 1 }
      end

      context "with extra parameters" do
        subject { User.get_collection(:popular, :page => 2) }
        its(:length) { should == 2 }
        specify { expect(subject.first.id).to be 3 }
      end
    end

    describe :get_resource do
      context "with a String path" do
        subject { User.get_resource("/users/1") }
        its(:id) { should == 1 }
      end

      context "with a Symbol" do
        subject { User.get_resource(:"1") }
        its(:id) { should == 1 }
      end
    end

    describe :post_raw do
      context "with a block" do
        specify do
          User.post_raw("/users", { id: 1 }) do |response|
            expect(response.body).to eq({ :id => 1 })
          end
        end
      end

      context "with a return value" do
        subject { User.post_raw("/users", { id: 1 }) }
        specify { expect(subject.body).to eq({ :id => 1 }) }
      end

      it "handles errors" do
        expect { Comment.post_raw("/comments") }.to raise_error ActiveService::Errors::BadRequest
      end
    end
  end

  context "setting custom HTTP requests" do
    before do
      api = ActiveService::API.new :url => "https://api.example.com" do |connection|
        connection.use ActiveService::Middleware::ParseJSON
        connection.adapter :test do |stub|
          stub.get("/users/popular") { |env| [200, {}, [{ :id => 1 }, { :id => 2 }].to_json] }
          stub.post("/users/from_default") { |env| [200, {}, { :id => 4 }.to_json] }
        end
      end

      spawn_model "User" do
        uses_api api
      end
    end

    subject { User }

    describe :custom_get do
      context "without cache" do
        before { User.custom_get :popular, :recent, on: :collection }
        it { should respond_to(:popular) }
        it { should respond_to(:recent) }

        context "making the HTTP request" do
          subject { User.popular }
          its(:length) { should == 2 }
        end
      end
    end

    describe :custom_post do
      before { User.custom_post :from_default, on: :member }
      it { should respond_to(:from_default) }

      context "making the HTTP request" do
        subject { User.from_default(:name => "Tobias Fünke") }
        its(:id) { should == 4 }
      end
    end
  end
end
