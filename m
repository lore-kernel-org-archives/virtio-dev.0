Return-Path: virtio-dev-return-5990-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ADDF7983CCC
	for <virtio-dev@lists.oasis-open.org>; Sun, 18 Aug 2019 11:49:52 +0000 (UTC)
Date: Sun, 18 Aug 2019 07:49:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190814104253-mutt-send-email-mst@kernel.org>
References: <20190813125133.19754-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190813125133.19754-1-pagupta@redhat.com>
Subject: [virtio-dev] Re: [PATCH] content: document console vq detach buffer
To: Pankaj Gupta <pagupta@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com, amit@kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 13, 2019 at 06:21:33PM +0530, Pankaj Gupta wrote:
> This patch documents console special case where vq buffers
> are deleted at port hotunplug time. This behavior is different in
> other devices where vq buffers are deleted at device unplug time.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index ee0d7c9..33e8ccc 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -497,6 +497,8 @@ \section{Device Cleanup}\label{sec:General Initialization And Device Operation /
>  of a live virtqueue.
>  
>  Thus a driver MUST ensure a virtqueue isn't live (by device reset) before removing exposed buffers.
> +Console has a special property that when port is detached virtqueue is considered stopped, device
> +must not use any buffers, and it is legal to take buffers out of the device.
>  
>  \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options}

I don't think that's enough, or a good way to do it.

The assumption that once exposed buffers stay exposed until used
is spread out in lots of places in the spec.
	E.g.
		2.6.6.1
		Driver Requirements: The Virtqueue Available Ring
		A driver MUST NOT decrement the available idx on a virtqueue (ie. there is no way to “unexpose” buffers).

	And in the packed ring part, e.g.

	A device MUST NOT use a descriptor unless it observes the VIRTQ_DESC_F_AVAIL bit in its flags
	being changed (e.g. as compared to the initial zero value). A device MUST NOT change a descriptor after
	changing it’s the VIRTQ_DESC_F_USED bit in its flags.
	2.7.16
	Driver Requirements: The Virtqueue Descriptor Table
	A driver MUST NOT change a descriptor unless it observes the VIRTQ_DESC_F_USED bit in its flags being
	changed. A driver MUST NOT change a descriptor after changing the VIRTQ_DESC_F_AVAIL bit in its flags.

So we need to document how exactly to revert added buffers in all
these places. I propose adding special sections, explaining
that some devices allow taking back available buffers.

We need to see how this interacts with other places in the spec:
e.g. if we do allow taking back buffers, what happens with notifications
such as when using event index? Are they resent when buffer is
re-added?


I also worry that since the spec said this can't happen, some
hypervisors might implement a policy that will crash if the guest
violates this rule.  Seems unlikely since Linux violated the rule for a
while, but I'd suggest that you take a look at least at some open-source
hypervisors to see what is going on. An alternative is a feature flag -
if we do that I would actually advocate for a generic feature that
allows stopping queues at any time, then restarting it. I think it would
be handy generally for things like enabling/disabling XDP.



> -- 
> 2.21.0

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

