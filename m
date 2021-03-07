Return-Path: virtio-dev-return-8104-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C2EE985D0A
	for <virtio-dev@lists.oasis-open.org>; Sun,  7 Mar 2021 21:53:04 +0000 (UTC)
References: <ad517312-871b-0382-20ab-12b1272057d5@in.tum.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <253ce592-b095-db5a-d7a0-19e215a78f1b@redhat.com>
Date: Sun, 7 Mar 2021 22:52:54 +0100
MIME-Version: 1.0
In-Reply-To: <ad517312-871b-0382-20ab-12b1272057d5@in.tum.de>
Subject: Re: [virtio-dev] How to register virtio MMIO device registers with
 KVM
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Peter Okelmann <okelmann@in.tum.de>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/03/21 21:57, Peter Okelmann wrote:
> Hi,
> 
> i'm looking into virtio over MMIO. How does KVM know which guest memory
> region contains MMIO device registers?
> As i understand KVM exits the VM with KVM_EXIT_MMIO when MMIO memory is
> accessed and for that it should know where it is.

Anything that isn't RAM (which is registered with 
KVM_SET_USER_MEMORY_REGION) will cause KVM_EXIT_MMIO.

That said, this is not in topic for this mailing list.

Paolo


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

