Return-Path: <virtio-dev-return-11025-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD79098663F
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Feb 2023 11:44:36 +0000 (UTC)
Date: Thu, 16 Feb 2023 06:44:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230216064301-mutt-send-email-mst@kernel.org>
References: <20230216073222.1208265-1-alvaro.karsz@solid-run.com>
 <9db3b645-cc5e-5b96-24b2-7b9fda67053c@linux.alibaba.com>
 <CAJs=3_DbSMTM=AmWqXAAE82Sa_JSJHzS=tss_UxsOFmc57HN6Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_DbSMTM=AmWqXAAE82Sa_JSJHzS=tss_UxsOFmc57HN6Q@mail.gmail.com>
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v4] virtio-net: Fix and update
 VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, david.edmondson@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 16, 2023 at 10:40:10AM +0200, Alvaro Karsz wrote:
> Hi Heng,
> 
> > > +When the device has non-zero \field{usecs} and non-zero \field{max_packets}, it starts counting usecs and packets upon receiving/sending a packet.
> > > +The device counts packets and usecs for each receive virtqueue and transmit virtqueue separately.
> > > +In this case, the notification conditions are met when \field{usecs} usecs elapses, or upon sending/receiving \field{max_packets} packets, whichever happens first.
> > > +
> >
> > Hi, Alvaro.
> >
> > "when \field{usecs} usecs elapses"  --> "when \field{usecs} elapses", right?
> 
> Actually, no.
> \field{usecs} refers to the field in the struct.
> usecs refers to the units of measurement.
> 
> So if for example \field{usecs} = 40, then it evaluates to 40 usecs ->
> "are met when 40 usecs elapses".

But this is not how it reads, people are not computers, and in the
compiled PDF \field{usec} just looks as usecs in italics.

> I can change the field name in the struct to "max_usecs" if people
> think it's necessary.

Maybe that's a good idea.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

