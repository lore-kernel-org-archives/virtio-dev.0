Return-Path: <virtio-dev-return-8332-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 03D5B986223
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jul 2021 15:25:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <9fa7575c80200335ee32c9269ce5efcf0a729be7.1626418413.git.viresh.kumar@linaro.org>
References: <9fa7575c80200335ee32c9269ce5efcf0a729be7.1626418413.git.viresh.kumar@linaro.org>
Date: Mon, 19 Jul 2021 17:25:01 +0200
Message-ID: <87im169vhu.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] Add .gitignore file
Content-Type: text/plain
To: Viresh Kumar <viresh.kumar@linaro.org>, virtio-dev@lists.oasis-open.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 16 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Add .gitignore to not see the unnecessary list of build generated files
> with commands like git status.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .gitignore | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 .gitignore

Thanks, pushed as editorial update.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

