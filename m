Return-Path: virtio-dev-return-5992-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31B9A984175
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Aug 2019 10:19:54 +0000 (UTC)
Date: Mon, 19 Aug 2019 06:19:52 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <2032516350.9204869.1566209992338.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190814104253-mutt-send-email-mst@kernel.org>
References: <20190813125133.19754-1-pagupta@redhat.com> <20190814104253-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH] content: document console vq detach buffer
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com, amit@kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>


>=20
> On Tue, Aug 13, 2019 at 06:21:33PM +0530, Pankaj Gupta wrote:
> > This patch documents console special case where vq buffers
> > are deleted at port hotunplug time. This behavior is different in
> > other devices where vq buffers are deleted at device unplug time.
> >=20
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  content.tex | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/content.tex b/content.tex
> > index ee0d7c9..33e8ccc 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -497,6 +497,8 @@ \section{Device Cleanup}\label{sec:General
> > Initialization And Device Operation /
> >  of a live virtqueue.
> > =20
> >  Thus a driver MUST ensure a virtqueue isn't live (by device reset) bef=
ore
> >  removing exposed buffers.
> > +Console has a special property that when port is detached virtqueue is
> > considered stopped, device
> > +must not use any buffers, and it is legal to take buffers out of the
> > device.
> > =20
> >  \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options}
>=20
> I don't think that's enough, or a good way to do it.
>=20
> The assumption that once exposed buffers stay exposed until used
> is spread out in lots of places in the spec.

oh... I did not notice the other places.

> =09E.g.
> =09=092.6.6.1
> =09=09Driver Requirements: The Virtqueue Available Ring
> =09=09A driver MUST NOT decrement the available idx on a virtqueue (ie. t=
here is
> =09=09no way to =E2=80=9Cunexpose=E2=80=9D buffers).
>=20
> =09And in the packed ring part, e.g.
>=20
> =09A device MUST NOT use a descriptor unless it observes the VIRTQ_DESC_F=
_AVAIL
> =09bit in its flags
> =09being changed (e.g. as compared to the initial zero value). A device M=
UST
> =09NOT change a descriptor after
> =09changing it=E2=80=99s the VIRTQ_DESC_F_USED bit in its flags.
> =092.7.16
> =09Driver Requirements: The Virtqueue Descriptor Table
> =09A driver MUST NOT change a descriptor unless it observes the
> =09VIRTQ_DESC_F_USED bit in its flags being
> =09changed. A driver MUST NOT change a descriptor after changing the
> =09VIRTQ_DESC_F_AVAIL bit in its flags.
>=20
> So we need to document how exactly to revert added buffers in all
> these places. I propose adding special sections, explaining
> that some devices allow taking back available buffers.

Sure.

>=20
> We need to see how this interacts with other places in the spec:
> e.g. if we do allow taking back buffers, what happens with notifications
> such as when using event index? Are they resent when buffer is
> re-added?

o.k. Will check this.

>=20
>=20
> I also worry that since the spec said this can't happen, some
> hypervisors might implement a policy that will crash if the guest
> violates this rule.  Seems unlikely since Linux violated the rule for a
> while, but I'd suggest that you take a look at least at some open-source
> hypervisors to see what is going on.=20

Good point. I will check.

An alternative is a feature flag -
> if we do that I would actually advocate for a generic feature that
> allows stopping queues at any time, then restarting it. I think it would
> be handy generally for things like enabling/disabling XDP.

o.k. Good idea. Generic queue stopping will require additional work
e.g draining the queue and might require certain device specific operation.
Will look at this.
 =20

Thank you for the suggestions.

Best regards,
Pankaj


>=20
>=20
>=20
> > --
> > 2.21.0
>=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

