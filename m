Return-Path: virtio-dev-return-7049-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 98BA39842BE
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Apr 2020 12:16:01 +0000 (UTC)
MIME-Version: 1.0
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
 <20200309030251-mutt-send-email-mst@kernel.org> <ff63b1e2-e4aa-1b13-0b4a-72fd23badc06@redhat.com>
 <20200309060238-mutt-send-email-mst@kernel.org> <fdedf8ac-74ed-f502-daef-38896f23e526@redhat.com>
 <20200310021729-mutt-send-email-mst@kernel.org> <89358cf3-7ce0-7b60-f4a7-2672970a635e@redhat.com>
 <CAJPjb1Jg3Md7GrzAG2-6hJk4YwmpkqDCLFWMpXrvvkUY=5pMpQ@mail.gmail.com>
 <0f43a280-5425-3a10-1312-22ea87d320ca@redhat.com> <CAJaqyWfeSgj=+RMM_Zy4gTAkNJ42Ax5Axvc8okHOhH7UTsxhaA@mail.gmail.com>
 <20200409170152-mutt-send-email-mst@kernel.org> <cf4a59a4-ee86-1d9e-147e-e30e586e2320@redhat.com>
In-Reply-To: <cf4a59a4-ee86-1d9e-147e-e30e586e2320@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 13 Apr 2020 14:15:18 +0200
Message-ID: <CAJaqyWc3-swETnT-h43XcRD0N4CSvd7FM1tZKokHnEOBB0RNqw@mail.gmail.com>
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Rob Miller <rob.miller@broadcom.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 10, 2020 at 4:40 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/4/10 =E4=B8=8A=E5=8D=885:06, Michael S. Tsirkin wrote:
> > On Tue, Apr 07, 2020 at 11:52:46AM +0200, Eugenio Perez Martin wrote:
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
> > I am concerned that with software in data path, we'll hit RX queue
> > underruns, won't we?
>
>
> Do you mean it will lose some performance? If yes, I think so.
>
>
> > Two ways to avoid underruns:
> > - dirty page tracking
> > - page faults
>
>
> It looks to me this will lead even worse performance than software path?
> There will be lots of page faults during RX.
>
> Another direction is to track dirty pages via IOMMU. E.g recent Intel
> IOMMU has EA and D bit which could be used for tracking pages wrote by
> devices but not CPU.
>

So this could be added on top of the dirty tracking mechanism, isn't?
or would it be easier to start another-way around, and to start using
modern IOMMU and then extend to old generic code?

>
> >
> > I'm working on a proposal for page faults now.
>
>
> I guess it's better to have a transport independent method.
>
>
> > If someone wants
> > to work on dirty tracking in addition, that's also an option.
>
>
> I remember Rob mention some challenges of implementing dirty bitmap, I
> wonder something like queue based interface would be better (similar to
> Peter did for KVM)?
>

I think that the main challenge was to write bits instead of writes
using PCI bus.

From a conversation with Juan, another solution could be to do a byte
map DPT, where a byte represents a page, not a bit. While I find this
solution simpler, I'm not sure about the performance implications of
track this way (memory/TLB pressure, etc). Rob and Juan, please
correct me if I'm wrong or missed something.

Compared to the used ring interposition, much more logic needs to be
in the device driver for both alternatives (byte mapping and queue),
isn't it?

> Thanks
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

