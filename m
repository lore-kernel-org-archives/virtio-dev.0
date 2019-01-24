Return-Path: virtio-dev-return-5350-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85BF0985F3E
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 Jan 2019 16:04:18 +0000 (UTC)
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
 <20190123083435.x3svwqp472mdgglw@8bytes.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <a6315ab3-bffb-7470-365d-b26df6524bda@arm.com>
Date: Thu, 24 Jan 2019 16:03:55 +0000
MIME-Version: 1.0
In-Reply-To: <20190123083435.x3svwqp472mdgglw@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v7 0/7] Add virtio-iommu driver
To: Joerg Roedel <joro@8bytes.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "frowand.list@gmail.com" <frowand.list@gmail.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Joerg,

On 23/01/2019 08:34, Joerg Roedel wrote:
> Hi Jean-Philippe,
> 
> thanks for all your hard work on this!
> 
> On Tue, Jan 15, 2019 at 12:19:52PM +0000, Jean-Philippe Brucker wrote:
>> Implement the virtio-iommu driver, following specification v0.9 [1].
> 
> To make progress on this I think the spec needs to be close to something
> that can be included into the official virtio-specification. Have you
> proposed the specification for inclusion there?

I haven't yet. I did send a few drafts of the spec to the mailing list,
using arbitrary version numbers (0.1 - 0.9), and received excellent
feedback from Eric, Kevin, Ashok and others [2], but I hadn't formally
asked for inclusion yet. Since I haven't made any major change to the
interface in a while, I'll get on that.

> This is because I can't merge a driver that might be incompatible to
> future implementations because the specification needs to be changed on
> its way to an official standard.

Makes sense, though I think other virtio devices have been developed a
little more organically: device and driver code got upstreamed first,
and then the specification describing their interface got merged into
the standard. For example I believe that code for crypto, input and GPU
devices were upstreamed long before the specification was merged. Once
an implementation is upstream, the interface is expected to be
backward-compatible (all subsequent changes are introduced using feature
bits).

So I've been working with this process in mind, also described by Jens
at KVM forum 2017 [3]:
(1) Reserve a device ID, and get that merged into virtio (ID 23 for
virtio-iommu was reserved last year)
(2) Open-source an implementation (this driver and Eric's device)
(3) Formalize and upstream the device specification

But I get that some overlap between (2) and (3) would have been better.
So far the spec document has been reviewed mainly from the IOMMU point
of view, and might require more changes to be in line with the other
virtio devices -- hopefully just wording changes. I'll kick off step
(3), but I think the virtio folks are a bit busy with finalizing the 1.1
spec so I expect it to take a while.

Thanks,
Jean

[2] RFC https://markmail.org/thread/l6b2rpc46nua4egs
    0.4 https://markmail.org/thread/f5k37mab7tnrslin
    0.5 https://markmail.org/thread/tz65oolu5do7hi6n
    0.6 https://markmail.org/thread/dppbg6owzrx2km2n
    0.7 https://markmail.org/thread/dgdy4hicswpakmsq

[3] The future of virtio: riddles, myths and surprises
    https://www.linux-kvm.org/images/0/03/Virtio_fall_2017.pdf
    https://www.youtube.com/watch?v=z9cWwgYH97A


> I had a short discussion with Michael S. Tsirkin about that and from
> what I understood the spec needs to be proposed for inclusion on the
> virtio-comment[1] mailing list and later the TC needs to vote on it.
> Please work with Michael on this to get the specification official (or
> at least pretty close to something that will be part of the official
> virtio standard).
> 
> Regards,
> 
> 	Joerg
> 
> [1] https://www.oasis-open.org/committees/comments/index.php?wg_abbrev=virtio


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

