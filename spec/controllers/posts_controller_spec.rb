require "rails_helper"

RSpec.describe PostsController, type: :controller do
  let(:user) { create :user }
  let(:post_1) { create :post, user_id: user.id, created_at: Date.current }
  let(:post_2) { create :post, user_id: user.id, created_at: 1.days.from_now }
  let(:post_3) { create :post, user_id: user.id, created_at: 2.days.from_now }

  describe "GET #index" do
    before { get :index }

    it "should return HTTP status code 200" do
      expect(response).to have_http_status 200
    end

    it "should render view index" do
      expect(response).to render_template :index
    end

    it "should assign @posts to the view" do
      expect(assigns(:posts)).to eq [post_3, post_2, post_1]
      # or
      # expect(assigns(:posts).size).to eq 3
    end
  end

  describe "GET #show" do
    let(:params){{id: post_1.id}}
    before { get :show, params: params }

    it "should return HTTP status code 200" do
      expect(response).to have_http_status 200
    end

    it "should render view show" do
      expect(response).to render_template :show
    end

    it "should assigns @post to the view" do
      expect(assigns(:post)).to eq post_1
    end
  end

  describe "GET #new" do
    before { get :new }

    it "should return HTTP status code" do
      expect(response).to have_http_status 200
    end

    it "should render view new" do
      expect(response).to render_template :new
    end

    it "should assigns @post" do
      expect(assigns(:post).new_record?).to be true
    end
  end

  describe "POST #create" do
    let(:params) do
      { post: {user_id: user.id, title: Faker::Lorem.word, content: Faker::Lorem.paragraph_by_chars} }
    end

    context "when valid params" do
      before{ post :create, params: params }

      it "should create new post" do
        expect(assigns(:post).persisted?).to be true
      end

      it "should redirect to post_path" do
        expect(response).to redirect_to post_path(assigns(:post))
      end

      it "should show falsh success" do
        expect(flash[:notice]).to eq "Post was successfully created."
      end
    end

    context "when params invalid" do
      before do
        params[:post][:title] = ""
        post :create, params: params
      end

      it "should return HTTP status code" do
        expect(response).to have_http_status 200
      end

      it "should not exists in database" do
        expect(assigns(:post).persisted?).to be false
      end

      it "should render template new" do
        expect(response).to render_template :new
      end

      it "should return messages" do
        expect(flash[:danger]).to eq "Created faild."
      end
    end

    describe "GET #edit" do
      let (:params) { {id: post_1.id} }
      before { get :edit, params: params }

      it "should return http status code" do
        expect(response).to have_http_status 200
      end

      it "should render template edit" do
        expect(response).to render_template :edit
      end

      it "should assigns @post to the view" do
        expect(assigns(:post)).to eq post_1
      end
    end

    describe "PATCH #update" do
      let (:params) {{id: post_1, post: {title: Faker::Lorem.word}}}

      context "when params is invalid" do
        before do
          patch :update, params: params
          post_1.reload
        end

        it "should be change attribute" do
          expect(post_1.title).to eq params[:post][:title]
        end

        it "should redirect to posts_url" do
          expect(response).to redirect_to post_path post_1
        end

        it "should return flash message" do
          expect(flash[:notice]).to eq 'Post was successfully updated.'
        end
      end

      context "when params invalid" do
        before do
          params[:post][:title] = ""
          post_1.reload
          patch :update, params: params
        end

        it "should return http status code" do
          expect(response).to have_http_status 200
        end

        it "should not update attribute" do
          expect(post_1.title).not_to eq params[:post][:title]
        end

        it "should return redirect" do
          expect(response).to render_template :edit
        end

        it "should return flash message" do
          expect(flash[:danger]).to eq "Update faild."
        end
      end
    end

    describe "DELETE #destroy" do
      let(:params) {{id: post_1}}

      before {delete :destroy, params: params}

      it "should not exists @post in database" do
        expect(Post.exists? post_1.id).to be false
      end

      it "should redirect to post index" do
        expect(response).to redirect_to posts_path
      end

      it "should return messages destroy success" do
        expect(flash[:notice]).to eq "Post was successfully destroyed."
      end
    end
  end
end
