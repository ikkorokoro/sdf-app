import $ from 'jquery'
import axios from 'modules/axios'

const handleControllerForm = () => {
  /* .show-commentをクリックすると.show-commentに.hiddenが追加され
      .comment-text-areaの.hiddenが削除される*/
  $('.show-comment-form').on('click', () => {
    $('.show-comment-form').addClass('d-none')
    $('.comment-text-area').removeClass('d-none')
  })
}

const appendNewComment = (comment) => {
  $('.comment').append(//appendはタグの中にhtmlのタグを追加していく
    `<div class= "d-flex bg-white border w-50 mx-auto card-radius">
      <img class= "user-avatar"src="${(comment.avatar_url)}"</img>
      <span class= "ml-2 pt-2 sm-font">${(comment.display_name)}</span>
      <span class= "pt-2 font-weight-bold mx-auto">${(comment.content)}</span>
    </div>`
  )
}

const handleHeartDisplay = (hasLiked, likesCount) => {
  if (hasLiked) {
    $('.good').removeClass('d-none')
    $('#likes-count').text(likesCount)
  } else {
    $('.notgood').removeClass('d-none')
    $('#likes-count').text(likesCount)
  }
}



document.addEventListener('turbolinks:load', () => {
  const dataset = $('#article-show').data()
  const articleId = dataset.articleId//articleIdを取得
  /* getリクエストを送り, commetsを取得し,
  それを一つずつ.comments-containerに追加する */
  axios.get(`/articles/${articleId}/comments`)
    .then((response) => {
      const comments = response.data
      comments.forEach((comment) => { //foreachはeachと同じ
        appendNewComment(comment)
      })
    })
    .catch((error) => {
      window.alert('失敗')
    })

  $('.add-comment-button').on('click', () => {
    const content = $('#comment_content').val()//.valは属性の値を取得する
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      axios.post(`/articles/${articleId}/comments`, {
        comment: { content: content }//parameterの指定をする.ハッシュのハッシュの構造にする
      })
        .then((res) => { //resが帰ってきたらcomment追加する
          const comment = res.data
          appendNewComment(comment)
          $('#comment_content').val('')//コメント追加後にformの中を空にする
      })
    }
  })
  handleControllerForm()

  axios.get(`/articles/${articleId}/like`)
  .then((response) => {
    const hasLiked = response.data.hasLiked
    const likesCount = response.data.likesCount
    handleHeartDisplay(hasLiked, likesCount)
  })

    $('.notgood').on('click', () => {
      axios.post(`/articles/${articleId}/like`)
      .then((response) => {
        const likesCount = response.data.likesCount
        if (response.data.status === 'ok') {
          $('.good').removeClass('d-none')
          $('.notgood').addClass('d-none')
          $('#likes-count').text(likesCount)
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
    })

    $('.good').on('click', () => {
      axios.delete(`/articles/${articleId}/like`)
      .then((response) => {
        const likesCount = response.data.likesCount
        if (response.data.status === 'ok') {
          $('.notgood').removeClass('d-none')
          $('.good').addClass('d-none')
          $('#likes-count').text(likesCount)
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
    })
  })
