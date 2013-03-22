class CommentsController < ApplicationController
	def create
		@post=Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    respond_to do |format|
      if @comment.save
         redirect_to @post, :notice => 'Post was successfully created.'
      else
        redirect_to :back , :notice => 'Error occured'
      end
    end
		# @comment = @post.comments.create(params[:comment]) 
		# redirect_to post_path(@post)
		# @post = Post.find(params[:post_id])
  #  		@comment = @post.comments.build(params[:comment])

  #  		begin
  #   		@comment.save!
  #    		redirect_to post_path(@post)
  #   	rescue Exception => error

  #    		puts "Error:: #{error.message}"
  #    		redirect_to :back #to not redirect
  #    	end
	end	

	def destroy
    	@post = Post.find(params[:post_id])
    	@comment = @post.comments.find(params[:id])
    	@comment.destroy
    	redirect_to post_path(@post)
  	end
end
