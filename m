Return-Path: <virtio-comment-return-3857-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 17 Jan 2023 10:18:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230117101430-mutt-send-email-mst@kernel.org>
References: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB5481A88FBABF45BC2736AC56DCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230116152504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548176D1EC760DB15826B08DDCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230116160634-mutt-send-email-mst@kernel.org>
 <CAJs=3_At3KQ0DvZ6P3bpZBvh9H3L5HHMeO-zq594dFG+MHA=bg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_At3KQ0DvZ6P3bpZBvh9H3L5HHMeO-zq594dFG+MHA=bg@mail.gmail.com>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v2] virtio_net: support low and high rate of
 notification coalescing
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 17, 2023 at 03:03:43PM +0200, Alvaro Karsz wrote:
> > By comparison this patch is an attempt to offload ethtool's
> > --coalesce parameters to the card. IMO what it misses is
> > completeness, e.g. sample-interval is not specified.
> 
> AFAIK sample-interval refers to the adaptive coalescing
> (adaptive-rx/adaptive-tx) and not to high/low.
> 
> include/uapi/linux/ethtool.h:
>  * @rate_sample_interval: How often to do adaptive coalescing packet rate
>  * sampling, measured in seconds.  Must not be zero.

Oh you are right. So sampling interval here is arbitrary,
defined by the device. Worth documenting.

> > Also, introspection is missing and it's useful to avoid
> > keeping all state in the driver.
> 
> I don't get it, can you please elaborate?

I mean --show-coalesce

-- 
MST


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

