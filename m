Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] Re: [PATCH v3] virtio-net: Mention
 VIRTIO_NET_F_HASH_REPORT dependency on VIRTIO_NET_F_CTRL_VQ
Date: Sat, 11 Feb 2023 14:03:01 +0000
Message-ID: <PH0PR12MB5481B1B2F5648D78C618A92BDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230206080210.37758-1-alvaro.karsz@solid-run.com>
 <CAJs=3_C5AqOtaKjk_OWrG+U8SUFLSMez=-6M4JQsh3EEazj-KQ@mail.gmail.com>
 <PH0PR12MB54815E20847C0A5EAF4EEC35DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_B=veAoNPoLKkqtHcApajVn=82UzVfw63gr7YY+0J3m-w@mail.gmail.com>
In-Reply-To: <CAJs=3_B=veAoNPoLKkqtHcApajVn=82UzVfw63gr7YY+0J3m-w@mail.gmail.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Alvaro Karsz <alvaro.karsz@solid-run.com>
> Sent: Saturday, February 11, 2023 4:13 AM


> > Why cannot device say as MUST requirement?
> >
> > Let say there is a device out that exposes a F_HASH_REPORT without
> F_CTRL_VQ.
> > So driver tried to send a command and failed to issue cmd.
> > End result, hash config was not successful.
> > Did driver gain anything from seeing supplied hash in the config space?
> > No. it just confused driver that device offered feature bit, could see =
the
> supposed hash, but still couldn't configure it.
> >
> > So, I think the right fix is that device MUST NOT set F_HASH_REPORT wit=
hout
> F_CTRL_VQ.
> >
> > And driver should .. is fine, because existing driver that followed 1.2=
 will
> negotiate, and device will also accept it if it offered without F_CTRL_VQ=
.
> >
> > Any new device that follows 1.3 will not offer F_HAS_REPORT without C_V=
Q,
> hence it cannot be negotiated by driver without C_VQ.
> >
> > The gain is : device doesn't need to continue offering F_HASH_REPORT
> without C_VQ. And I doubt if any device would have done it, as it was obv=
ious.
> > Just the spec was missed out.
> >
> > Is MUST/SHOULD big deal here for device? At least not to me, from pract=
ical
> standpoint to me.
> > Making must just makes the spec consistent with rest without breaking
> backward compat.
>=20
> The first version of this patch [1] actually used a bit requirement (whic=
h is
> equivalent to a "MUST" if I understand correctly).
> Then Michael pointed out that we can't do it since a version was publishe=
d
> without this requirement.
>=20
> It's clear that the control VQ is required to use this feature.
> In the linux kernel implementation probe will fail if a device offers
> F_HASH_REPORT without F_CTRL_VQ.
>=20
This is even better.
> Ideally we'll add a "MUST", but since we can't,=20
Lets hear Michael's view, why MUST cannot be done.
Based on our discussion here, I think MUST is possible and cleaner without =
breaking any existing sw or device.

> our options are to have a
> "SHOULD", or not mention the dependency at all.
>=20
> [1] https://lists.oasis-open.org/archives/virtio-comment/202302/msg00026.=
html

