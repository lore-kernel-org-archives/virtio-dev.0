Return-Path: virtio-dev-return-7021-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ADBFC985EF2
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Apr 2020 10:11:01 +0000 (UTC)
Date: Wed, 8 Apr 2020 06:10:39 -0400 (EDT)
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1650583197.21149342.1586340639830.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAJaqyWfW5z=3_exw9q5J=1axXan7qUndTE=kuNQp42Jup2j2xA@mail.gmail.com>
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com> <20200310021729-mutt-send-email-mst@kernel.org> <89358cf3-7ce0-7b60-f4a7-2672970a635e@redhat.com> <CAJPjb1Jg3Md7GrzAG2-6hJk4YwmpkqDCLFWMpXrvvkUY=5pMpQ@mail.gmail.com> <0f43a280-5425-3a10-1312-22ea87d320ca@redhat.com> <CAJaqyWfeSgj=+RMM_Zy4gTAkNJ42Ax5Axvc8okHOhH7UTsxhaA@mail.gmail.com> <CAJPjb1KvZSgMxfUPnaeXfS=aRTJqNnoS7zpz-81zEhG4OWzHqA@mail.gmail.com> <CAJaqyWfW5z=3_exw9q5J=1axXan7qUndTE=kuNQp42Jup2j2xA@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Rob Miller <rob.miller@broadcom.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tsirkin <mst@redhat.com>, Juan Quintela <quintela@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


----- Original Message -----
> On Tue, Apr 7, 2020 at 12:28 PM Rob Miller <rob.miller@broadcom.com> wrote:
> >
> > Does this mean that SW takes over the datapath during LM?
> 
> "Takes over" sounds to me like solving the problem using failover to
> switch to a software interface to do the packet forwarding during
> migration [1]. In this solution, only the used ring needs to be spied
> or intercepted to communicate qemu the memory regions modified.
> 
> Not sure if this is what you had in mind.
> 
> [1] https://www.dpdk.org/wp-content/uploads/sites/35/2019/10/VirtioNet.pdf

Yes, so my understanding is, there's two way for doing software
assisted live migration:

1) Switch to a full software datapath. I think this is what you meant
   here, this work but may get more performance degradation.

2) Used ring relay, this means qemu will only take over the used ring,
   this means when migration start, qemu will teach hardware to use
   another (mediated) used ring, then qemu can inspect it and log the
   dirty page from there, and relay the content to the used ring used
   by guest. This can have better performance.

DPDK choose to use method 2). You may refer
https://www.dpdk.org/wp-content/uploads/sites/35/2018/12/XiaoWang-DPDK-US-Summit-SW-assisted-VDPA-for-LM-v2.pdf


> 
> > If so, is there any infrastructure to "gracefully" do a hand-off from HW
> > mode (pci device is managing the rings) to SW mode, in that when switching
> > from HW->SW, HW is stalled & quiesced, then the SW takes from where HW
> > left off?

Yes, for both methods, it requires a stop & start the device.

And it also means the device should support the recovery of virtqueue
state. E.g it supports a last_avail_idx set by driver, then when the
device is started, it can try to read avail ring index start at
last_avail_idx. This is why vDPA bus support set_vq_state().

Thanks

> >
> > Rob Miller
> > rob.miller@broadcom.com
> > (919)721-3339
> >
> >
> > On Tue, Apr 7, 2020 at 5:53 AM Eugenio Perez Martin <eperezma@redhat.com>
> > wrote:
> >>
> >> Hi!
> >>
> >> So, from the previous mails, it seems that monitoring the used ring
> >> (and the packed descriptors) is a good first step in that direction,
> >> as DPDK did. This way, the device does not need to worry about the
> >> dirty page tracking using a bitmap and the PCI writes limitation, and
> >> we can evaluate later the proposed alternatives:
> >> * Alternate used descriptors in packed.
> >> * vDPA interface for vDPA devices in a convenient format.
> >>
> >> Any thoughts? Do you think that we should start with another way?
> >>
> >> Thanks!
> >>
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

