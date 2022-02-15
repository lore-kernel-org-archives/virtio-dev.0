Return-Path: <virtio-dev-return-9298-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B2A198641C
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 Feb 2022 11:42:32 +0000 (UTC)
Message-ID: <e85b6271-5510-959b-efdc-7ba318f114bc@redhat.com>
Date: Tue, 15 Feb 2022 12:42:26 +0100
MIME-Version: 1.0
References: <20220214195908.4070138-1-kalutes@google.com>
From: David Hildenbrand <david@redhat.com>
In-Reply-To: <20220214195908.4070138-1-kalutes@google.com>
Subject: [virtio-dev] Re: [PATCH] Virtio-balloon: add user space API for sizing
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Kameron Lutes <kalutes@google.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org
Cc: Suleiman Souhlal <suleiman@chromium.org>, Charles William Dick <cwd@google.com>, David Stevens <stevensd@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 14.02.22 20:59, Kameron Lutes wrote:
> This new linux API will allow user space applications to directly
> control the size of the virtio-balloon. This is useful in
> situations where the guest must quickly respond to drastically
> increased memory pressure and cannot wait for the host to adjust
> the balloon's size.
> 
> Under the current wording of the Virtio spec, guest driven
> behavior such as this is permitted:
> 
> VIRTIO Version 1.1 Section 5.5.6
> "The device is driven either by the receipt of a configuration
> change notification, or by changing guest memory needs, such as
> performing memory compaction or responding to out of memory
> conditions."

Not quite. num_pages is determined by the hypervisor only and the guest
is not expected to change it, and if it does, it's ignored.

5.5.6 does not indicate at all that the guest may change it or that it
would have any effect. num_pages is examined only, actual is updated by
the driver.

5.5.6.1 documents what's allowed, e.g.,

  The driver SHOULD supply pages to the balloon when num_pages is
  greater than the actual number of pages in the balloon.

  The driver MAY use pages from the balloon when num_pages is less than
  the actual number of pages in the balloon.

and special handling for VIRTIO_BALLOON_F_DEFLATE_ON_OOM.

Especially, we have

  The driver MUST update actual after changing the number of pages in
  the balloon.

  The driver MAY update actual once after multiple inflate and deflate
  operations.

That's also why QEMU never syncs back the num_pages value from the guest
when writing the config.


Current spec does not allow for what you propose.


> 
> The intended use case for this API is one where the host
> communicates a deflation limit to the guest. The guest may then
> choose to respond to memory pressure by deflating its balloon down
> to the guest's allowable limit.

It would be good to have a full proposal and a proper spec update. I'd
assume you'd want separate values for soft vs. hard num_values -- if
that's what we really want.

BUT

There seems to be recent interest in handling memory pressure in a
better way (although how to really detect "serious memory pressure" vs
"ordinary reclaim" in Linux is still to be figured out). There is
already a discussion going on how that could happen. Adding random user
space toggles might not be the best idea. We might want a single
mechanism to achieve that.

https://lists.oasis-open.org/archives/virtio-comment/202201/msg00139.html

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

