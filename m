Return-Path: virtio-dev-return-5498-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A6519860E5
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Feb 2019 09:21:58 +0000 (UTC)
References: <bd73e7d3-b9ed-24bb-a22d-cd81f0239acd@kernkonzept.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05b89b63-6842-ceab-5a15-d5a392e60f50@redhat.com>
Date: Fri, 22 Feb 2019 10:21:52 +0100
MIME-Version: 1.0
In-Reply-To: <bd73e7d3-b9ed-24bb-a22d-cd81f0239acd@kernkonzept.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] virtio-blk: the nature of discard_sector_alignment
To: Jakub Jermar <jakub.jermar@kernkonzept.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 21/02/19 17:38, Jakub Jermar wrote:
> 
> my device enforces the discard_sector_alignment on the request (both
> sector and num_sectors), but for some reason the blkdiscard command and
> Linux driver issue requests that do not honor this alignment.
> 
> Does discard_sector_alignment represent a strict requirement that must
> be always honored or is it rather a hint to the driver?

It's a hint that misaligned requests might not result in any discard
happening at all.

> The wording in the spec seems to be more lenient while in Linux the
> field is documented rather strictly:
The spec is correct.

Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

