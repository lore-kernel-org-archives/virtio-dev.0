Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] Re: [PATCH v3] virtio-net: Mention
 VIRTIO_NET_F_HASH_REPORT dependency on VIRTIO_NET_F_CTRL_VQ
Date: Fri, 10 Feb 2023 18:42:23 +0000
Message-ID: <PH0PR12MB54815E20847C0A5EAF4EEC35DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230206080210.37758-1-alvaro.karsz@solid-run.com>
 <CAJs=3_C5AqOtaKjk_OWrG+U8SUFLSMez=-6M4JQsh3EEazj-KQ@mail.gmail.com>
In-Reply-To: <CAJs=3_C5AqOtaKjk_OWrG+U8SUFLSMez=-6M4JQsh3EEazj-KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Alvaro Karsz
>=20
> Should we have a vote?
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/158=20

I missed your previous response.
Sorry for the late response.

Why cannot device say as MUST requirement?

Let say there is a device out that exposes a F_HASH_REPORT without F_CTRL_V=
Q.
So driver tried to send a command and failed to issue cmd.
End result, hash config was not successful.
Did driver gain anything from seeing supplied hash in the config space?
No. it just confused driver that device offered feature bit, could see the =
supposed hash, but still couldn't configure it.

So, I think the right fix is that device MUST NOT set F_HASH_REPORT without=
 F_CTRL_VQ.

And driver should .. is fine, because existing driver that followed 1.2 wil=
l negotiate, and device will also accept it if it offered without F_CTRL_VQ=
.

Any new device that follows 1.3 will not offer F_HAS_REPORT without C_VQ, h=
ence it cannot be negotiated by driver without C_VQ.

The gain is : device doesn't need to continue offering F_HASH_REPORT withou=
t C_VQ. And I doubt if any device would have done it, as it was obvious.
Just the spec was missed out.

Is MUST/SHOULD big deal here for device? At least not to me, from practical=
 standpoint to me.
Making must just makes the spec consistent with rest without breaking backw=
ard compat.

