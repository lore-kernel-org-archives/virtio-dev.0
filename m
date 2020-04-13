Return-Path: virtio-dev-return-7052-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 864659842BE
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Apr 2020 13:49:56 +0000 (UTC)
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
 <20200309030251-mutt-send-email-mst@kernel.org>
 <ff63b1e2-e4aa-1b13-0b4a-72fd23badc06@redhat.com>
 <20200309060238-mutt-send-email-mst@kernel.org>
 <fdedf8ac-74ed-f502-daef-38896f23e526@redhat.com>
 <20200310021729-mutt-send-email-mst@kernel.org>
 <89358cf3-7ce0-7b60-f4a7-2672970a635e@redhat.com>
 <CAJPjb1Jg3Md7GrzAG2-6hJk4YwmpkqDCLFWMpXrvvkUY=5pMpQ@mail.gmail.com>
 <0f43a280-5425-3a10-1312-22ea87d320ca@redhat.com>
 <CAJaqyWfeSgj=+RMM_Zy4gTAkNJ42Ax5Axvc8okHOhH7UTsxhaA@mail.gmail.com>
 <20200409170152-mutt-send-email-mst@kernel.org>
 <cf4a59a4-ee86-1d9e-147e-e30e586e2320@redhat.com>
 <CAJaqyWc3-swETnT-h43XcRD0N4CSvd7FM1tZKokHnEOBB0RNqw@mail.gmail.com>
 <CAJPjb1LU9Mo6uiRTQ7yFM97VDT58fXNa-SrrJhr0-axY4u6Gmw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0214783f-d2fc-eea9-7d46-625751776b80@redhat.com>
Date: Mon, 13 Apr 2020 21:49:47 +0800
MIME-Version: 1.0
In-Reply-To: <CAJPjb1LU9Mo6uiRTQ7yFM97VDT58fXNa-SrrJhr0-axY4u6Gmw@mail.gmail.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Rob Miller <rob.miller@broadcom.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/4/13 =E4=B8=8B=E5=8D=889:30, Rob Miller wrote:
>
>
> On Mon, Apr 13, 2020 at 8:16 AM Eugenio Perez Martin=20
> <eperezma@redhat.com <mailto:eperezma@redhat.com>> wrote:
>
>     On Fri, Apr 10, 2020 at 4:40 AM Jason Wang <jasowang@redhat.com
>     <mailto:jasowang@redhat.com>> wrote:
>     >
>     >
>     > On 2020/4/10 =E4=B8=8A=E5=8D=885:06, Michael S. Tsirkin wrote:
>     > > On Tue, Apr 07, 2020 at 11:52:46AM +0200, Eugenio Perez Martin
>     wrote:
>     > >> Hi!
>     > >>
>     > >> So, from the previous mails, it seems that monitoring the
>     used ring
>     > >> (and the packed descriptors) is a good first step in that
>     direction,
>     > >> as DPDK did. This way, the device does not need to worry
>     about the
>     > >> dirty page tracking using a bitmap and the PCI writes
>     limitation, and
>     > >> we can evaluate later the proposed alternatives:
>     > >> * Alternate used descriptors in packed.
>     > >> * vDPA interface for vDPA devices in a convenient format.
>     > >>
>     > >> Any thoughts? Do you think that we should start with another way=
?
>     > >>
>     > >> Thanks!
>     > > I am concerned that with software in data path, we'll hit RX queu=
e
>     > > underruns, won't we?
>     >
>     >
>     > Do you mean it will lose some performance? If yes, I think so.
>     >
>     >
>     > > Two ways to avoid underruns:
>     > > - dirty page tracking
>     > > - page faults
>     >
>     >
>     > It looks to me this will lead even worse performance than
>     software path?
>     > There will be lots of page faults during RX.
>     >
>     > Another direction is to track dirty pages via IOMMU. E.g recent
>     Intel
>     > IOMMU has EA and D bit which could be used for tracking pages
>     wrote by
>     > devices but not CPU.
>     >
>
>     So this could be added on top of the dirty tracking mechanism, isn't?
>     or would it be easier to start another-way around, and to start using
>     modern IOMMU and then extend to old generic code?
>
>     >
>     > >
>     > > I'm working on a proposal for page faults now.
>     >
>     >
>     > I guess it's better to have a transport independent method.
>     >
>     >
>     > > If someone wants
>     > > to work on dirty tracking in addition, that's also an option.
>     >
>     >
>     > I remember Rob mention some challenges of implementing dirty
>     bitmap, I
>     > wonder something like queue based interface would be better
>     (similar to
>     > Peter did for KVM)?
>     >
>
>     I think that the main challenge was to write bits instead of writes
>     using PCI bus.
>
>     From a conversation with Juan, another solution could be to do a byte
>     map DPT, where a byte represents a page, not a bit. While I find this
>     solution simpler, I'm not sure about the performance implications of
>     track this way (memory/TLB pressure, etc). Rob and Juan, please
>     correct me if I'm wrong or missed something.
>

It would lead large working set, but the actual impact may require=20
benchmark.


> RJM>] You captured it correctly. We (Broadcom) discussed the idea of
> using a byte (being 0xFF) which effectively indicate that 64KB were dirty=
,
> this would cause potentially refreshing pages to the remote that weren't
> needed to be refreshed, slowing down the migration. I like the idea of=20
> mapping
> a byte to a page, and teach QEMU (or vDPA, or ...) how to interpret.


That's a way to go, I think we can try to propose an API and move the=20
discussion upstream.


>
>     Compared to the used ring interposition, much more logic needs to be
>     in the device driver for both alternatives (byte mapping and queue),
>     isn't it?
>
> RJM> Yes, but this would (should) lead to best performance.


I agree, I think we can start from software support and discuss the=20
hardware support in parallel.

Thanks


>
>     > Thanks
>     >
>
>
>     ---------------------------------------------------------------------
>     To unsubscribe, e-mail:
>     virtio-dev-unsubscribe@lists.oasis-open.org
>     <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
>     For additional commands, e-mail:
>     virtio-dev-help@lists.oasis-open.org
>     <mailto:virtio-dev-help@lists.oasis-open.org>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

