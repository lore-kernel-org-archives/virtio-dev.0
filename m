Return-Path: virtio-dev-return-7153-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC27798609D
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Apr 2020 07:54:09 +0000 (UTC)
Date: Fri, 24 Apr 2020 09:53:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20200424095354.03008d1e.cohuck@redhat.com>
In-Reply-To: <69ff8fd6-8f34-bf8a-2a8c-a1c4947383a6@redhat.com>
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
	<20200422182120.12258.67417.stgit@localhost.localdomain>
	<2d335814-c7eb-970b-5973-13dcdc7e0f12@redhat.com>
	<CAKgT0UeiKxy8AjrfoKRA9tV-8+nRMfEKjp1qCVcRoLhGs-oLew@mail.gmail.com>
	<46fb7362-0ec7-d27d-a8bc-458e9ae0beea@redhat.com>
	<CAKgT0Ucczmk2nG-yP8_Dfh1vFc5W242Q3=cMOQrG8aHG_6KFfw@mail.gmail.com>
	<69ff8fd6-8f34-bf8a-2a8c-a1c4947383a6@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v21 QEMU 4/5] virtio-balloon: Implement support for page
 poison tracking feature
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: David Hildenbrand <david@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, "Michael S.
 Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 24 Apr 2020 09:07:25 +0200
David Hildenbrand <david@redhat.com> wrote:

> >>  GlobalProperty hw_compat_4_2[] = {
> >>      { "virtio-blk-device", "queue-size", "128"},
> >>      { "virtio-scsi-device", "virtqueue_size", "128"},  
> > 
> > Okay, so the bit above is for after 5_0 is released then? Is there a  
> 
> Yes.
> 
> > way to queue up a reminder or something so we get to it when the time
> > comes, or I just need to watch for 5.0 to come out and submit a patch
> > then?  
> 
> I think what happened usually happens is that someone introduces all the
> compat machines, sometimes directly with empty hw_compat.
> 
> E.g., see
> 
> commit 3eb74d2087d3bd6cb51c06a49ba94222248d2de4
> Author: Cornelia Huck <cohuck@redhat.com>
> Date:   Tue Nov 12 11:48:11 2019 +0100
> 
>     hw: add compat machines for 5.0
> 
>     Add 5.0 machine types for arm/i440fx/q35/s390x/spapr.
> 
> and
> 
> commit 9aec2e52ce9d9632a86be2d1d0dd493722d2e7be
> Author: Cornelia Huck <cohuck@redhat.com>
> Date:   Wed Jul 24 12:35:24 2019 +0200
> 
>     hw: add compat machines for 4.2
> 
>     Add 4.2 machine types for arm/i440fx/q35/s390x/spapr.
> 
> 
> The latter already introduced hw_compat_4_1, for examnple.
> 
> @Conny, do you already have a patch for 5.1 compat patch lying around
> somewhere?

Not yet, will do so now. Thanks for the reminder, nearly forgot about
that :)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

