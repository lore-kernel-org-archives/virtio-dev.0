Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2 1/4] Add virtio Admin Virtqueue
Date: Thu, 27 Jan 2022 03:56:32 +0000
Message-ID: <PH0PR12MB54819C554C805CDBB210AB99DC219@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-2-mgurtovoy@nvidia.com>
 <20220126093659-mutt-send-email-mst@kernel.org>
 <292327c4-1916-4237-a96c-13ed013fbef6@nvidia.com>
 <20220126095925-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220126095925-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, January 26, 2022 8:34 PM
>=20
> On Wed, Jan 26, 2022 at 04:54:22PM +0200, Max Gurtovoy wrote:
> >
> > On 1/26/2022 4:40 PM, Michael S. Tsirkin wrote:
> > > On Mon, Jan 24, 2022 at 11:39:15AM +0200, Max Gurtovoy wrote:
> > > > +Regardless of device offering VIRTIO_F_IN_ORDER, admin queue
> > > > +command buffers are used by the device in out of order manner.
> > > Instead of special-casing AQ I'd like to see a generic capability
> > > addressing this need. For example, TX for virtio net might benefit
> > > from this too. And I'd like to mention, again,
> > > VIRTIO_F_PARTIAL_ORDER proposal as one, arguably cleaner and more
> generic way to address this.
> >
> > We already suggested a special capability for IN_ORDER for AQ and you
> > asked to drop it. We drop it and agreed that AQ will be OOO.
> >
> > Why are we going back here ?
>=20
> That's a misunderstanding. Currently all VQs of a device follow same orde=
ring.
> So I suggested making AQ just follow ordering of rest of VQs of the devic=
e.
>=20
> > You also mentioned that this patch set is already big enough so why
> > solve all the problems we can think of in this one ?
>=20
> Right. So just leave the ordering be for now, driver can just skip IN_ORD=
ER and
> use AQ without it if it wants to.
>
Ok. I read your same suggestion as what I thought now.
It answers my previous email.

Thanks.

