Return-Path: <virtio-dev-return-9276-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 8 Feb 2022 15:35:58 +0000
Message-ID: <PH0PR12MB548176C6907729FA956FB81DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <20220207052843-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548164CFE929F59EEDBD3557DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208014039-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548104AB80FA36544DB3D7D0DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <878rulv6kq.fsf@redhat.com>
 <PH0PR12MB54816EBF061770CC91E0435DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208084022-mutt-send-email-mst@kernel.org> <875yppv1z2.fsf@redhat.com>
 <20220208102341-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220208102341-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v3 1/4] Add virtio Admin virtqueue
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 8, 2022 8:56 PM

> > I might have been a bit too vague about what I had been thinking
> > about. Let's do a sketch (intentionally without concrete sizes):
> >
> > +-------------------------------------------------------+
> > | command                                               |
> > +-------------------------------------------------------+
> > | target type (0 - self, 1 - dev id, 2 - group id, ...  |
> > +-------------------------------------------------------+
> > | dev id                                                |
> > +-------------------------------------------------------+
> > | group id                                              |
> > +-------------------------------------------------------+
> > | command-specific data                                 |
> > +-------------------------------------------------------+
> > | response part                                         |
> > +-------------------------------------------------------+
> >
> > 'dev id' would be valid for 'target type' =3D=3D 1, 'group id' would be
> > valid for 'target type' =3D=3D 2. Alternatively, 'dev id' and 'group id=
'
> > could be a single 'target id' field; if there's nothing better to use,
> > it can simply contain a uuid.
>=20
> I am not sure why do we have both dev id and group id.
> They are never used together right?
> Maybe just have an id length field if we can't agree on how much space to
> reserve.
This is what I propose in a previous email.
A device id can be duplicate in different groups.
So to build hierarchy group id will be desired.

So id[] array can contain nested one or multiple fields.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

