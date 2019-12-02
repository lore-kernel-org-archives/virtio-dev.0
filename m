Return-Path: virtio-dev-return-6435-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 38E60985A86
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Dec 2019 12:40:25 +0000 (UTC)
Date: Mon, 2 Dec 2019 13:40:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20191202134014.3b81bad3.cohuck@redhat.com>
In-Reply-To: <20191202100216.133556-1-stefanha@redhat.com>
References: <20191202100216.133556-1-stefanha@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] virtio-blk: document VIRTIO_BLK_T_GET_ID
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon,  2 Dec 2019 10:02:16 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> The VIRTIO_BLK_T_GET_ID request type was implemented in Linux and QEMU
> in 2010.  It does not have a feature bit but devices respond with
> VIRTIO_BLK_S_UNSUPP if a request type is unimplemented.
> 
> This patch documents the VIRTIO_BLK_T_GET_ID request type as currently
> implemented in Linux and QEMU.
> 
> Suggested-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  content.tex | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

