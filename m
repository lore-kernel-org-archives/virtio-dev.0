Return-Path: <virtio-dev-return-11080-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D51D498676D
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Feb 2023 10:57:55 +0000 (UTC)
Date: Fri, 17 Feb 2023 05:57:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230217055700-mutt-send-email-mst@kernel.org>
References: <20230216145611.1361327-1-alvaro.karsz@solid-run.com>
 <20230217043305-mutt-send-email-mst@kernel.org>
 <CAJs=3_Bkg+hRTaV2ooZHwOib666yFzRGgVosd_pO7EsZHokf-w@mail.gmail.com>
 <20230217052731-mutt-send-email-mst@kernel.org>
 <CAJs=3_B-q6NbtNTqZuwyHn6eENYb+NpUijDXvnwW55bBYQcyGg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_B-q6NbtNTqZuwyHn6eENYb+NpUijDXvnwW55bBYQcyGg@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v5] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL
 feature
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, hengqi@linux.alibaba.com, parav@nvidia.com, david.edmondson@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 17, 2023 at 12:36:32PM +0200, Alvaro Karsz wrote:
> > sounds good. maybe "counting packets and microseconds"? to make clear
> > timer resets too.
> >
> > > I don't really mind, If you think that the device implementation is
> > > not essential here and we should add your suggestion, I'm ok with
> > > that.
> >
> > I don't mind, your proposal seems good too.
> 
> Ok, so I'll add:
> "... whichever happens first.
> After  the notification conditions are met,

maybe just "afterwards" for brevity and to stress it is after sending interrupt
so it does not affect the interrupt only the next one.

> the device waits for the
> next packet and starts counting  packets and microseconds again."
> 
> Thanks!


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

