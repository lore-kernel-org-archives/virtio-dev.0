Return-Path: <virtio-dev-return-10660-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 25 Jan 2023 20:36:37 +0000
Message-ID: <PH0PR12MB5481751CDB682709DEA8165BDCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230112212550.763889-1-parav@nvidia.com>
 <20230125190454.043e54e0.pasic@linux.ibm.com>
 <PH0PR12MB548193F9D20E6C75CE29E3B4DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230125152146-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230125152146-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v10] virtio-net: Clarify VLAN filter
 table configuration
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, January 25, 2023 3:32 PM
>=20

> > So far I see two comments in version v10 that needs to be addressed.
> > 1. Correct the link the commit message to some past discussion.
> > 2. Drop "as per device configuration"
> >
> > Do you suggest V11?
> > Or it its ok, I prefer to write follow up "Fixes" patch to drop the per=
 device
> configuration part.
> > Given that we are closed to voting deadline, and change is not breaking=
 the
> spec.
> > Usually in other projects for minor things like above #1, maintainer ap=
plies
> the local change to commit log before applying the patch to avoid unneces=
sary
> churn of people's time.
> >
> > Please suggest next step on resolving it.
>=20
> Yea #1 does not matter much.
>=20
> This ballot
> =09https://lists.oasis-open.org/archives/virtio-
> dev/202301/msg00231.html
> is likely set to approve v10.
>=20
> If you really want to withdraw it you can request that.
>=20
> Alternatively post a patch on top, if it's a minor cleanup it can be appl=
ied
> without a vote. I'd say removing "as per device configuration" is probabl=
y a
> minor cleanup.
>
I am in middle of writing this fixes patch.
I will post a patch of this cleanup later today.

[..]
> >
> > In this patch we are not changing the spec.
>=20
> Well yes we do :) I think you mean we are not adding new features.
>=20
You are right. :)
We are not changing device or driver behavior in this patch...
We are improving/clarifying things in crisp details for betterment.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

