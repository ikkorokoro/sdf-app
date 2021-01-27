import $ from 'jquery'
import axios from 'modules/axios'
import {
listenNotGoodEvent,
listenGoodEvent
}from 'modules/handle_heart'

const handleControllerForm = () => {
  $('.show-comment-form').on('click', () => {
    $('.show-comment-form').addClass('d-none')
    $('.comment-text-area').removeClass('d-none')
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
  $('.comment').append(
    `<div class= "d-flex bg-white border w-50 mx-auto card-radius">
      <img class= "user-avatar"src="${(comment.avatar_url)}"</img>
      <span class= "ml-2 pt-2 sm-font">${(comment.display_name)}</span>
      <span class= "pt-2 font-weight-bold mx-auto">${(comment.content)}</span>
    </div>`
  )
}





document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#article-show').data()
  const articleId = dataset.articleId
  /* getリクエストを送り, commetsを取得し,
  それを一つずつ.comments-containerに追加する */
  axios.get(`/articles/${articleId}/comments`)
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
      axios.post(`/articles/${articleId}/comments`, {
        comment: { content: content }
      })
        .then((res) => { 
          const comment = res.data
          appendNewComment(comment)
          $('#comment_content').val('')
      })
    }
  })
  handleControllerForm()

  axios.get(`/articles/${articleId}/like`)
  .then((response) => {
    const hasLiked = response.data.hasLiked
    const likesCount = response.data.likesCount
    handleLikesDisplay(hasLiked, likesCount)
  })
  listenNotGoodEvent(articleId)
  listenGoodEvent(articleId)
})
