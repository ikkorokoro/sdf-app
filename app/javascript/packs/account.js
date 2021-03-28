import $ from 'jquery'
import axios from 'modules/axios'

const FollowBtnAndCountDisplay = (status, followerCount) => {
  if (status === 'ok') {
    $('#follow-btn').addClass('d-none')
    $('#unfollow-btn').removeClass('d-none')
    $('#follower-count').text(followerCount)
  }
}
const unFollowBtnAndCountDisplay = (status, followerCount) => {
  if (status === 'ok') {
    $('#follow-btn').removeClass('d-none')
    $('#unfollow-btn').addClass('d-none')
    $('#follower-count').text(followerCount)
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
    const followersCount = response.data.followersCount
    const followingsCount = response.data.followingsCount
    $('#follower-count').text(followersCount)
    $('#following-count').text(followingsCount)
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
        const followerCount = response.data.followerCount
        FollowBtnAndCountDisplay(status, followerCount)
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
        const followerCount = response.data.followerCount
        unFollowBtnAndCountDisplay(status, followerCount)
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
    })
  })