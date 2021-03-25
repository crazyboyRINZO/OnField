class CommentsController < ApplicationController
        before_action :authenticate_user!
      
        def create
          post = Post.find(params[:post_id])
          @comment = post.comments.build(comment_params)
          if @comment.save!
            flash[:success] = "コメントしました"
            redirect_back(fallback_location: root_path)
          else
            flash[:success] = "コメントできませんでした"
            redirect_back(fallback_location: root_path)
          end
        end
      
        private
      
          def comment_params
            params.require(:comment).permit(:content).merge(solo_user_id: current_user.id)
          end

      end
