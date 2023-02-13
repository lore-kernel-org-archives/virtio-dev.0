Return-Path: <virtio-dev-return-10973-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6432A98635C
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Feb 2023 13:44:33 +0000 (UTC)
MIME-Version: 1.0
References: <20230213083019.826388-1-alvaro.karsz@solid-run.com>
 <20230213055946-mutt-send-email-mst@kernel.org> <CAJs=3_AsGHMCvSQeP7pfrax1VAy4U+W0LmsaozGFuydqFUAiig@mail.gmail.com>
 <20230213072917-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230213072917-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 13 Feb 2023 15:43:55 +0200
Message-ID: <CAJs=3_B_ZXFg=ARoJYkoCQveeoo9myuL09U6KdSwtrMY1ias9Q@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, hengqi@linux.alibaba.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

I'll add an intro explaining how the entire coalescing thing works,
without relying on the examples.

> > How about adding the following line in the main paragraph:
> >
> > Coalescing parameters are met when the number of sent/received packets
> > reaches \field{tx_max_packets} since the last used buffer
> > notification, or when \field{usecs} elapses since the last used buffer
> > notification, whichever comes first.
>
> But this does mean we are tying things to used buffer
> notifications which have their own suppression thing.
> which yes is documented there but I would prefer to
> make things easier to grok without jumping back and forth.
> maybe we need a chapter explaining this idea.
> E.g. add a concept of "a packet notification".
> explain how they are suppressed and they may or may
> not trigger a used buffer notification depending on whether
> driver requested them.
>

Honestly, having a "packet notification" concept that may evaluate to
nothing seems a bit confusing to me.
At the end of the day, the device sends used buffer notifications.

Eventually, we send a notification only if the notifications are not
suppressed by the driver, so we'll need to refer to the section
explaining how the notifications suppression works (and reader will
need to jump to another paragraph), or we'll need to re-explain it in
the NOTF_COAL paragraph (which seems redundant).

Maybe we can explain in the intro how the notifications coalescing
works, and then mention that even if the coalescing parameters are met
(this will be explained in the intro as well), we send a notification
only if the notifications are not suppressed (then refer to the
relevant part).

Seems ok to you?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

