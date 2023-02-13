Return-Path: <virtio-dev-return-10975-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8943E98637D
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Feb 2023 14:21:35 +0000 (UTC)
Date: Mon, 13 Feb 2023 09:21:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230213091947-mutt-send-email-mst@kernel.org>
References: <20230213083019.826388-1-alvaro.karsz@solid-run.com>
 <20230213055946-mutt-send-email-mst@kernel.org>
 <CAJs=3_AsGHMCvSQeP7pfrax1VAy4U+W0LmsaozGFuydqFUAiig@mail.gmail.com>
 <20230213072917-mutt-send-email-mst@kernel.org>
 <CAJs=3_B_ZXFg=ARoJYkoCQveeoo9myuL09U6KdSwtrMY1ias9Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_B_ZXFg=ARoJYkoCQveeoo9myuL09U6KdSwtrMY1ias9Q@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL
 feature
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, hengqi@linux.alibaba.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 13, 2023 at 03:43:55PM +0200, Alvaro Karsz wrote:
> I'll add an intro explaining how the entire coalescing thing works,
> without relying on the examples.
> 
> > > How about adding the following line in the main paragraph:
> > >
> > > Coalescing parameters are met when the number of sent/received packets
> > > reaches \field{tx_max_packets} since the last used buffer
> > > notification, or when \field{usecs} elapses since the last used buffer
> > > notification, whichever comes first.
> >
> > But this does mean we are tying things to used buffer
> > notifications which have their own suppression thing.
> > which yes is documented there but I would prefer to
> > make things easier to grok without jumping back and forth.
> > maybe we need a chapter explaining this idea.
> > E.g. add a concept of "a packet notification".
> > explain how they are suppressed and they may or may
> > not trigger a used buffer notification depending on whether
> > driver requested them.
> >
> 
> Honestly, having a "packet notification" concept that may evaluate to
> nothing seems a bit confusing to me.
> At the end of the day, the device sends used buffer notifications.
> 
> Eventually, we send a notification only if the notifications are not
> suppressed by the driver, so we'll need to refer to the section
> explaining how the notifications suppression works (and reader will
> need to jump to another paragraph), or we'll need to re-explain it in
> the NOTF_COAL paragraph (which seems redundant).
> 
> Maybe we can explain in the intro how the notifications coalescing
> works, and then mention that even if the coalescing parameters are met
> (this will be explained in the intro as well), we send a notification
> only if the notifications are not suppressed (then refer to the
> relevant part).
> 
> Seems ok to you?

ok so the event we are looking for is "coalescing parameters are met".
It is ok but I would like something that works even if
there is no coalescing. How about "notification conditions are met" then?
The coalescing parameters specify the conditions then


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

