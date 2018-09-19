class MoviesController < ApplicationController
    before_action :set_movie, only: [:show, :edit, :update, :destroy]
    before_action :authorize, except: [:index]
    
    def index
        @movies = Movie.all
    end

    def show
        @movie = Movie.find(params[:id])
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)

        if @movie.save
            redirect_to movie_path(@movie)
        else
            redirect_to 'new'
        end
    end

    def edit
        @movie = Movie.find params[:id]
    end

    def update
        @movie = Movie.find params[:id]
        
        if @movie.update(movie_params)
            redirect_to movie_path(@movie)
        else
            render 'edit'
        end
    end

    def search
    
        # if params[:search].blank?  
        #     redirect_to(root_path, alert: "Empty field!") and return  
        #   else  
        #     @parameter = params[:search].downcase  
        #     @results = Store.all.where("lower(name) LIKE :search", search: @parameter) 
        # end  
    end

    def destroy
        @movie = Movie.find params[:id]

        @movie.destroy
        redirect_to root_path
        
    end

    private 

        def set_movie
        @movie = Movie.find(params[:id])
        end

        def movie_params 
            params.require(:movie).permit(:title, :description, :director, :runtime, :year, :rating, :image)
        end
end