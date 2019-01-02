Return-Path: virtio-dev-return-5220-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D000B985B95
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Jan 2019 09:53:22 +0000 (UTC)
Date: Wed, 2 Jan 2019 10:53:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190102105314.0b4e2485.cohuck@redhat.com>
In-Reply-To: <20190101004019.7f20aafa@oc2783563651>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
	<c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
	<286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
	<20181230070600.512bbb8b@oc2783563651>
	<286AC319A985734F985F78AFA26841F73DEEC8DF@shsmsx102.ccr.corp.intel.com>
	<20190101004019.7f20aafa@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] RE: [PATCH v1 0/2] Virtio: fix some vq allocation
 issues
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Wang, Wei W" <wei.w.wang@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 1 Jan 2019 00:40:19 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 31 Dec 2018 06:03:51 +0000
> "Wang, Wei W" <wei.w.wang@intel.com> wrote:
>=20
> > On Sunday, December 30, 2018 2:06 PM, Halil Pasic wrote: =20
> > >=20
> > > I guess you are the first one trying to read virtio config from withi=
n interrupt
> > > context. AFAICT this never worked. =20
> >=20
> > I'm not sure about "never worked". It seems to work well with virtio-pc=
i.
> > But looking forward to hearing a solid reason why reading config inside
> > the handler is forbidden (if that's true). =20
>=20
> By "never worked" I meant "never worked with virtio-ccw". Sorry
> about the misunderstanding. Seems I've also failed to convey that I don't
> know if reading config inside the handler is forbidden or not. So please
> don't expect me providing the solid reasons you are looking forward to.

It won't work with the current code, and this is all a bit ugly :( More
verbose explanation below.

>=20
> >  =20
> > > About what happens. The apidoc of ccw_device_start() says it needs to=
 be
> > > called with the ccw device lock held, so ccw_io_helper() tries to tak=
e it (since
> > > forever I guess). OTOH do_cio_interrupt() takes the subchannel lock a=
nd
> > > io_subchannel_initialize_dev() makes the ccw device lock be the subch=
annel
> > > lock. That means when one tries to get virtio config form within a cio
> > > interrupt context we deadlock, because we try to take a lock we alrea=
dy have.
> > >=20
> > > That said, I don't think this limitation is by design (i.e. intended).
> > > Maybe Connie can help us with that question. AFAIK we have nothing
> > > documented regarding this (neither that can nor can't).

The main problem is that channel I/O is a fundamentally asynchronous
mechanism. As channel devices don't have the concept of config spaces
(or some other things that virtio needs), I decided to map
reading/writing the config space to channel commands. Starting I/O on a
subchannel always needs the lock (to avoid races on the subchannel),
and the asynchronous interrupt for that I/O needs the lock as well (for
the same reason; things like the scsw contain state that you want to
access without races). A config change also means that the subchannel
becomes state pending (and an interrupt is made pending), so the
subchannel lock is taken for that path as well. (Virtqueue
notifications are handled differently on modern QEMU, but that does not
come into play here.)

> > >=20
> > > Obviously, there are multiple ways around this problem, and at the mo=
ment
> > > I can't tell which would be my preferred one. =20
> >=20
> > Yes, it's also not difficult to tweak the virtio-balloon code to avoid =
that issue.
> > But if that's just an issue with ccw itself, I think it's better to twe=
ak ccw and
> > remain virtio-balloon unchanged.
> >  =20
>=20
> As I said, at the moment I don't have a preference regarding the fix,
> partly because I'm not sure if "reading config inside the handler" is OK
> or not. Maybe Connie or Michael can help us here. I'm however sure that
> commit 86a5597 "virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT"
> breaks virtio-balloon with the ccw transport (i.e. effectively breaks=20
> virtio-balloon on s390): it used to work before and does not work
> after.

Yes, that's unfortunate.

>=20
> AFAICT tweaking the balloon code may be simpler than tweaking the
> virtio-ccw (transport code). ccw_io_helper() relies on getting
> an interrupt when the issued IO is done. If virtio-ccw is buggy, it
> needs to be fixed, but I'm not sure it is.

I would not call virtio-ccw buggy, but it has some constraints that
virtio-pci apparently doesn't have (and which did not show up so far;
e.g. virtio-blk schedules a work item on config change, so there's no
deadlock there.)

One way to get out of that constraint (don't interact with the config
space directly in the config changed handler) would be to schedule a
work item in virtio-ccw that calls virtio_config_changed() for the
device. My understanding is that delaying the notification to a work
queue would be fine.

=46rom what I can see, that should make us safe on any modern QEMU (that
uses adapter interrupts). There still might be problems if we are using
classic subchannel interrupts for virtqueue notifications and the
handler interacts with the config space, but I'm not sure whether it is
worth spending time on that.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

