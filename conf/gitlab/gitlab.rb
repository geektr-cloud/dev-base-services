external_url 'https://git.geektr.cloud'

gitlab_rails['internal_api_url'] = 'https://git.geektr.cloud'

nginx['custom_error_pages'] = {
  '404' => {
    'title' => '404 Not Found',
    'header' => 'Ooooops!',
    'message' => '根据相关法律法规和政策，部分搜索结果未予显示'
  }
}

# gitlab_rails['smtp_enable'] = true
# gitlab_rails['smtp_address'] = "mail.geektr.cloud"
# gitlab_rails['smtp_port'] = 587
# gitlab_rails['smtp_authentication'] = "plain"
# gitlab_rails['smtp_enable_starttls_auto'] = true
# gitlab_rails['smtp_user_name'] = "yumemi@mail.geektr.cloud"
# gitlab_rails['smtp_password'] = "$SMTP_PASSWORD"
# gitlab_rails['smtp_domain'] = "mail.geektr.cloud"
