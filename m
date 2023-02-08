Return-Path: <virtio-comment-return-4052-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 8 Feb 2023 12:38:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230208123630-mutt-send-email-mst@kernel.org>
References: <20230206084746.40536-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB54817FE12FD77CC74B36D136DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206160206-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818A5BD25527FEAEAFF6CCDCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206171410-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54806C5AF84EB7974D80FE0EDCDA9@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230207091242-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BBF4B010D1B197DEF27FDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481BBF4B010D1B197DEF27FDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-comment] RE: [virtio-dev] [PATCH] virtio-net: Fix and
 update VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 08, 2023 at 05:30:28PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, February 7, 2023 9:18 AM
> 
> > > Why migration generate too many spurious interrupts?
> > 
> > Because, you might want to migrate from hardware with to hardware without
> > coalescing features. So you just tell guest "sure I will coalesce" but in fact send
> > interrupts normally.
> 
> For the hardware that has fake coalescing, HV wouldn't know it anyway without doing pre verification.
> And HV may not migrate in such case for best experience.
> HV may choose to migrate with low accuracy as you say, which is fine.
> 
> But the spec guidance for the device implementations is to promote some reasonable level of accuracy.
> Hard to define in words here.
> Best effort is wide spectrum of range. :)
> 
> Typically, we say in the spec as SHOULD. 
> So, lets skip the best-effort wording and stick to SHOULD part like rest of the spec.

I think the point of best-effort is that driver must handle interrupts
that arrive earlier. This is how we used it elsewhere. What else does
it include in your opinion that we absolutely must exclude?
I feel it's a good fit for a non-conformance section which is
by nature a bit informal.

For a conformance section SHOULD is indeed a good fit.

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

