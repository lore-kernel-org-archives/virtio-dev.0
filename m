Return-Path: virtio-dev-return-5229-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0FE94983D45
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Jan 2019 06:13:00 +0000 (UTC)
Message-ID: <5C2DA92E.9090503@intel.com>
Date: Thu, 03 Jan 2019 14:18:22 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com> <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
In-Reply-To: <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v1 0/2] Virtio: fix some vq allocation issues
To: Christian Borntraeger <borntraeger@de.ibm.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: pbonzini@redhat.com, dgilbert@redhat.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/28/2018 03:57 PM, Christian Borntraeger wrote:
>
> On 28.12.2018 03:26, Wei Wang wrote:
>> Some vqs don't need to be allocated when the related feature bits are
>> disabled. Callers notice the vq allocation layer by setting the related
>> names[i] to be NULL.
>>
>> This patch series fixes the find_vqs implementations to handle this case.
> So the random crashes during boot are gone.
> What still does not work is actually using the balloon.
>
> So in the qemu monitor using lets say "balloon 1000"  will hang the guest.
> Seems to be a deadlock in the virtio-ccw code.  We seem to call the
> config code in the interrupt handler.

Please try with applying both this series and the "virtio-balloon: tweak 
config_changed"
series that I just sent.
This series fixes the ccw booting issue and that series tries to fix the 
ccw deadlock issue.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

