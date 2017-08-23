Return-Path: virtio-dev-return-2490-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 56FF558191FA
	for <virtio-dev@lists.oasis-open.org>; Wed, 23 Aug 2017 02:58:30 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
Message-ID: <5be484ff-6a1a-6c9b-947c-f64ea23f58cc@arm.com>
Date: Wed, 23 Aug 2017 11:01:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC] virtio-iommu version 0.4
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, mst@redhat.com, jasowang@redhat.com, marc.zyngier@arm.com, eric.auger@redhat.com, eric.auger.pro@gmail.com, bharat.bhushan@nxp.com, peterx@redhat.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 04/08/17 19:19, Jean-Philippe Brucker wrote:
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

In order to extend requests with PASIDs and (later) nested mode, I intend
to rename "address_space" field to "domain", since it is a lot more
precise about what the field is referring to and the current name would
make these extensions confusing. Please find the rationale at [1].
"ioasid_bits" will be "domain_bits" and "VIRTIO_IOMMU_F_IOASID_BITS" will
be "VIRTIO_IOMMU_F_DOMAIN_BITS".

For those that had time to read this version, do you have other comments
and suggestions about v0.4? Otherwise it is the only update I have for
v0.5 (along with fine-grained address range and page size properties from
the quoted text) and I will send it soon.

In particular, please tell me now if you see the need for other
destructive changes like this one. They will be impossible to introduce
once a driver or device is upstream.

Thanks,
Jean

[1] https://www.spinics.net/lists/kvm/msg154573.html

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

