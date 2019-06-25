Return-Path: virtio-dev-return-5811-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F249F985A41
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Jun 2019 07:32:17 +0000 (UTC)
References: <20190625151535.GB25390@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b2e0488-38c0-3aba-a23b-567fc895fb85@redhat.com>
Date: Tue, 25 Jun 2019 09:32:13 +0200
MIME-Version: 1.0
In-Reply-To: <20190625151535.GB25390@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [RFC] Add polling mode feature bit
To: Conghui Chen <conghui.chen@intel.com>, virtio-dev@lists.oasis-open.org
Cc: shuo.a.liu@intel.com, yu1.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 25/06/19 17:15, Conghui Chen wrote:
> Hi,
> 
> We are working on enable VIRTIO on RTVMs. For RT requirements and some
> security reasons, the VIRTIO interrupts are not allowed to inject to
> guest OS, and the notify flow may bring some uncertain delay, so the
> polling mode for VIRTIO device is taken into consideration. And in some
> open source projects, like DPDK and OVMF, the polling mode is
> implemented on device level, but if a system need all the VIRTIO devices
> work on polling mode, then we should support it for each VIRTIO device
> type. That will take lots of effort and may not able to upstream, such
> as in RT-Linux. So, we wonder that, if we could support polling mode on
> VIRTIO framework level?
> 
> We have a proposal:
> Add a new feature bit: VIRTIO_F_PMD(39)
> This feature indicates that the driver should work in polling mode, and
> the device will not inject interrupt to Guest OS.

How would it work?  Is this a feature that, if acknowledged by the
driver, causes the device to disable all interrupts?  It's quite
possible that there are drivers in the wild that blindly accept all
features proposed by the device, and which would break with such a feature.

Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

