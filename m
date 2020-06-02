Return-Path: virtio-dev-return-7435-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B3D5E985E07
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 Jun 2020 04:20:42 +0000 (UTC)
Date: Tue, 2 Jun 2020 00:20:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200602001440-mutt-send-email-mst@kernel.org>
References: <0592979c-c8ae-fd28-2ddf-e64b135a7292@redhat.com>
 <20200601015736-mutt-send-email-mst@kernel.org>
 <1768dfde-36c7-f0c7-89d1-8b3e3f99761d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1768dfde-36c7-f0c7-89d1-8b3e3f99761d@redhat.com>
Subject: Re: [virtio-dev] Re: queue_enable vs QueueReady
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jun 02, 2020 at 10:57:19AM +0800, Jason Wang wrote:
>=20
> On 2020/6/1 =E4=B8=8B=E5=8D=882:01, Michael S. Tsirkin wrote:
> > On Thu, May 28, 2020 at 09:06:36PM +0800, Jason Wang wrote:
> > > Hi:
> > >=20
> > > I found ambiguity in the virtio specification:
> > >=20
> > > In PCI part, it describes the queue_enable as:
> > >=20
> > > The driver uses this to selectively prevent the device from executing
> > > requests from this virtqueue. 1 - enabled; 0 - disabled.
> > >=20
> > > In MMIO part, it describes the QueueReady as:
> > >=20
> > > Writing one (0x1) to this register notifies the device that it can ex=
ecute
> > > requests from this virtual queue. Reading from this register returns =
the
> > > last value written to it. Both read and write accesses apply to the q=
ueue
> > > selected by writing to QueueSel.
> > >=20
> > > If I understand this correctly, they have the same meaning, but the d=
river
> > > requirements section looks conflict:
> > >=20
> > > PCI said: The driver MUST NOT write a 0 to queue_enable.
> > >=20
> > > MMIO said:
> > >=20
> > > To stop using the queue the driver MUST write zero (0x0) to this Queu=
eReady
> > > and MUST read the value back to ensure synchronization.
> > >=20
> > > So we can't disable a queue via queue_enable but QueueReady. Any reas=
on for
> > > such inconsistency?
> > >=20
> > > Thanks
> > PCI assumed device reset is enough to stop all queues.  We had tons of
> > bugs around shutdown because of this, so in hindsight, MMIO had maybe a
> > better idea.
> >=20
> > Ability to stop a queue and take back buffers would be nice, e.g. seria=
l
> > is kind of messed up around port disconnect without it.
>=20
>=20
> Yes, but this inconsistency brings trouble for vDPA implementation which =
has
> a set_queue_ready() and we do the following in virtio_vdpa as MMIO did:
>=20
> =C2=A0=C2=A0=C2=A0 /* Select and deactivate the queue */
> =C2=A0=C2=A0=C2=A0 ops->set_vq_ready(vdpa, index, 0);
> =C2=A0=C2=A0=C2=A0 WARN_ON(ops->get_vq_ready(vdpa, index));
>=20
> The codes seems to work fine for IFC (a violation of the spec probably) b=
ut
> not Qemu's virtio-net-pci.
>=20
> Thanks

What do you mean "not Qemu's virtio-net-pci"? Which implementation
of .set_vq_ready do you use?

According to spec, I would expect this callback to do something
other that writing into queue_enable.

BTW I noticed this:

        if (cmd =3D=3D VHOST_VDPA_SET_VRING_ENABLE) {
                if (copy_from_user(&s, argp, sizeof(s)))
                        return -EFAULT;
                ops->set_vq_ready(vdpa, idx, s.num);
                return 0;
        }

I'm guessing s.num should be 1, right?


--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

