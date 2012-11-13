class ArticlesController < ApplicationController
  before_filter :load_article, :only => [:show, :edit, :destroy]
  before_filter :upcaser, :only => [:index]
  before_filter :filter_comments, :only => [:show]
  around_filter :flash_apology, :only => [:index]
  # around_filter :flash_apology, :only => [:show, :edit, :destroy]
  # GET /articles
  # GET /articles.json

  def index
    @articles = Article.all
    raise if @articles.blank?

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article  = Article.includes(:comments).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  private
    def load_article
      @article = Article.find(params[:id])
    end

    def upcaser
      @articles = Article.all
      @articles.each do |a|
        a.title.upcase!
      end
    end

    def filter_comments
      @comments = @article.comments.each do |c|
        c.body.gsub!('sad', 'happy')
      end
    end

    def blank_articles
      begin
        yield
      rescue
        render :text => "No Articles"
      end
    end

    def flash_apology
      begin
        yield
      rescue
        redirect_to new_article_path, notice: 'Sorry'
      end
    end
end
