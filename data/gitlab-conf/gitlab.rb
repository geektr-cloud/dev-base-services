external_url 'https://git.geektr.cloud'

nginx['listen_port'] = 80
nginx['listen_https'] = false

gitlab_rails['internal_api_url'] = 'https://git.geektr.cloud'

nginx['custom_error_pages'] = {
  '404' => {
    'title' => '404 Not Found',
    'header' => 'Ooooops!',
    'message' => '根据相关法律法规和政策，部分结果未予显示'
  }
}

gitlab_rails['gitlab_email_enabled'] = true
gitlab_rails['gitlab_email_from'] = 'yumemi@mail.geektr.cloud'
gitlab_rails['gitlab_email_display_name'] = 'Yumemi'
gitlab_rails['gitlab_email_reply_to'] = 'noreply@mail.geektr.cloud'
gitlab_rails['gitlab_email_subject_suffix'] = '[GeekTR/Git]'

gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = 'smtp.mailgun.org'
gitlab_rails['smtp_port'] = 587
gitlab_rails['smtp_authentication'] = 'plain'
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_user_name'] = 'yumemi@mail.geektr.cloud'
gitlab_rails['smtp_password'] = ENV['SMTP_PASSWORD']
gitlab_rails['smtp_domain'] = 'mail.geektr.cloud'

user['git_user_email'] = 'yumemi@mail.geektr.cloud'
