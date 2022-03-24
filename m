Return-Path: <virtio-dev-return-9365-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 98DBC9864C6
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 Mar 2022 11:23:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220324103412.2740-1-mst@redhat.com>
References: <20220324103412.2740-1-mst@redhat.com>
Date: Thu, 24 Mar 2022 12:23:23 +0100
Message-ID: <87y20z61ck.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] packed-ring: fix some typos
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 24 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> flag is misnamed in a couple of places.

s//The VIRTQ_DESC_F_INDIRECT_FLAG /

>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  packed-ring.tex | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

