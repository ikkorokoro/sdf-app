import $ from 'jquery'
import axios from 'modules/axios'

const FollowBtnAndCountDisplay = (status, follower) => {
  if (status === 'ok') {
    $('#follow-btn').addClass('d-none')
    $('#unfollow-btn').removeClass('d-none')
    $('#follower-count').text(follower)
  }
}
const unFollowBtnAndCountDisplay = (status, follower) => {
  if (status === 'ok') {
    $('#follow-btn').removeClass('d-none')
    $('#unfollow-btn').addClass('d-none')
    $('#follower-count').text(follower)
  }
}


document.addEventListener('DOMContentLoaded', () => {
  const id = $('#show-account').data()
    const accountId = id.accountId

    /* ページ読み込み時にgetリクエストを送りフォロー、フォロワーの人数を表示、
    フォローしている時としていない時で表示を切り替える */
  axios.get(`/api/accounts/${accountId}/informations`)
  .then((response) => {
    const hasFollow = response.data.hasFollow
    const followers = response.data.followers
    const followings = response.data.followings
    $('#follower-count').text(followers)
    $('#following-count').text(followings)
    if (hasFollow) {
      $('#unfollow-btn').removeClass('d-none')
    } else {
      $('#follow-btn').removeClass('d-none')
    }
  })
  .catch((e) => {
    window.alert('Error')
    console.log(e)
  })
    /* フォローボタンを押すとpostリクエストを送る */
      $('#follow-btn').on('click', () => {
      axios.post(`/accounts/${accountId}/follows`)
      .then((response) => {
        const status = response.data.status
        const follower = response.data.follower
        FollowBtnAndCountDisplay(status, follower)
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
    })
    /* アンフォローボタンを押すとdeleteリクエストを送る */
    $('#unfollow-btn').on('click', () => {
      axios.post(`/accounts/${accountId}/unfollows`)
      .then((response) => {
        const status = response.data.status
        const follower = response.data.follower
        unFollowBtnAndCountDisplay(status, follower)
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
    })
  })