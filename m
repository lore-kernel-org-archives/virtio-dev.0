Return-Path: <pasic@linux.ibm.com>
Date: Wed, 11 Jan 2023 16:11:28 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] [PATCH v2 1/1] virtio-ism: introduce new device
 virtio-ism
Message-ID: <20230111161128.48e6d7e0.pasic@linux.ibm.com>
In-Reply-To: <1673435333.1297436-1-xuanzhuo@linux.alibaba.com>
References: <20221223081354.15026-1-xuanzhuo@linux.alibaba.com>
	<20221223081354.15026-2-xuanzhuo@linux.alibaba.com>
	<20230110233401.131cc97a.pasic@linux.ibm.com>
	<1673435333.1297436-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, wintera@linux.ibm.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 11 Jan 2023 19:08:53 +0800
Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> > > +ISM(Internal Shared Memory) device provides the ability to share mem=
ory between
> > > +different VMs launched from the same entity. =20
> >
> > Launched by instead of from? Maybe introduce a catchy name for the
> > "entity that launched the VMs" and prevent oversimplification by
> > explaining any shortcomings of the name if any in one place. Host would
> > be one candidate, VMM another. =20
>=20
> Cornelia Huck wrote:
>=20
> =09Is there a way to avoid the term "host" (throughout this document)?
> =09IIUC, you need the uniqueness within the scope of the entity that
> =09launches the different instances that get shared access to the regions
> =09(which could conceivably a unit of hardware?)
>=20
> And I think she is right, so I am trying to remove the term HOST.
>=20
> Do you have better opinions? I think VMM is not particularly suitable.

Well I'm don't know what Connie's objective was with that. Maybe she can
explain. My concern is calling it "the entity" is awfully vague and
calling it "the entity that launched the VMs" is awfully long.

Please notice that by being explicit about the launched entities being
VMs, you already know that the entity launching the VMs is a (host)
machine (which does not have to be a bare metal machine, but can be
a VM, a container).

From Wikipedia (https://en.wikipedia.org/wiki/Hypervisor): "A hypervisor
(also known as a virtual machine monitor, VMM, or virtualizer) is a type
of computer software, firmware or hardware that creates and runs virtual
machines. A computer on which a hypervisor runs one or more virtual
machines is called a host machine, and each virtual machine is called a
guest machine."

So I guess we could call it a host machine, a hypervisor instance.

On the other hand if we want to not mention (and kind of scope down to)
VMs either, we could try with something like originator or creator.

Either way, I would really like to get some more opinions on this,
especially Connie's.

Regards,
Halil
=20
=20

