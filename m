Return-Path: <virtio-dev-return-11009-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDAB9986637
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Feb 2023 16:20:06 +0000 (UTC)
MIME-Version: 1.0
References: <20230215095409.1119696-1-alvaro.karsz@solid-run.com> <m25yc3xcch.fsf@oracle.com>
In-Reply-To: <m25yc3xcch.fsf@oracle.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 15 Feb 2023 18:19:27 +0200
Message-ID: <CAJs=3_BSMQAjHGN-cDBruxSE69reT+aFwUY8asLOpVF=1b-OgA@mail.gmail.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v3] virtio-net: Fix and update
 VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset="UTF-8"
To: David Edmondson <david.edmondson@oracle.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, hengqi@linux.alibaba.com, parav@nvidia.com, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

> > +\begin{note}
> > +In general, these commands are best-effort: spurious notifications could still arrive.
> > +\end{note}
>
> This is quite vague. How about:
>
> The behaviour of the device in response to these commands is
> best-effort: the device may generate notifications more frequently than
> specified, for example after less than \field{max_packets} packets have
> been processed or less than \field{usecs} usecs time has elapsed.
>
Looks good to me.
I'll add it to v4 if nobody objects.

Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

