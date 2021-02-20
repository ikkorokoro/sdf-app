import $ from 'jquery'
import axios from 'modules/axios'
import {
listenNotGoodEvent,
listenGoodEvent
}from 'modules/handle_heart'

const handleControllerForm = () => {
  $('.comment-form').on('click', () => {
    $('.comment-form').addClass('d-none')
    $('.comment-area').removeClass('d-none')
  })
}

const handleLikesDisplay = (hasLiked, likesCount) => {
  if (hasLiked) {
    $('#good').removeClass('d-none')
    $('#likes-count').text(likesCount)
  } else {
    $('#notgood').removeClass('d-none')
    $('#likes-count').text(likesCount)
  }
}

const appendNewComment = (comment) => {
  $('.comments').append(
    `<div class= "d-flex bg-light border w-75 commment-box mx-auto">
       <a href= "/accounts/${(comment.user.id)}">
         <img class= "user-avatar mt-1"src="${(comment.avatar_url)}"</img>
       </a>
      <span class= "ml-2 mt-3 sm-font">${(comment.display_name)}</span>
      <span class= "mt-3 font-weight-bold mx-auto">${(comment.content)}</span>
    </div>`
  )
}





document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#article-show').data()
  const articleId = dataset.articleId
  /* getリクエストを送り, commetsを取得し,
  それを一つずつ.comments-containerに追加する */
  axios.get(`/api/articles/${articleId}/comments`)
    .then((response) => {
      const comments = response.data
      comments.forEach((comment) => { 
        appendNewComment(comment)
      })
    })
    .catch((error) => {
      window.alert('失敗')
    })

  $('#add-comment-button').on('click', () => {
    const content = $('#comment_content').val()
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      axios.post(`/api/articles/${articleId}/comments`, {
        comment: { content: content }
      })
        .then((response) => { 
          const comment = response.data
          appendNewComment(comment)
          $('#comment_content').val('')
          $('.comment-form').removeClass('d-none')
          $('.comment-area').addClass('d-none')
      })
    }
  })
  handleControllerForm()

  axios.get(`/api/articles/${articleId}/like`)
  .then((response) => {
    const hasLiked = response.data.hasLiked
    const likesCount = response.data.likesCount
    handleLikesDisplay(hasLiked, likesCount)
  })
  listenNotGoodEvent(articleId)
  listenGoodEvent(articleId)
})
