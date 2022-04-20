Return-Path: <virtio-dev-return-9417-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 533AF98655D
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Apr 2022 12:56:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220419155421.132831-1-mst@redhat.com>
References: <20220419155421.132831-1-mst@redhat.com>
Date: Wed, 20 Apr 2022 14:56:38 +0200
Message-ID: <87zgkf7w1l.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] content.tex: drop space after \field
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 19 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> always use \field{foo} not \field {foo}, the latter confuses
> latexdiff.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, pushed as an editorial update.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

