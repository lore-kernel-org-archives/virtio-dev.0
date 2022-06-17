Return-Path: <virtio-dev-return-9601-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8DAA798674C
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jun 2022 10:30:28 +0000 (UTC)
Date: Fri, 17 Jun 2022 06:30:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220617062446-mutt-send-email-mst@kernel.org>
References: <6355541D-E117-4E7F-B5D9-3CD0028ED7FF@apple.com>
 <20220605162839-mutt-send-email-mst@kernel.org>
 <F7C60FF0-08AC-4C61-B9C3-85C161818DE5@apple.com>
MIME-Version: 1.0
In-Reply-To: <F7C60FF0-08AC-4C61-B9C3-85C161818DE5@apple.com>
Subject: Re: [virtio-dev] Clarification of VIRTIO_F_EVENT_IDX driver
 conditions.
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Patrick Mosca <pmosca@apple.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cameron Esfahani <dirty@apple.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jun 16, 2022 at 01:53:38PM -0700, Patrick Mosca wrote:
> The issue may trigger in the unlikely uint16_t overflow case of
> computing the difference between two index positions.

Are you sure this is not an implementation bug? I don't see
anywhere in the spec where we suggest computing the difference
between two index positions.

> An
> example would be a network driver where the host and guest are
> producing and consuming steadily but at different rates. The
> producer is producing faster than the consumer such that the
> consumer never needed to be notified of new events, as it is
> still playing catch up processing the queue.  If the producer
> finally catches up to the consumer and the catchup occurs just
> past the overflow point, there exists a case where a
> notification must be sent but is not sent according to the
> current ruleset. 
> 
> -Patrick Mosca

I don't see it sorry. Example?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

