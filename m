Return-Path: <mst@redhat.com>
Date: Fri, 17 Feb 2023 04:31:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio-net: Define configuration field layout before
 its description
Message-ID: <20230217042935-mutt-send-email-mst@kernel.org>
References: <20230209045228.212309-1-parav@nvidia.com>
 <PH0PR12MB5481AD3ECF5D89295AF8395DDCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481AD3ECF5D89295AF8395DDCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 17, 2023 at 01:20:42AM +0000, Parav Pandit wrote:
> 
> 
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Wednesday, February 8, 2023 11:52 PM
> > 
> > Currently some fields of the virtio_net_config structure are defined before
> > introducing the structure and some are defined after introducing
> > virtio_net_config.
> > Better to define the configuration layout first followed by description of all the
> > fields.
> > 
> > Device configuration fields are described in the section. Change wording from
> > 'listed' to 'described' as suggested in patch [1].
> > 
> > While rewording the configuration layout, mention only one time that all the
> > fields of the configuration layout are read-only. Remove read-only wording
> > from individual fields.
> > 
> > [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00004.html
> > 
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> > changelog:
> > v1->v2:
> > - remove read-only wording from multiple places
> 
> Since there are no further comments, can you please take this further?

Sorry about the delay, responded now.

> It is only editorial change.

It's a bit on the border for minor corrections. But I feel
we really should add a normative statement too, and that
will probably push it into the "need a vote" territory.

