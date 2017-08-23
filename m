Return-Path: virtio-dev-return-2491-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A0D65818E00
	for <virtio-dev@lists.oasis-open.org>; Wed, 23 Aug 2017 06:55:24 -0700 (PDT)
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f9b02ce1-057f-df4f-90d7-52616ad60b88@redhat.com>
Date: Wed, 23 Aug 2017 15:55:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [RFC] virtio-iommu version 0.4
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, mst@redhat.com, jasowang@redhat.com, marc.zyngier@arm.com, eric.auger.pro@gmail.com, bharat.bhushan@nxp.com, peterx@redhat.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Jean-Philippe,

On 04/08/2017 20:19, Jean-Philippe Brucker wrote:
> This is the continuation of my proposal for virtio-iommu, the para-
> virtualized IOMMU. Here is a summary of the changes since last time [1]:
> 
> * The virtio-iommu document now resembles an actual specification. It is
>   split into a formal description of the virtio device, and implementation
>   notes. Please find sources and binaries at [2].
> 
> * Added a probe request to describe to the guest different properties that
>   do not fit in firmware or in the virtio config space. This is a
>   necessary stepping stone for extending the virtio-iommu.
> 
> * There is a working Qemu prototype [3], thanks to Eric Auger and Bharat
>   Bhushan.
> 
> You can find the Linux driver and kvmtool device at [4] and [5]. I
> plan to rework driver and kvmtool device slightly before sending the
> patches.
> 
> To understand the virtio-iommu, I advise to first read introduction and
> motivation, then skim through implementation notes and finally look at the
> device specification.
> 
> I wasn't sure how to organize the review. For those who prefer to comment
> inline, I attached v0.4 of device-operations.tex and topology.tex+MSI.tex
> to this thread. They are the biggest chunks of the document. But LaTeX
> isn't very pleasant to read, so you can simply send a list of comments in
> relation to section numbers and a few words of context, we'll manage.

Please find some comments/questions below:

2.6.7:1
I do not understand the footnode #6 sentence: 'Without a specific
definition of the ACK requirements for a given property type, it simply
means that the driver read all fields of that property."
2.6.7:2
what if the driver has not provided a big enough buffer and the device
cannot report all supported properties?
2.6.8.2:
Couldn't we use the same terminology as iommu_resv_type in iommu.h?
the negative form is not the easiest to understand for me.
Why F_MSI?
2.6.8.2.1
Multiple overlapping RESV_MEM properties are merged together. Device
requirement? if same types I assume?

what if the device is a physical assigned device. does the device report
the host doorbell or the guest doorbell, may be worth to clarify.

3.1.1 last paragraph
you talk about device ID but this is a terminology only known by ARM I
think. Actually it is introduced later in 3.1.2.

3.1.2
About ACPI integration. Isn't IORT ARM specific? Will other
architectures use that table? In IORT we also have Named Component node
which look pretty the same. Could you elaborate of the difference?
Device Object name: isn't it the path to the LNR0005 in the namespace?

Thanks

Eric
> 
> ---
> Version numbers 0.1-0.4 are arbitrary. I'm hoping they allow to compare
> more easily differences since the RFC (see [6]), but haven't been made
> public so far. This is the first public posting since initial proposal
> [1], and the following describes all changes.
> 
> ## v0.1 ##
> 
> Content is the same as the RFC, but formatted to LaTeX. 'make' generates
> one PDF and one HTML document.
> 
> ## v0.2 ##
> 
> Add introductions, improve topology example and firmware description based
> on feedback and a number of useful discussions.
> 
> ## v0.3 ##
> 
> Add normative sections (MUST, SHOULD, etc). Clarify some things, tighten
> the device and driver behaviour. Unmap semantics are consolidated; they
> are now closer to VFIO Type1 v2 semantics.
> 
> ## v0.4 ##
> 
> Introduce PROBE requests. They provide per-endpoint information to the
> driver that couldn't be described otherwise.
> 
> For the moment, they allow to handle MSIs on x86 virtual platforms (see
> 3.2). To do that we communicate reserved IOVA regions, that will also be
> useful for describing regions that cannot be mapped for a given endpoint,
> for instance addresses that correspond to a PCI bridge window.
> 
> Introducing such a large framework for this tiny feature may seem
> overkill, but it is needed for future extensions of the virtio-iommu and I
> believe it really is worth the effort.
> 
> ## Future ##
> 
> Other extensions are in preparation. I won't detail them here because v0.4
> already is a lot to digest, but in short, building on top of PROBE:
> 
> * First, since the IOMMU is paravirtualized, the device can expose some
>   properties of the physical topology to the guest, and let it allocate
>   resources more efficiently. For example, when the virtio-iommu manages
>   both physical and emulated endpoints, with different underlying IOMMUs,
>   we now have a way to describe multiple page and block granularities,
>   instead of forcing the guest to use the most restricted one for all
>   endpoints. This will most likely be in v0.5.
> 
> * Then on top of that, a major improvement will describe hardware
>   acceleration features available to the guest. There is what I call "Page
>   Table Handover" (or simply, from the host POV, "Nested"), the ability
>   for the guest to manipulate its own page tables instead of sending
>   MAP/UNMAP requests to the host. This, along with IO Page Fault
>   reporting, will also permit SVM virtualization on different platforms.
> 
> Thanks,
> Jean
> 
> [1] http://www.spinics.net/lists/kvm/msg147990.html
> [2] git://linux-arm.org/virtio-iommu.git branch viommu/v0.4
>     http://www.linux-arm.org/git?p=virtio-iommu.git;a=blob;f=dist/v0.4/virtio-iommu-v0.4.pdf
>     I reiterate the disclaimers: don't use this document as a reference,
>     it's a draft. It's also not an OASIS document yet. It may be riddled
>     with mistakes. As this is a working draft, it is unstable and I do not
>     guarantee backward compatibility of future versions.
> [3] https://lists.gnu.org/archive/html/qemu-arm/2017-08/msg00004.html
> [4] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.4
>     Warning: UAPI headers have changed! They didn't follow the spec,
>     please update. (Use branch v0.1, that has the old headers, for the
>     Qemu prototype [3])
> [5] git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.4
>     Warning: command-line has changed! Use --viommu vfio[,opts] and
>     --viommu virtio[,opts] to instantiate a device.
> [6] http://www.linux-arm.org/git?p=virtio-iommu.git;a=tree;f=dist/diffs
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

