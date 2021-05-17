Return-Path: virtio-dev-return-8164-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 144D7985DDD
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 May 2021 10:33:08 +0000 (UTC)
Date: Mon, 17 May 2021 12:33:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20210517123300.0ea826ef.cohuck@redhat.com>
In-Reply-To: <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
References: <20210505193655.2414268-1-egranata@google.com>
	<CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Fwd: [PATCH v2] Provide detailed specification of
 virtio-blk lifetime metrics
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Enrico Granata <egranata@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 5 May 2021 13:37:26 -0600
Enrico Granata <egranata@google.com> wrote:

> ---------- Forwarded message ---------
> From: Enrico Granata <egranata@google.com>
> Date: Wed, May 5, 2021 at 1:37 PM
> Subject: [PATCH v2] Provide detailed specification of virtio-blk
> lifetime metrics
> To: <virtio-dev@lists.oasis-open.org>
> Cc: <egranata@google.com>, <hch@infradead.org>, <mst@redhat.com>,
> <linux-block@vger.kernel.org>,
> <virtualization@lists.linux-foundation.org>
> 
> 
> In the course of review, some concerns were surfaced about the
> original virtio-blk lifetime proposal, as it depends on the eMMC
> spec which is not open
> 
> Add a more detailed description of the meaning of the fields
> added by that proposal to the virtio-blk specification, as to
> make it feasible to understand and implement the new lifetime
> metrics feature without needing to refer to JEDEC's specification
> 
> This patch does not change the meaning of those fields nor add
> any new fields, but it is intended to provide an open and more
> clear description of the meaning associated with those fields.
> 
> Signed-off-by: Enrico Granata <egranata@google.com>
> ---
> Changes in v2:
>   - clarified JEDEC references;
>   - added VIRTIO_BLK prefix and cleaned up comment syntax;
>   - clarified reserved block references
> 
>  content.tex | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)

Do we have a consent here? I see the mails are not showing up on all of
the lists, so I'm a bit confused regarding the state of this...


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

