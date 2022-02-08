Return-Path: <mst@redhat.com>
Date: Tue, 8 Feb 2022 10:37:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/4] Add virtio Admin virtqueue
Message-ID: <20220208103637-mutt-send-email-mst@kernel.org>
References: <20220207052843-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548164CFE929F59EEDBD3557DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208014039-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548104AB80FA36544DB3D7D0DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <878rulv6kq.fsf@redhat.com>
 <PH0PR12MB54816EBF061770CC91E0435DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208084022-mutt-send-email-mst@kernel.org>
 <875yppv1z2.fsf@redhat.com>
 <20220208102341-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548176C6907729FA956FB81DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548176C6907729FA956FB81DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 08, 2022 at 03:35:58PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, February 8, 2022 8:56 PM
> 
> > > I might have been a bit too vague about what I had been thinking
> > > about. Let's do a sketch (intentionally without concrete sizes):
> > >
> > > +-------------------------------------------------------+
> > > | command                                               |
> > > +-------------------------------------------------------+
> > > | target type (0 - self, 1 - dev id, 2 - group id, ...  |
> > > +-------------------------------------------------------+
> > > | dev id                                                |
> > > +-------------------------------------------------------+
> > > | group id                                              |
> > > +-------------------------------------------------------+
> > > | command-specific data                                 |
> > > +-------------------------------------------------------+
> > > | response part                                         |
> > > +-------------------------------------------------------+
> > >
> > > 'dev id' would be valid for 'target type' == 1, 'group id' would be
> > > valid for 'target type' == 2. Alternatively, 'dev id' and 'group id'
> > > could be a single 'target id' field; if there's nothing better to use,
> > > it can simply contain a uuid.
> > 
> > I am not sure why do we have both dev id and group id.
> > They are never used together right?
> > Maybe just have an id length field if we can't agree on how much space to
> > reserve.
> This is what I propose in a previous email.
> A device id can be duplicate in different groups.
> So to build hierarchy group id will be desired.
> 
> So id[] array can contain nested one or multiple fields.

I guess nesting is for when there's like an SF within a VF?

-- 
MST

