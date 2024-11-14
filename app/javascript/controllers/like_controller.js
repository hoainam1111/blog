import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['icon', 'text'];

    updateLikeStatus(e){
        e.preventDefault();
        //get status if user loged in
        // if not , redirect to login page
        // Lấy trạng thái đăng nhập của người dùng từ thuộc tính data-user-logged-in của phần tử HTML.
        const isUserSignedIn = this.element.dataset.userLoggedIn;
        if(isUserSignedIn === "false"){
            document.querySelector(".js-login").click();
            return;
        }
        if(this.element.dataset.status === "false"){
            const postId = this.element.dataset.postId;
            const userId = this.element.dataset.userId;
            console.log("postId: " , postId);
            console.log("userId: " , userId);
            this.addLikedToPost(postId, userId);
        }
        else{
            const likeId = this.element.dataset.likeId;
            this.unlikedPost(likeId)
        }
    }
    addLikedToPost(postId, userId){
        const params = {
            post_id: postId,
            user_id: userId,
        };
        const options = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(params),
        };
        fetch('/api/likes', options)
        .then(response => {
            if (!response.ok){
                console.log(response.status);
            }
            return response.json();
        })
        .then(data => {
            this.element.dataset.likeId = data.id;
            this.element.dataset.status = "true";
            this.iconTarget.classList.remove("fill-none");
            this.iconTarget.classList.add("fill-blue-500");
            this.textTarget.innerText = "Liked";
        })
        .catch(e => {
            console.log(e);
        })
    }
    unlikedPost(likeId){
        fetch('/api/likes/' + likeId,{
            method: 'DELETE',
        })
        .then(response => {
            this.element.dataset.likeId = "";
            this.element.dataset.status = "false";
            this.iconTarget.classList.remove("fill-blue-500");
            this.iconTarget.classList.add("fill-none");
            this.textTarget.innerText = "Like";
        })
        .catch(e => {
            console.log(e);
        })
    }
}
