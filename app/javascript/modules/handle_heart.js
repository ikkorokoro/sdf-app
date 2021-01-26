import $ from 'jquery'
import axios from 'modules/axios'

const listenGoodEvent = (articleId) => {
$('#notgood').on('click', () => {
  axios.post(`/articles/${articleId}/like`)
  .then((response) => {
    const likesCount = response.data.likesCount
    if (response.data.status === 'ok') {
      $('#good').removeClass('d-none')
      $('#notgood').addClass('d-none')
      $('#likes-count').text(likesCount)
    }
  })
  .catch((e) => {
    window.alert('Error')
    console.log(e)
  })
})
}
const listenNotGoodEvent = (articleId) => {
$('#good').on('click', () => {
  axios.delete(`/articles/${articleId}/like`)
  .then((response) => {
    const likesCount = response.data.likesCount
    if (response.data.status === 'ok') {
      $('#notgood').removeClass('d-none')
      $('#good').addClass('d-none')
      $('#likes-count').text(likesCount)
    }
  })
  .catch((e) => {
    window.alert('Error')
    console.log(e)
  })
})
}
export {
  listenNotGoodEvent,
  listenGoodEvent
}
